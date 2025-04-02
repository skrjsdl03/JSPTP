package DAO;

import java.net.InetAddress;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Vector;

import DTO.UserAddrDTO;
import DTO.UserDTO;

public class UserDAO {
	
	private DBConnectionMgr pool;
	
	private final SimpleDateFormat SDF_DATE =
			new SimpleDateFormat("yyyy - MM - dd");
	
	public UserDAO() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//회원가입
	public void insertUser(UserDTO user) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert user values "
					+ "(?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?, ?, ?, 0, 'N', ?, 0, '그린')";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user.getUser_id());
			pstmt.setString(2, user.getUser_pwd());
			pstmt.setString(3, user.getUser_type());
			pstmt.setString(4, user.getUser_name());
			pstmt.setString(5, user.getUser_birth());
			pstmt.setString(6, user.getUser_gender());
			pstmt.setInt(7, user.getUser_height());
			pstmt.setInt(8, user.getUser_weight());
			pstmt.setString(9, user.getUser_email());
			pstmt.setString(10, user.getUser_phone());
			pstmt.setString(11, user.getUser_email() == null ? "이메일 인증 미완료" : "정상");
			pstmt.setString(12, null);
			pstmt.setString(13, user.getUser_marketing_state());
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//기본 배송지 여부 (배송지 추가 후 기본배송지로 할 경우, 기존에 기본 배송지가 있으면 N으로 변경)
	public void isDefaultAddr(String id) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = null;
	    try {
	        con = pool.getConnection();
	        sql = "select addr_id from user_address WHERE user_id = ? and addr_isDefault = 'Y'";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, id);
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            int addrId = rs.getInt("addr_id");
	            rs.close();
	            pstmt.close();

	            sql = "update user_address set addr_isDefault = 'N' where addr_id = ?";
	            pstmt = con.prepareStatement(sql);
	            pstmt.setInt(1, addrId);
	            pstmt.executeUpdate();
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }
	}

	//주소 입력
	public void insertAddr(UserAddrDTO addr, String id, String isDefault) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			if(isDefault.equals("Y")) {
				isDefaultAddr(id);
			}
			con = pool.getConnection();
			sql = "insert user_address values (null, ?, ?, ?, ?, ?, now(), ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, addr.getAddr_zipcode());
			pstmt.setString(3, addr.getAddr_road());
			pstmt.setString(4, addr.getAddr_detail());
			pstmt.setString(5, isDefault);
			pstmt.setString(6, (addr.getAddr_label() == null || addr.getAddr_label() == "") ? 
											addr.getAddr_road() : addr.getAddr_label());
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//아이디 중복 체크
	public boolean idCheck(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select id from user where user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next())
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	//로그인 (1: 로그인 성공, 2: 로그인 시도, 3: 로그인 실패)
	public String login(String id, String pwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String result = null;
		String log_type = null;
		int cnt = 0;
		try {
			con = pool.getConnection();
			if(idCheck(id)) {	//아이디 존재
				if(checkLock(id)) {	//계정 잠금 여부 Y
					log_type = "잠긴 계정 로그인 시도";
					result = "lock";
				} else {	//계정 잠금 여부 N
					sql = "select id from user where user_id = ? and user_pwd = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, id);
					pstmt.setString(2, pwd);
					rs = pstmt.executeQuery();
					if(rs.next()) {	//아이디 O, 비밀번호 O  ->  로그인 로그 기록
						result = "success";
						log_type = "로그인";
						cnt = 0;
						updateFailLogin(cnt, id); 	//로그인 실패 횟수 0으로 설정
					} else {	//아이디 O, 비밀번호 X  ->  로그인 시도 로그 기록
						result = "fail";
						log_type = "로그인 시도";
						cnt = showFailLogin(id);
						if(cnt < 5) {
							int cnt2 = cnt+1;
							updateFailLogin(cnt2, id);
							if(cnt2 == 5)
								updateLock("Y", id);
						}
					}
				}
				insertLog(id, log_type);
			} else {	//아이디 존재 X
				result = "none";
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return result;
	}
	
	//계정 잠금 여부 변경
	public void updateLock(String state, String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update user set user_lock_state = ? where user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, state);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//계정 잠금 여부 확인 (Y: true, N: false)
	public boolean checkLock(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select user_lock_state from user where user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equalsIgnoreCase("Y"))
					flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	//로그인 잠금 실패 횟수 출력
	public int showFailLogin(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int cnt = 0;
		try {
			con = pool.getConnection();
			sql = "select user_fail_login from user where user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next())
				cnt = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return cnt;
	}
	
	//로그인 잠금 실패 횟수 수정
	public void updateFailLogin(int cnt, String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update user set user_fail_login = ? where user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cnt);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//로그아웃
	public void logout(String id) {
		insertLog(id, "로그아웃");
	}
	
	
	//로그인, 로그아웃, 로그인 시도  ->  사용자 로그 기록
	public void insertLog(String id, String type) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			InetAddress ip = InetAddress.getLocalHost();
			con = pool.getConnection();
			sql = "insert user_log values (null, ?, now(), ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, type);
			pstmt.setString(3, ip.getHostAddress());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//아이디 찾기 (전화번호) -> 해당하는 아이디가 있으면 (아이디, 등급, 생성일 출력), 없으면 null 리턴
	public Vector<UserDTO> findIdByPhone(String name, String phone) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<UserDTO> vlist = null;
		try {
			con = pool.getConnection();
			sql = "select user_id, user_rank, created_at from user "
					+ "where user_name = ? and user_phone = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, phone);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vlist = new Vector<UserDTO>();
				UserDTO user = new UserDTO();
				user.setUser_id(rs.getString(1));
				user.setUser_rank(rs.getString(2));
				user.setCreated_at(SDF_DATE.format(rs.getTimestamp(3)));
				vlist.add(user);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//아이디 찾기 (이메일) -> 해당하는 아이디가 있으면 (아이디, 등급, 생성일 출력), 없으면 null 리턴
	public Vector<UserDTO> findIdByEmail(String name, String email) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<UserDTO> vlist = null;
		try {
			con = pool.getConnection();
			sql = "select user_id, user_rank, created_at from user "
					+ "where user_name = ? and user_email = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, email);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vlist = new Vector<UserDTO>();
				UserDTO user = new UserDTO();
				user.setUser_id(rs.getString(1));
				user.setUser_rank(rs.getString(2));
				user.setCreated_at(SDF_DATE.format(rs.getTimestamp(3)));
				vlist.add(user);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//비밀번호 찾기 (전화번호)
	public boolean findPwdByPhone(String id, String name, String phone) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select * from user where user_id = ? and user_name = ? and user_phone = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, name);
			pstmt.setString(3, phone);
			rs = pstmt.executeQuery();
			if(rs.next()) 
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	//비밀번호 찾기 (이메일)
	public boolean findPwdByEmail(String id, String name, String email) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select * from user where user_id = ? and user_name = ? and user_email = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, name);
			pstmt.setString(3, email);
			rs = pstmt.executeQuery();
			if(rs.next()) 
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	//비밀번호 변경
	public void updatePwd(String id, String pwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update user set user_pwd = ? where user_id = ?";
			pstmt = con.prepareStatement(sql); 
			pstmt.setString(1, pwd);
			pstmt.setString(2, id);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
}
