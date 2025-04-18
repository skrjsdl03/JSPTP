package DAO;

import java.sql.*;
import java.util.*;

public class AdminDeliveryDAO {
    private DBConnectionMgr pool;
    
    public AdminDeliveryDAO() {
        pool = DBConnectionMgr.getInstance();
    }
    
    // 배송 목록 조회 (페이징 포함)
    public List<Map<String, Object>> getDeliveryList(int start, int pageSize) {
        List<Map<String, Object>> deliveryList = new ArrayList<>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            con = pool.getConnection();
            String sql = "SELECT d.*, o.o_num, o.o_name, o.o_phone " +
                         "FROM delivery d " +
                         "JOIN orders o ON d.o_id = o.o_id " +
                         "ORDER BY d.d_id DESC LIMIT ?, ?";
            
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, start);
            pstmt.setInt(2, pageSize);
            
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
                Map<String, Object> delivery = new HashMap<>();
                
                delivery.put("d_id", rs.getInt("d_id"));
                delivery.put("o_id", rs.getInt("o_id"));
                delivery.put("o_num", rs.getString("o_num"));
                delivery.put("o_name", rs.getString("o_name"));
                delivery.put("d_name", rs.getString("d_name"));
                delivery.put("recv_name", rs.getString("recv_name"));
                delivery.put("recv_phone", rs.getString("recv_phone"));
                delivery.put("recv_zipcode", rs.getString("recv_zipcode"));
                delivery.put("recv_addr_road", rs.getString("recv_addr_road"));
                delivery.put("recv_addr_detail", rs.getString("recv_addr_detail"));
                delivery.put("d_status", rs.getString("d_status"));
                delivery.put("d_courier", rs.getString("d_courier"));
                delivery.put("d_tracking_num", rs.getString("d_tracking_num"));
                delivery.put("shipped_at", rs.getTimestamp("shipped_at"));
                delivery.put("started_at", rs.getTimestamp("started_at"));
                delivery.put("completed_at", rs.getTimestamp("completed_at"));
                delivery.put("d_memo", rs.getString("d_memo"));
                
                deliveryList.add(delivery);
            }
            
        } catch (Exception e) {
            System.out.println("getDeliveryList 오류: " + e.getMessage());
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        
        return deliveryList;
    }
    
    // 배송 정보 검색 (송장번호로 검색)
    public List<Map<String, Object>> searchDeliveryByTrackingNumber(String trackingNumber) {
        List<Map<String, Object>> deliveryList = new ArrayList<>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            con = pool.getConnection();
            String sql = "SELECT d.*, o.o_num, o.o_name, o.o_phone " +
                         "FROM delivery d " +
                         "JOIN orders o ON d.o_id = o.o_id " +
                         "WHERE d.d_tracking_num LIKE ? " +
                         "ORDER BY d.d_id DESC";
            
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, "%" + trackingNumber + "%");
            
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
                Map<String, Object> delivery = new HashMap<>();
                
                delivery.put("d_id", rs.getInt("d_id"));
                delivery.put("o_id", rs.getInt("o_id"));
                delivery.put("o_num", rs.getString("o_num"));
                delivery.put("o_name", rs.getString("o_name"));
                delivery.put("d_name", rs.getString("d_name"));
                delivery.put("recv_name", rs.getString("recv_name"));
                delivery.put("recv_phone", rs.getString("recv_phone"));
                delivery.put("recv_zipcode", rs.getString("recv_zipcode"));
                delivery.put("recv_addr_road", rs.getString("recv_addr_road"));
                delivery.put("recv_addr_detail", rs.getString("recv_addr_detail"));
                delivery.put("d_status", rs.getString("d_status"));
                delivery.put("d_courier", rs.getString("d_courier"));
                delivery.put("d_tracking_num", rs.getString("d_tracking_num"));
                delivery.put("shipped_at", rs.getTimestamp("shipped_at"));
                delivery.put("started_at", rs.getTimestamp("started_at"));
                delivery.put("completed_at", rs.getTimestamp("completed_at"));
                delivery.put("d_memo", rs.getString("d_memo"));
                
                deliveryList.add(delivery);
            }
            
        } catch (Exception e) {
            System.out.println("searchDeliveryByTrackingNumber 오류: " + e.getMessage());
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        
        return deliveryList;
    }
    
    // 배송 상태별 목록 조회
    public List<Map<String, Object>> getDeliveryListByStatus(String status) {
        List<Map<String, Object>> deliveryList = new ArrayList<>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            con = pool.getConnection();
            String sql = "SELECT d.*, o.o_num, o.o_name, o.o_phone " +
                         "FROM delivery d " +
                         "JOIN orders o ON d.o_id = o.o_id " +
                         "WHERE d.d_status = ? " +
                         "ORDER BY d.d_id DESC";
            
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, status);
            
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
                Map<String, Object> delivery = new HashMap<>();
                
                delivery.put("d_id", rs.getInt("d_id"));
                delivery.put("o_id", rs.getInt("o_id"));
                delivery.put("o_num", rs.getString("o_num"));
                delivery.put("o_name", rs.getString("o_name"));
                delivery.put("d_name", rs.getString("d_name"));
                delivery.put("recv_name", rs.getString("recv_name"));
                delivery.put("recv_phone", rs.getString("recv_phone"));
                delivery.put("recv_zipcode", rs.getString("recv_zipcode"));
                delivery.put("recv_addr_road", rs.getString("recv_addr_road"));
                delivery.put("recv_addr_detail", rs.getString("recv_addr_detail"));
                delivery.put("d_status", rs.getString("d_status"));
                delivery.put("d_courier", rs.getString("d_courier"));
                delivery.put("d_tracking_num", rs.getString("d_tracking_num"));
                delivery.put("shipped_at", rs.getTimestamp("shipped_at"));
                delivery.put("started_at", rs.getTimestamp("started_at"));
                delivery.put("completed_at", rs.getTimestamp("completed_at"));
                delivery.put("d_memo", rs.getString("d_memo"));
                
                deliveryList.add(delivery);
            }
            
        } catch (Exception e) {
            System.out.println("getDeliveryListByStatus 오류: " + e.getMessage());
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        
        return deliveryList;
    }
    
    // 전체 배송 개수 조회
    public int getTotalDeliveryCount() {
        int count = 0;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            con = pool.getConnection();
            String sql = "SELECT COUNT(*) FROM delivery";
            
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
                count = rs.getInt(1);
            }
            
        } catch (Exception e) {
            System.out.println("getTotalDeliveryCount 오류: " + e.getMessage());
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        
        return count;
    }
    
    // 배송 상태 업데이트
    public boolean updateDeliveryStatus(int d_id, String status) {
        Connection con = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            con = pool.getConnection();
            String sql = "UPDATE delivery SET d_status = ?";
            
            // 배송 상태에 따라 날짜 업데이트
            if ("배송준비중".equals(status)) {
                sql += ", shipped_at = NOW(), started_at = NULL, completed_at = NULL";
            } else if ("배송중".equals(status)) {
                sql += ", started_at = NOW(), completed_at = NULL";
            } else if ("배송완료".equals(status)) {
                sql += ", completed_at = NOW()";
            }
            
            sql += " WHERE d_id = ?";
            
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, status);
            pstmt.setInt(2, d_id);
            
            int affectedRows = pstmt.executeUpdate();
            if(affectedRows > 0) {
                success = true;
            }
            
        } catch (Exception e) {
            System.out.println("updateDeliveryStatus 오류: " + e.getMessage());
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt);
        }
        
        return success;
    }
    
    // 배송 정보 업데이트 (송장번호, 택배사 등)
    public boolean updateDeliveryInfo(int d_id, String courier, String trackingNum, String memo) {
        Connection con = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            con = pool.getConnection();
            String sql = "UPDATE delivery SET d_courier = ?, d_tracking_num = ?, d_memo = ? WHERE d_id = ?";
            
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, courier);
            pstmt.setString(2, trackingNum);
            pstmt.setString(3, memo);
            pstmt.setInt(4, d_id);
            
            int affectedRows = pstmt.executeUpdate();
            if(affectedRows > 0) {
                success = true;
            }
            
        } catch (Exception e) {
            System.out.println("updateDeliveryInfo 오류: " + e.getMessage());
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt);
        }
        
        return success;
    }
    
    // 일괄 배송 상태 업데이트
    public boolean updateMultipleDeliveryStatus(int[] d_ids, String status) {
        Connection con = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            con = pool.getConnection();
            
            // 트랜잭션 시작
            con.setAutoCommit(false);
            
            String sql = "UPDATE delivery SET d_status = ?";
            
            // 배송 상태에 따라 날짜 업데이트
            if ("배송준비중".equals(status)) {
                sql += ", shipped_at = NOW(), started_at = NULL, completed_at = NULL";
            } else if ("배송중".equals(status)) {
                sql += ", started_at = NOW(), completed_at = NULL";
            } else if ("배송완료".equals(status)) {
                sql += ", completed_at = NOW()";
            }
            
            sql += " WHERE d_id = ?";
            
            pstmt = con.prepareStatement(sql);
            
            int successCount = 0;
            for (int d_id : d_ids) {
                pstmt.setString(1, status);
                pstmt.setInt(2, d_id);
                
                int affectedRows = pstmt.executeUpdate();
                if (affectedRows > 0) {
                    successCount++;
                }
            }
            
            if (successCount == d_ids.length) {
                con.commit();
                success = true;
            } else {
                con.rollback();
            }
            
        } catch (Exception e) {
            try {
                if (con != null) {
                    con.rollback();
                }
            } catch (SQLException e2) {
                e2.printStackTrace();
            }
            System.out.println("updateMultipleDeliveryStatus 오류: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (con != null) {
                    con.setAutoCommit(true);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            pool.freeConnection(con, pstmt);
        }
        
        return success;
    }
} 