package DAO;

import java.net.InetAddress;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import DTO.AdminDTO;

public class AdminDAO {

	private DBConnectionMgr pool;

	public AdminDAO() {
		pool = DBConnectionMgr.getInstance();
	}

	// 관리자 로그인
	// return: 1-성공 / 2-비밀번호 틀림 / 3-존재하지 않음 / 4-잠긴 계정
	public int login(String adminId, String pwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		String log_type = null;

		try {
			con = pool.getConnection();
			String sql = "SELECT admin_pwd, admin_fail_login, admin_lock_state FROM admin WHERE admin_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, adminId);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				String dbPwd = rs.getString("admin_pwd");
				int failCount = rs.getInt("admin_fail_login");
				String lockState = rs.getString("admin_lock_state");

				if ("Y".equalsIgnoreCase(lockState)) {
					result = 4;
					log_type = "잠긴계정 로그인 시도";
				} else if (dbPwd.equals(pwd)) {
					result = 1;
					log_type = "로그인";

					// 로그인 성공 시 실패 횟수 초기화
					String resetSql = "UPDATE admin SET admin_fail_login = 0 WHERE admin_id = ?";
					PreparedStatement resetPstmt = con.prepareStatement(resetSql);
					resetPstmt.setString(1, adminId);
					resetPstmt.executeUpdate();
					resetPstmt.close();
				} else {
					result = 2;
					log_type = "로그인 시도";

					// 실패 횟수 +1
					failCount++;
					String updateSql = "UPDATE admin SET admin_fail_login = ?, admin_lock_state = ? WHERE admin_id = ?";
					PreparedStatement updatePstmt = con.prepareStatement(updateSql);
					updatePstmt.setInt(1, failCount);
					updatePstmt.setString(2, (failCount >= 5) ? "Y" : "N");
					updatePstmt.setString(3, adminId);
					updatePstmt.executeUpdate();
					updatePstmt.close();
				}

				insertLog(adminId, log_type);
			} else {
				result = 3; // 존재하지 않는 아이디
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}

		return result;
	}

	// 로그아웃
	public void logout(String adminId) {
		insertLog(adminId, "로그아웃");
	}

	// 관리자 로그 기록
	private void insertLog(String adminId, String type) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			InetAddress ip = InetAddress.getLocalHost();
			con = pool.getConnection();
			String sql = "INSERT INTO admin_log VALUES (NULL, ?, NOW(), ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, adminId);
			pstmt.setString(2, type);
			pstmt.setString(3, ip.getHostAddress());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
}
