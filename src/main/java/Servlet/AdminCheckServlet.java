package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.AdminDAO;
import DTO.AdminDTO;

@WebServlet("/AdminCheckServlet")
public class AdminCheckServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    public AdminCheckServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        AdminDAO adminDAO = new AdminDAO();
        List<AdminDTO> adminList = adminDAO.getAllAdmins();
        
        out.println("<html><head><title>관리자 계정 확인</title></head><body>");
        out.println("<h1>관리자 계정 정보</h1>");
        
        if (adminList.isEmpty()) {
            out.println("<p>등록된 관리자 계정이 없습니다.</p>");
        } else {
            out.println("<table border='1'>");
            out.println("<tr><th>ID</th><th>이름</th><th>권한</th><th>이메일</th><th>로그인 실패</th><th>잠금 상태</th></tr>");
            
            for (AdminDTO admin : adminList) {
                out.println("<tr>");
                out.println("<td>" + admin.getAdmin_id() + "</td>");
                out.println("<td>" + admin.getAdmin_name() + "</td>");
                out.println("<td>" + admin.getAdmin_roll() + "</td>");
                out.println("<td>" + admin.getAdmin_email() + "</td>");
                out.println("<td>" + admin.getAdmin_fail_login() + "</td>");
                out.println("<td>" + admin.getAdmin_lock_state() + "</td>");
                out.println("</tr>");
            }
            
            out.println("</table>");
        }
        
        out.println("<h2>첫 번째 관리자 ID:</h2>");
        String firstAdminId = adminDAO.getFirstAdminId();
        if (firstAdminId != null) {
            out.println("<p>" + firstAdminId + "</p>");
        } else {
            out.println("<p>관리자 계정이 없습니다.</p>");
        }
        
        out.println("</body></html>");
    }
} 