package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.NoticeDAO;
import DTO.NoticeDTO;

@WebServlet("/NoticeServlet")
public class NoticeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    public NoticeServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        String action = request.getParameter("action");
        
        if (action == null || action.isEmpty()) {
            response.sendRedirect("admin_notice.jsp");
            return;
        }
        
        try {
            if ("getContent".equals(action)) {
                int noticeId = Integer.parseInt(request.getParameter("id"));
                NoticeDAO noticeDAO = new NoticeDAO();
                NoticeDTO notice = noticeDAO.getNotice(noticeId);
                
                if (notice != null) {
                    response.setContentType("text/plain; charset=UTF-8");
                    PrintWriter out = response.getWriter();
                    out.print(notice.getContent());
                    out.flush();
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                }
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error: " + e.getMessage());
            return;
        }
        
        response.sendRedirect("admin_notice.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        String action = request.getParameter("action");
        NoticeDAO noticeDAO = new NoticeDAO();
        
        String redirectUrl = "admin_notice.jsp";
        
        try {
            System.out.println("NoticeServlet - Action: " + action);
            
            // 세션에서 관리자 ID 가져오기 시도
            HttpSession session = request.getSession();
            String adminId = (String) session.getAttribute("adminId");
            
            // 세션에 관리자 ID가 없으면 기본값 사용 (실제 DB에 존재하는 값으로 설정)
            if (adminId == null || adminId.isEmpty()) {
                // admin 테이블에 실제 존재하는 "admin_id" 값으로 설정
                adminId = "1"; // 데이터베이스에 실제 존재하는 관리자 ID
            }
            
            System.out.println("Admin ID: " + adminId); // 디버깅용 로그
            
            if ("insert".equals(action)) {
                // 새 공지사항 작성
                String noticeTitle = request.getParameter("noticeTitle");
                String noticeContent = request.getParameter("noticeContent");
                String isPinned = request.getParameter("noticeStatus");
                
                System.out.println("Insert Notice - Title: " + noticeTitle);
                System.out.println("Insert Notice - Content: " + noticeContent);
                System.out.println("Insert Notice - Is Pinned: " + isPinned);
                
                try {
                    NoticeDTO notice = new NoticeDTO();
                    notice.setAdmin_id(adminId);
                    notice.setNoti_title(noticeTitle);
                    notice.setContent(noticeContent);
                    notice.setNoti_isPinned(isPinned);
                    
                    boolean result = noticeDAO.insertNotice(notice);
                    
                    if (result) {
                        System.out.println("Notice inserted successfully!");
                        redirectUrl += "?success=insert";
                    } else {
                        System.out.println("Notice insertion failed!");
                        redirectUrl += "?error=insert";
                    }
                } catch (Exception e) {
                    System.out.println("Error in insertNotice: " + e.getMessage());
                    e.printStackTrace();
                    redirectUrl += "?error=insert&message=" + e.getMessage();
                }
                
            } else if ("update".equals(action)) {
                // 공지사항 수정
                int noticeId = Integer.parseInt(request.getParameter("noticeId"));
                String noticeTitle = request.getParameter("noticeTitle");
                String noticeContent = request.getParameter("noticeContent");
                String isPinned = request.getParameter("noticeStatus");
                
                System.out.println("Update Notice - ID: " + noticeId);
                
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
                
                if (deleteIds != null && !deleteIds.trim().isEmpty()) {
                    String[] ids = deleteIds.split(",");
                    
                    boolean allSuccess = true;
                    
                    for (String id : ids) {
                        int noticeId = Integer.parseInt(id.trim());
                        System.out.println("Delete Notice - ID: " + noticeId);
                        
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
                } else {
                    redirectUrl += "?error=delete&message=no_ids";
                }
                
            } else if ("updateStatus".equals(action)) {
                // 공지사항 상태 변경 (중요/일반)
                String statusIds = request.getParameter("statusIds");
                String statusValue = request.getParameter("statusValue");
                
                if (statusIds != null && !statusIds.trim().isEmpty()) {
                    String[] ids = statusIds.split(",");
                    
                    boolean allSuccess = true;
                    
                    for (String id : ids) {
                        int noticeId = Integer.parseInt(id.trim());
                        System.out.println("Update Status - ID: " + noticeId + ", Value: " + statusValue);
                        
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
                } else {
                    redirectUrl += "?error=status&message=no_ids";
                }
            } else {
                // 알 수 없는 액션
                System.out.println("Unknown action: " + action);
                redirectUrl += "?error=unknown_action";
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error in NoticeServlet: " + e.getMessage());
            redirectUrl += "?error=system&message=" + e.getMessage();
        }
        
        // 페이지 리다이렉트
        response.sendRedirect(redirectUrl);
    }
} 