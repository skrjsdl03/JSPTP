package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class PaymentDAO {
		private DBConnectionMgr pool;
		
		public PaymentDAO() {
			pool = DBConnectionMgr.getInstance();
		}
		
		//결제
		public boolean insertPay(String id, String type, String imp_uid, String apply_num, String card_name) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag = false;
			try {
				con = pool.getConnection();
				sql = "insert payment values (null, ?, ?, '결제 완료', now(), ?, ?, ?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, type);
				pstmt.setString(3, imp_uid);
				pstmt.setString(4, apply_num);
				pstmt.setString(5, card_name);
				if(pstmt.executeUpdate() == 1)
					flag = true;

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
		
		//pay_id 가져오기
		public int getPay_id(String id, String type, String imp_uid) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int pay_id = 0;
			try {
				con = pool.getConnection();
				sql = "select pay_id from payment where user_id = ? and user_type = ? and pay_imp_uid = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, type);
				pstmt.setString(3, imp_uid);
				rs = pstmt.executeQuery();
				if(rs.next())
					pay_id = rs.getInt(1);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return pay_id;
		}
}
