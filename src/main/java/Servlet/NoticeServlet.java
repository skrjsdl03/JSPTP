package Servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.NoticeDAO;
import DTO.NoticeDTO;

@WebServlet("/NoticeServlet")
public class NoticeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    public NoticeServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("admin_notice.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        NoticeDAO noticeDAO = new NoticeDAO();
        
        String redirectUrl = "admin_notice.jsp";
        
        try {
            if ("insert".equals(action)) {
                // 새 공지사항 작성
                String adminId = "1"; // 실제로는 세션에서 관리자 ID를 가져와야 함
                String noticeTitle = request.getParameter("noticeTitle");
                String noticeContent = request.getParameter("noticeContent");
                String isPinned = request.getParameter("noticeStatus");
                
                NoticeDTO notice = new NoticeDTO();
                notice.setAdmin_id(adminId);
                notice.setNoti_title(noticeTitle);
                notice.setContent(noticeContent);
                notice.setNoti_isPinned(isPinned);
                
                boolean result = noticeDAO.insertNotice(notice);
                
                if (result) {
                    redirectUrl += "?success=insert";
                } else {
                    redirectUrl += "?error=insert";
                }
                
            } else if ("update".equals(action)) {
                // 공지사항 수정
                int noticeId = Integer.parseInt(request.getParameter("noticeId"));
                String noticeTitle = request.getParameter("noticeTitle");
                String noticeContent = request.getParameter("noticeContent");
                String isPinned = request.getParameter("noticeStatus");
                
                NoticeDTO notice = new NoticeDTO();
                notice.setNoti_id(noticeId);
                notice.setNoti_title(noticeTitle);
                notice.setContent(noticeContent);
                notice.setNoti_isPinned(isPinned);
                
                boolean result = noticeDAO.updateNotice(notice);
                
                if (result) {
                    redirectUrl += "?success=update";
                } else {
                    redirectUrl += "?error=update";
                }
                
            } else if ("delete".equals(action)) {
                // 공지사항 삭제
                String deleteIds = request.getParameter("deleteIds");
                String[] ids = deleteIds.split(",");
                
                boolean allSuccess = true;
                
                for (String id : ids) {
                    int noticeId = Integer.parseInt(id.trim());
                    boolean result = noticeDAO.deleteNotice(noticeId);
                    
                    if (!result) {
                        allSuccess = false;
                    }
                }
                
                if (allSuccess) {
                    redirectUrl += "?success=delete";
                } else {
                    redirectUrl += "?error=delete";
                }
                
            } else if ("updateStatus".equals(action)) {
                // 공지사항 상태 변경 (중요/일반)
                String statusIds = request.getParameter("statusIds");
                String statusValue = request.getParameter("statusValue");
                String[] ids = statusIds.split(",");
                
                boolean allSuccess = true;
                
                for (String id : ids) {
                    int noticeId = Integer.parseInt(id.trim());
                    boolean result = noticeDAO.togglePinStatus(noticeId, statusValue);
                    
                    if (!result) {
                        allSuccess = false;
                    }
                }
                
                if (allSuccess) {
                    redirectUrl += "?success=status";
                } else {
                    redirectUrl += "?error=status";
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            redirectUrl += "?error=system";
        }
        
        response.sendRedirect(redirectUrl);
    }
} 