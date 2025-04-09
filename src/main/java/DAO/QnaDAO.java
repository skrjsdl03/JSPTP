package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Vector;

import DTO.InquiryDTO;

public class QnaDAO {
		private DBConnectionMgr pool;
		
		public QnaDAO() {
			pool = DBConnectionMgr.getInstance();
		}
		
		private final SimpleDateFormat SDF_DATE = new SimpleDateFormat("yyyy-MM-dd");
		
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
}
