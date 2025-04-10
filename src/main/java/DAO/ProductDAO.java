package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class ProductDAO {
	private DBConnectionMgr pool;
	
	public ProductDAO() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public String show() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String a = "";
		try {
			con = pool.getConnection();
			sql = "select p_text from product where p_id = 440";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			if(rs.next()) {
				a = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return a;
	}
	
	public Vector<String> img() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<String> list = new Vector<String>();
		try {
			con = pool.getConnection();
			sql = "select pi_url from product_image where p_id = 421";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			while(rs.next())
				list.add(rs.getString(1));
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return list;
	}
}
