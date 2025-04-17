package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class OrderDAO {
	private DBConnectionMgr pool;
	
	public OrderDAO() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//주문 넣기
	public int insertOrder(String id, String type, int pd_id, String o_num, String isMember, String name, String phone, int quantity, int price, int pay_id) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = null;
	    int generatedOid = -1; // 생성된 o_id 저장할 변수

	    try {
	        con = pool.getConnection();
	        sql = "INSERT INTO orders VALUES (null, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?, ?, null)";
	        pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS); // KEY 반환 옵션 추가

	        pstmt.setString(1, id);
	        pstmt.setString(2, type);
	        pstmt.setInt(3, pd_id);
	        pstmt.setString(4, o_num);
	        pstmt.setString(5, isMember);
	        pstmt.setString(6, name);
	        pstmt.setString(7, phone);
	        pstmt.setInt(8, quantity);
	        pstmt.setInt(9, price);
	        pstmt.setInt(10, pay_id);

	        int affectedRows = pstmt.executeUpdate();

	        if (affectedRows == 1) {
	            rs = pstmt.getGeneratedKeys(); // 생성된 키 가져오기
	            if (rs.next()) {
	                generatedOid = rs.getInt(1); // 첫 번째 키(o_id)
	            }
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }

	    return generatedOid; // -1이면 실패
	}

}
