package DAO;

import DTO.AdminDTO;
import java.net.InetAddress;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AdminDAO {
    private DBConnectionMgr pool;

    public AdminDAO() {
        pool = DBConnectionMgr.getInstance();
    }

    // 로그인 처리 메서드
    public boolean login(String id, String pwd, String email, String inputCode, String sessionCode) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean result = false;

        try {
            con = pool.getConnection();

            if (idCheck(id)) {
                if (checkLock(id)) {
                    insertLog(id, "로그인 시도");
                    return false;
                }

                String sql = "SELECT * FROM admin WHERE admin_id = ? AND admin_pwd = ? AND admin_email = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, id);
                pstmt.setString(2, pwd);
                pstmt.setString(3, email);
                rs = pstmt.executeQuery();

                if (rs.next() && inputCode.equals(sessionCode)) {
                    // 성공
                    insertLog(id, "로그인");
                    updateFailLogin(0, id);  // 실패횟수 초기화
                    result = true;
                } else {
                    insertLog(id, "로그인 시도");
                    int cnt = showFailLogin(id) + 1;
                    updateFailLogin(cnt, id);
                    if (cnt >= 5) {
                        updateLock("Y", id);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }

        return result;
    }

    public boolean idCheck(String id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean exists = false;
        try {
            con = pool.getConnection();
            String sql = "SELECT admin_id FROM admin WHERE admin_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            exists = rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return exists;
    }

    public boolean checkLock(String id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean locked = false;
        try {
            con = pool.getConnection();
            String sql = "SELECT admin_lock_state FROM admin WHERE admin_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            if (rs.next() && rs.getString(1).equals("Y")) {
                locked = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return locked;
    }

    public int showFailLogin(String id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int cnt = 0;
        try {
            con = pool.getConnection();
            String sql = "SELECT admin_fail_login FROM admin WHERE admin_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                cnt = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return cnt;
    }

    public void updateFailLogin(int cnt, String id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        try {
            con = pool.getConnection();
            String sql = "UPDATE admin SET admin_fail_login = ? WHERE admin_id = ?";
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

    public void updateLock(String state, String id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        try {
            con = pool.getConnection();
            String sql = "UPDATE admin SET admin_lock_state = ? WHERE admin_id = ?";
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

    public void insertLog(String id, String type) {
        Connection con = null;
        PreparedStatement pstmt = null;
        try {
            String ip = InetAddress.getLocalHost().getHostAddress();
            con = pool.getConnection();
            String sql = "INSERT INTO admin_log VALUES (NULL, ?, NOW(), ?, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setString(2, type);
            pstmt.setString(3, ip);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt);
        }
    }

    public List<AdminDTO> getAllAdmins() {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<AdminDTO> adminList = new ArrayList<>();
        
        try {
            con = pool.getConnection();
            String sql = "SELECT * FROM admin";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                AdminDTO admin = new AdminDTO();
                admin.setAdmin_id(rs.getString("admin_id"));
                admin.setAdmin_name(rs.getString("admin_name"));
                admin.setAdmin_roll(rs.getString("admin_roll"));
                admin.setAdmin_email(rs.getString("admin_email"));
                admin.setAdmin_fail_login(rs.getInt("admin_fail_login"));
                admin.setAdmin_lock_state(rs.getString("admin_lock_state"));
                adminList.add(admin);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        
        return adminList;
    }
    
    // 첫 번째 관리자 ID 가져오기
    public String getFirstAdminId() {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String adminId = null;
        
        try {
            con = pool.getConnection();
            String sql = "SELECT admin_id FROM admin LIMIT 1";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                adminId = rs.getString("admin_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        
        return adminId;
    }
}
