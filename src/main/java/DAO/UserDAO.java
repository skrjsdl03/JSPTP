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
	
	private final SimpleDateFormat SDF_DATE = new SimpleDateFormat("yyyy-MM-dd");
	
	public UserDAO() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//회원가입
	public void insertUser(UserDTO user, UserAddrDTO addr) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert user values "
					+ "(?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?, '정상', ?, 0, 'N', ?, ?, '그린')";
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
			pstmt.setString(11, null);
			pstmt.setString(12, user.getUser_marketing_state());
			pstmt.setInt(13, user.getUser_point());
			pstmt.executeUpdate();
			insertAddr(addr, user.getUser_id(), "Y");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//추천인 적립금
	public void updatePoint(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update user set user_point = user_point + 3000 where user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
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
			sql = "select user_id from user where user_id = ?";
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
	
	// 소셜회원 중복체크
	public boolean isSocialUserExists(String id, String type) {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    boolean exists = false;

	    try {
	        conn = pool.getConnection(); // 기존 UserDAO에 정의된 DB 연결 메서드 사용
	        String sql = "SELECT 1 FROM user WHERE user_id = ? AND user_type = ?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, id);
	        pstmt.setString(2, type);
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            exists = true; // 사용자 존재
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(conn, pstmt, rs);
	    }
	    System.out.println("id = " + id + ", type = " + type);
	    System.out.println("exists = " + exists);
	    return exists;
	}

	
	//로그인 (success : 로그인 성공), (fail : 로그인 실패), (none :  아이디 존재 X), (resign : 탈퇴 아이디 로그인), (human : 휴먼 계정), (lock : 5회이상 실패로 인한 잠금)
	public String login(String id, String pwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String result = "";
		String log_type = "";
		int cnt = 0;
		try {
			con = pool.getConnection();
			if(idCheck(id)) {	//아이디 존재
				if(checkLock(id)) {	//계정 잠금 여부 Y
					if(showAccountState(id).equals("탈퇴")) {
						result = "resign";
						return result;
					} else if(showAccountState(id).equals("휴먼")){
						result = "human";
						return result;
					}
					log_type = "잠긴 계정 로그인 시도";
					result = "lock";
				} else {	//계정 잠금 여부 N
					sql = "select user_id from user where user_id = ? and user_pwd = ?";
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
							if(cnt2 == 5) {
								updateLock("Y", id);
								updateAccountState(id, "로그인 연속 실패로 인한 잠금");
							}
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
	
	//계정상태 출력
	public String showAccountState(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String state = "";
		try {
			con = pool.getConnection();
			sql = "select user_account_state from user where user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next())
				state = rs.getString(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return state;
	}
	
	//계정상태 변경
	public void updateAccountState(String id, String state) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update user set user_account_state = ? where user_id = ?";
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
				if(rs.getString(1).equals("Y"))
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
		Vector<UserDTO> vlist  = new Vector<UserDTO>();
		try {
			con = pool.getConnection();
			sql = "select user_id, user_rank, created_at from user "
					+ "where user_name = ? and user_phone = ? and user_type = '일반'";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, phone);
			rs = pstmt.executeQuery();
			while(rs.next()) {
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
	
	//회원 수정
	public void updateUser(UserDTO user, String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update user set user_pwd = ?, user_name = ?, user_phone = ?, user_email = ?, user_gender = ?, user_height = ?, user_weight = ?, user_birth = ?"
					+ "where user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1 , user.getUser_pwd());
			pstmt.setString(2, user.getUser_name());
			pstmt.setString(3, user.getUser_phone());
			pstmt.setString(4, user.getUser_email());
			pstmt.setString(5, user.getUser_gender());
			pstmt.setInt(6, user.getUser_height());
			pstmt.setInt(7, user.getUser_weight());
			pstmt.setString(8, user.getUser_birth());
			pstmt.setString(9, id);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//회원 수정(소셜 로그인)
	public void updateSocialUser(UserDTO user, String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update user set user_name = ?, user_phone = ?, user_email = ?, user_gender = ?, user_height = ?, user_weight = ?, user_birth = ?"
					+ "where user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user.getUser_name());
			pstmt.setString(2, user.getUser_phone());
			pstmt.setString(3, user.getUser_email());
			pstmt.setString(4, user.getUser_gender());
			pstmt.setInt(5, user.getUser_height());
			pstmt.setInt(6, user.getUser_weight());
			pstmt.setString(7, user.getUser_birth());
			pstmt.setString(8, id);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//회원 탈퇴
	public void deleteUser(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update user set user_account_state = ?, user_wd_date = now(), user_lock_state = ? where user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "탈퇴");
			pstmt.setString(2, "Y");
			pstmt.setString(3, id);
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
		        sql = "select addr_id from user_address where user_id = ? and addr_isDefault = 'Y'";
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
	
	//전체 배송지 출력 (기본 배송지가 가장 먼저 나오고 나머지 주소들은 생성일 순서대로 출력)
	public Vector<UserAddrDTO> showAllAddr(String id){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<UserAddrDTO> vlist = new Vector<UserAddrDTO>();
		try {
			con = pool.getConnection();
			sql = "select * from user_address where user_id = ? order by (addr_isDefault = 'Y') desc, created_at desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vlist.add(new UserAddrDTO
						(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), 
								rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8)));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//기본 배송지 출력
	public UserAddrDTO showOneAddr(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		UserAddrDTO addr = null;
		try {
			con = pool.getConnection();
			sql = "select * from user_address where user_id = ? and addr_isDefault = 'Y'";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				addr = new UserAddrDTO
						(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), 
								rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return addr;
	}
	
	//기본배송지 제외 리스트 출력
	public Vector<UserAddrDTO> showRestAddr(String id){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<UserAddrDTO> vlist = new Vector<UserAddrDTO>();
		try {
			con = pool.getConnection();
			sql = "select * from user_address where user_id = ? and addr_isDefault = 'N' order by created_at desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vlist.add(new UserAddrDTO
						(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), 
								rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8)));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//배송지 수정
	public void updateAddr(String id, int addr_id, UserAddrDTO addr) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			if(addr.getAddr_isDefault().equals("Y"))
				isDefaultAddr(id);
			con = pool.getConnection();
			sql = "update user_address set "
					+ "addr_zipcode = ?, addr_road = ?, addr_detail = ?, addr_isDefault = ?, addr_label = ? where addr_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, addr.getAddr_zipcode());
			pstmt.setString(2, addr.getAddr_road());
			pstmt.setString(3, addr.getAddr_detail());
			pstmt.setString(4, addr.getAddr_isDefault());
			pstmt.setString(5, (addr.getAddr_label() == null || addr.getAddr_label() == "") ? 
											addr.getAddr_road() : addr.getAddr_label());
			pstmt.setInt(6, addr_id);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//배송지 삭제 (기본 배송지 : false, 나머지 배송지 : true)
	public boolean deleteAddr(int addr_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select addr_isDefault from user_address where addr_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, addr_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String isDefault = rs.getString(1);
				rs.close();
	            pstmt.close();
	            
	            if(isDefault.equals("Y"))
	            	return false;
	            else {
	            	sql = "delete from user_address where addr_id = ?";
	            	pstmt = con.prepareStatement(sql);
	    			pstmt.setInt(1, addr_id);
	    			if(pstmt.executeUpdate() == 1)
	    				flag = true;
	            }
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
}
