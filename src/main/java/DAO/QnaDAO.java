package DAO;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import DTO.InquiryDTO;
import DTO.InquiryImgDTO;
import DTO.InquiryReplyDTO;

public class QnaDAO {
		private DBConnectionMgr pool;
		
		public QnaDAO() {
			pool = DBConnectionMgr.getInstance();
		}
		
		public static final String  SAVEFOLDER = "C:/Jsp/JSPTP/src/main/webapp/Q&A_images/";
		public static final String ENCTYPE = "UTF-8";
		public static int MAXSIZE = 5*1024*1024;
		
		private final SimpleDateFormat SDF_DATE = new SimpleDateFormat("yyyy-MM-dd");
		
		//공통 Q&A 등록
		public void insertQna(String id, HttpServletRequest req) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			MultipartRequest multi = null;
			int i_id = 0;
			try {
				File file = new File(SAVEFOLDER);
				if (!file.exists())
					file.mkdirs();
				
				multi = new MultipartRequest(req, SAVEFOLDER,MAXSIZE, ENCTYPE,
						new DefaultFileRenamePolicy());
				
				String image = multi.getFilesystemName("file");
				
				String isPrivate = multi.getParameter("private");
				String i_isPrivate = "N"; // 기본값

				if (isPrivate != null && isPrivate.equals("on")) {
				    i_isPrivate = "Y"; // 체크되었으면 비공개로 설정
				}
				
				con = pool.getConnection();
				sql = "insert into inquiry (user_id, i_title, i_content,  created_at, i_isPrivate) values (?, ?, ?, now(), ?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, multi.getParameter("title"));
				pstmt.setString(3, multi.getParameter("content"));
				pstmt.setString(4, i_isPrivate);
				pstmt.executeUpdate();
				pstmt.close();
				
				sql = "select max(i_id) from inquiry";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()){
					i_id = rs.getInt(1);
				}
				
				if(image != null && !image.equals("")) {
					pstmt.close();
					rs.close();
					sql = "insert into inquiry_image (i_id, ii_url) values (?, ?)";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, i_id);
					pstmt.setString(2, image);
					pstmt.executeUpdate();
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
			    try { if (rs != null) rs.close(); } catch (Exception e) {}
			    try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
				pool.freeConnection(con, pstmt, rs);
			}
		}
		
		//전체 공통Q&A 출력
		public Vector<InquiryDTO> showAllQna(){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<InquiryDTO> qlist = new Vector<InquiryDTO>();
			try {
				con = pool.getConnection();
				sql = "select * from inquiry where p_id is null and o_id is null order by created_at desc";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					qlist.add(new InquiryDTO(rs.getInt(1), rs.getString(2), 
							rs.getInt(3), rs.getInt(4), rs.getString(5),
							rs.getString(6), SDF_DATE.format(rs.getDate(7)), rs.getString(8), rs.getString(9)));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return qlist;
		}
		
		//한 Q&A 상세 출력
		public InquiryDTO showOneQna(int id) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			InquiryDTO qna = null;
			try {
				con = pool.getConnection();
				sql = "select * from inquiry where i_id = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					qna = new InquiryDTO(rs.getInt(1), rs.getString(2), 
							rs.getInt(3), rs.getInt(4), rs.getString(5), 
							rs.getString(6), SDF_DATE.format(rs.getDate(7)), rs.getString(8), rs.getString(9));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return qna;
		}
		
		//한 Q&A 이미지 출력
		public InquiryImgDTO showOneQnaImage(int id) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			InquiryImgDTO qna = null;
			try {
				con = pool.getConnection();
				sql = "select * from inquiry_image where i_id = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					qna = new InquiryImgDTO(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return qna;
		}
		
		//한 Q&A 댓글 출력
		public InquiryReplyDTO showOneQnaReply(int id) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			InquiryReplyDTO qna = null;
			try {
				con = pool.getConnection();
				sql = "select * from inquiry_reply where i_id = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					qna = new InquiryReplyDTO(
							rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), SDF_DATE.format(rs.getDate(5))); 
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return qna;
		}
		
		//한 Q&A 수정
		public void updateQna(HttpServletRequest req) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql;
			MultipartRequest multi = null;

			try {
				con = pool.getConnection();

				multi = new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCTYPE,
						new DefaultFileRenamePolicy());

				String image = multi.getFilesystemName("file");
				String i_isPrivate = "N";

				if ("on".equals(multi.getParameter("private"))) {
					i_isPrivate = "Y";
				}

				int i_id = Integer.parseInt(multi.getParameter("i_id"));

				// 1. 문의 글 수정
				sql = "UPDATE inquiry SET i_title = ?, i_content = ?, i_isPrivate = ? WHERE i_id = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("title"));
				pstmt.setString(2, multi.getParameter("content"));
				pstmt.setString(3, i_isPrivate);
				pstmt.setInt(4, i_id);
				pstmt.executeUpdate();
				pstmt.close();

				// 2. 이미지 수정
				if (image != null && !image.isEmpty()) {
					// 기존 이미지 삭제
					sql = "SELECT ii_url FROM inquiry_image WHERE i_id = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, i_id);
					rs = pstmt.executeQuery();

					boolean hasImage = false;
					if (rs.next()) {
						hasImage = true;
						String ii_url = rs.getString("ii_url");
						File oldFile = new File(SAVEFOLDER + ii_url);
						if (oldFile.exists()) oldFile.delete();
					}
					rs.close();
					pstmt.close();

					if (hasImage) {
						sql = "UPDATE inquiry_image SET ii_url = ? WHERE i_id = ?";
					} else {
						sql = "INSERT INTO inquiry_image (i_id, ii_url) VALUES (?, ?)";
					}

					pstmt = con.prepareStatement(sql);
					if (hasImage) {
						pstmt.setString(1, image);
						pstmt.setInt(2, i_id);
					} else {
						pstmt.setInt(1, i_id);
						pstmt.setString(2, image);
					}
					pstmt.executeUpdate();
				} else {		//수정으로 파일을 삭제했을때
					// 기존 이미지 삭제
					sql = "SELECT ii_url FROM inquiry_image WHERE i_id = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, i_id);
					rs = pstmt.executeQuery();

					boolean hasImage = false;
					if (rs.next()) {
						hasImage = true;
						String ii_url = rs.getString("ii_url");
						File oldFile = new File(SAVEFOLDER + ii_url);
						if (oldFile.exists()) oldFile.delete();
					}
					rs.close();
					pstmt.close();
					
					if(hasImage) {
						sql = "delete from inquiry_image where i_id = ?";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, i_id);
						pstmt.executeUpdate();
					}
				}

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try { if (rs != null) rs.close(); } catch (Exception e) {}
				try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
				pool.freeConnection(con);
			}
		}

		
		//한 Q&A 삭제
		public void deleteQna(int i_id) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			String ii_url = "";
			try {
				con = pool.getConnection();
				sql = "select ii_url from inquiry_image where i_id = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, i_id);
				rs = pstmt.executeQuery();
				if(rs.next())
					ii_url = rs.getString(1);
				if(ii_url != null) {
					File f = new File(SAVEFOLDER+ii_url);
					if(f.exists())
						f.delete();
				}
				pstmt.close();
				
				sql = "delete from inquiry where i_id = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, i_id);
				pstmt.executeUpdate();

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
		}
}
