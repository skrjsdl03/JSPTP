package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import DTO.ReviewCmtBean;
import DTO.ReviewDTO;
import DTO.ReviewImgDTO;
import DTO.ReviewCmtDTO;

public class ReviewDAO {
	private DBConnectionMgr pool;
	public static final String SAVEFOLDER = "C:/Jsp/JSPTP/src/main/webapp/review_images/";
	public static final String ENCTYPE = "UTF-8";
	public static int MAXSIZE = 5 * 1024 * 1024;
	private final SimpleDateFormat SDF_DATE = new SimpleDateFormat("yyyy-MM-dd");

	public ReviewDAO() {
		pool = DBConnectionMgr.getInstance();
	}

	// 내가 쓴 리뷰 전체 보기
	public Vector<ReviewDTO> showUserReview(String id, String type) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Vector<ReviewDTO> rlist = new Vector<>();
		String sql = "SELECT * FROM review WHERE user_id = ? AND user_type = ? ORDER BY created_at DESC";
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

	// 회원별 리뷰 조회
	public List<ReviewDTO> getReviewsByUser(String id, String type) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ReviewDTO> list = new ArrayList<>();
		try {
			con = pool.getConnection();
			String sql = "SELECT * FROM review WHERE user_id = ? AND user_type = ? ORDER BY created_at DESC";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, type);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ReviewDTO dto = new ReviewDTO();
				dto.setR_id(rs.getInt("r_id"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setUser_type(rs.getString("user_type"));
				dto.setPd_id(rs.getInt("pd_id"));
				dto.setR_content(rs.getString("r_content"));
				dto.setR_rating(rs.getInt("r_rating"));
				dto.setCreated_at(rs.getString("created_at"));
				dto.setUpdated_at(rs.getString("updated_at"));
				dto.setR_report_count(rs.getInt("r_report_count"));
				dto.setR_isHidden(rs.getString("r_isHidden"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return list;
	}

	// 리뷰 이미지 목록
	public List<ReviewImgDTO> getReviewImages(int r_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ReviewImgDTO> list = new ArrayList<>();
		try {
			con = pool.getConnection();
			String sql = "SELECT * FROM review_image WHERE r_id = ? ORDER BY ri_sort_orders ASC";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, r_id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ReviewImgDTO img = new ReviewImgDTO();
				img.setRi_id(rs.getInt("ri_id"));
				img.setR_id(rs.getInt("r_id"));
				img.setRi_url(rs.getString("ri_url"));
				img.setRi_sort_orders(rs.getInt("ri_sort_orders"));
				img.setCreated_at(rs.getString("created_at"));
				list.add(img);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return list;
	}

	// 리뷰 1건 조회
	public ReviewDTO getReviewById(int r_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ReviewDTO review = null;
		try {
			con = pool.getConnection();
			String sql = "SELECT * FROM review WHERE r_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, r_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				review = new ReviewDTO(
					rs.getInt("r_id"),
					rs.getString("user_id"),
					rs.getString("user_type"),
					rs.getInt("pd_id"),
					rs.getString("r_content"),
					rs.getInt("r_rating"),
					rs.getString("created_at"),
					rs.getString("updated_at"),
					rs.getInt("r_report_count"),
					rs.getString("r_isHidden")
				);
      }
    } catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
    return review;
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
	
	// 상품이름 가져오기
	public String getProductNameByPdId(int pd_id) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String name = "(이름없음)";
	    try {
	        con = pool.getConnection();
	        String sql = "SELECT p.p_name FROM product p " +
	                     "JOIN product_detail pd ON p.p_id = pd.p_id " +
	                     "WHERE pd.pd_id = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, pd_id);
	        rs = pstmt.executeQuery();
	        if (rs.next()) name = rs.getString("p_name");
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }
	    return name;
	}

	// 리뷰 댓글 목록
	public List<ReviewCmtDTO> getReviewComments(int r_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ReviewCmtDTO> list = new ArrayList<>();
		try {
			con = pool.getConnection();
			String sql = "SELECT * FROM review_comment WHERE r_id = ? AND rc_isDeleted = 'N' ORDER BY created_at ASC";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, r_id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ReviewCmtDTO cmt = new ReviewCmtDTO();
				cmt.setRc_id(rs.getInt("rc_id"));
				cmt.setR_id(rs.getInt("r_id"));
				cmt.setRc_author_id(rs.getString("rc_author_id"));
				cmt.setRc_author_type(rs.getString("rc_author_type"));
				cmt.setCreated_at(rs.getString("created_at"));
				cmt.setUpdated_at(rs.getString("updated_at"));
				cmt.setRc_isDeleted(rs.getString("rc_isDeleted"));
				list.add(cmt);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
    return list;
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


	// 리뷰 댓글 등록
	public void insertReviewComment(ReviewCmtDTO cmt) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = pool.getConnection();
			String sql = "INSERT INTO review_comment (r_id, rc_author_id, rc_author_type, rc_content, created_at, rc_isDeleted) "
			           + "VALUES (?, ?, ?, ?, NOW(), 'N')";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cmt.getR_id());
			pstmt.setString(2, cmt.getRc_author_id());
			pstmt.setString(3, cmt.getRc_author_type());
			pstmt.setString(4, cmt.getRc_content()); 
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
  return rclist;
}

	// 리뷰 댓글 삭제
	public void deleteReviewComment(int rc_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = pool.getConnection();
			String sql = "UPDATE review_comment SET rc_isDeleted = 'Y', updated_at = NOW() WHERE rc_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rc_id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	// 리뷰 삭제
	public void deleteReview(int r_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = pool.getConnection();
			String sql = "DELETE FROM review WHERE r_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, r_id);
			pstmt.executeUpdate();
    } catch (Exception e) {
    e.printStackTrace();
  } finally {
    pool.freeConnection(con, pstmt);
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

