package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class DeliveryDAO {
	private DBConnectionMgr pool;
	
	public DeliveryDAO() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//배송 
	public void insertDelivery(int o_id, String alias, String name, String phone, String zipcode, String address1, String address2, String tracking_num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert delivery values (null, ?, ?, ?, ?, ?, ?, ?, '배송 준비중', 'CJ 대한통운', ?, null, null, null, null)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, o_id);
			pstmt.setString(2, alias);
			pstmt.setString(3, name);
			pstmt.setString(4, phone);
			pstmt.setString(5, zipcode);
			pstmt.setString(6, address1);
			pstmt.setString(7, address2);
			pstmt.setString(8, tracking_num);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
}
