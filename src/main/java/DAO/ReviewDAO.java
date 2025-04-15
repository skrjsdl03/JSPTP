package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Vector;

import DTO.ReviewDTO;

public class ReviewDAO {
		
	private DBConnectionMgr pool;
	
	public static final String  SAVEFOLDER = "C:/Jsp/JSPTP/src/main/webapp/review_images/";
	public static final String ENCTYPE = "UTF-8";
	public static int MAXSIZE = 5*1024*1024;
	
	private final SimpleDateFormat SDF_DATE = new SimpleDateFormat("yyyy-MM-dd");
	
	public ReviewDAO() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//내가 쓴 리뷰 전체 보기
	public Vector<ReviewDTO> showUserReview(String id, String type){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ReviewDTO> rlist = new Vector<ReviewDTO>();
		try {
			con = pool.getConnection();
			sql = "select * from review where user_id = ? and user_type = ? order by c";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, type);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				rlist.add(new ReviewDTO(rs.getInt(1), rs.getString(2), 
						rs.getString(3), rs.getInt(4), rs.getString(5), rs.getInt(6),
						SDF_DATE.format(rs.getDate(7)), SDF_DATE.format(rs.getDate(8)), rs.getInt(9), rs.getString(10)));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return rlist;
	}
}
