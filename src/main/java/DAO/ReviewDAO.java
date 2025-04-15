package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Vector;

import DTO.ReviewCmtBean;
import DTO.ReviewDTO;
import DTO.ReviewImgDTO;

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
			sql = "select * from review where user_id = ? and user_type = ? order by coalesce(updated_at, created_at) desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, type);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				rlist.add(new ReviewDTO(rs.getInt(1), rs.getString(2), 
						rs.getString(3), rs.getInt(4), rs.getString(5), rs.getInt(6),
						SDF_DATE.format(rs.getDate(7)), (rs.getDate(8) != null) ? SDF_DATE.format(rs.getDate(8)) : "", 
								rs.getInt(9), rs.getString(10)));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return rlist;
	}
	
	//내가 쓴 리뷰의 이미지
	public Vector<ReviewImgDTO> showUserReviewImg(int r_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ReviewImgDTO> rilist = new Vector<ReviewImgDTO>();
		try {
			con = pool.getConnection();
			sql = "select * from review_image where r_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, r_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				rilist.add(new ReviewImgDTO(rs.getInt(1), rs.getInt(2), 
						rs.getString(3), rs.getInt(4), SDF_DATE.format(rs.getDate(5))));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return rilist;
	}
	
	//내가 쓴 리뷰의 댓글
	public Vector<ReviewCmtBean> showUserReviewCmt(int r_id){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ReviewCmtBean> rclist = new Vector<ReviewCmtBean>();
		try {
			con = pool.getConnection();
			sql = "select * from review_comment where r_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, r_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				rclist.add(new ReviewCmtBean(rs.getInt(1), rs.getInt(2), 
						rs.getString(3), rs.getString(4), SDF_DATE.format(rs.getDate(5)), 
						(rs.getDate(6) != null) ? SDF_DATE.format(rs.getDate(6)) : "", rs.getString(7)));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return rclist;
	}
	
	//내가 쓴 리뷰 수정
	
	
	//내가 쓴 리뷰 삭제
	public boolean deleteReview() {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "delete from ";
			pstmt = con.prepareStatement(sql);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
}
