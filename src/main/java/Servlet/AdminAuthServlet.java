package Servlet;

import DAO.GmailSend;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;

@WebServlet("/AdminAuthServlet")
public class AdminAuthServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String adminEmail = request.getParameter("email");
        HttpSession session = request.getSession();

        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();

        // 인증번호 생성 (6자리)
        String code = String.format("%06d", new Random().nextInt(1000000));

        try {
            // 메일 전송
            String title = "[EVERYWEAR 관리자 인증번호]";
            String content = "인증번호는 <b>" + code + "</b> 입니다. (5분 이내 입력)";
            GmailSend.send(title, content, adminEmail);

            // 인증번호 세션 저장 (5분 유지)
            session.setAttribute("verifyCode", code);
            session.setMaxInactiveInterval(300); // 300초 = 5분

            out.print("{\"success\": true}");
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"메일 전송 실패\"}");
        }
    }
}
