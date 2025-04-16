package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Vector;

import DTO.FavoriteDTO;

public class FavoriteDAO {
	private DBConnectionMgr pool;
	
	public FavoriteDAO() {
		pool = DBConnectionMgr.getInstance();
	}
	private final SimpleDateFormat SDF_DATE = new SimpleDateFormat("yyyy-MM-dd");
	
	//한 유저의 장바구니 출력
	public Vector<FavoriteDTO> getUserCart(String id, String type) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<FavoriteDTO> flist = new Vector<FavoriteDTO>();
		try {
			con = pool.getConnection();
			sql = "select * from favorite where user_id = ? and user_type = ? and f_type = '장바구니'";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, type);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				flist.add(new FavoriteDTO(rs.getInt(1), rs.getString(2), rs.getString(3), 
						rs.getInt(4), rs.getString(5), rs.getInt(6), SDF_DATE.format(rs.getDate(7))));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flist;
	}
	
	//한 유저의 장바구니 수정(수량)
	public boolean updateCart(int f_id, int quantity, int pd_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int stock = 0;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select pd_stock from product_detail where pd_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pd_id);
			rs = pstmt.executeQuery();
			if(rs.next())
				stock = rs.getInt(1);
			pstmt.close();
			rs.close();
			
			if(stock >= quantity) {
				sql = "update favorite set f_quantity = ? where f_id = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, quantity);
				pstmt.setInt(2, f_id);
				if(pstmt.executeUpdate() == 1)
					flag = true;
			} else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
}
