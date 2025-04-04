package Servlet;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.net.*;

import org.json.JSONObject;

import DAO.UserDAO;

@WebServlet("/GoogleLoginServlet")
public class GoogleLoginServlet extends HttpServlet {
    private static final String CLIENT_ID = System.getenv("GOOGLE_CLIENT_ID");
    private static final String CLIENT_SECRET = System.getenv("GOOGLE_CLIENT_SECRET");
    private static final String REDIRECT_URI = "http://everywear.ddns.net/JSPTP/GoogleLoginServlet";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String code = request.getParameter("code");
        if (code == null || code.isEmpty()) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // 1. access_token 요청
            String tokenURL = "https://oauth2.googleapis.com/token";
            String params = "code=" + code
                          + "&client_id=" + CLIENT_ID
                          + "&client_secret=" + CLIENT_SECRET
                          + "&redirect_uri=" + REDIRECT_URI
                          + "&grant_type=authorization_code";

            String tokenResponse = sendPostRequest(tokenURL, params);
            JSONObject tokenJson = new JSONObject(tokenResponse);
            String accessToken = tokenJson.getString("access_token");

            // 2. 사용자 정보 요청
            String userInfoResponse = sendGetRequest("https://www.googleapis.com/oauth2/v2/userinfo", accessToken);
            JSONObject userJson = new JSONObject(userInfoResponse);
            String email = userJson.getString("email");
            String name = userJson.getString("name");

            HttpSession session = request.getSession();
            String sessionId = (String) session.getAttribute("id");
            String sessionType = (String) session.getAttribute("userType");

            UserDAO userDao = new UserDAO();

            if ("Google".equals(sessionType) && email.equals(sessionId)) {
                // 동일한 Google 로그인 세션이 이미 존재함
                System.out.println("세션 로그인 상태");
                response.sendRedirect("main.jsp");
                return;
            }

            if (userDao.isSocialUserExists(email, "Google")) {
                // 이미 가입한 구글 계정
                session.setAttribute("id", email);
                session.setAttribute("userType", "Google");
                System.out.println("이미 가입한 계정");
                response.sendRedirect("main.jsp");
            } else {
                // 첫 가입
                userDao.insertSocialUser(email, name, "Google");
                session.setAttribute("id", email);
                session.setAttribute("userType", "Google");
                System.out.println("첫 가입");
                response.sendRedirect("main.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private String sendPostRequest(String urlStr, String params) throws IOException {
        URL url = new URL(urlStr);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

        try (OutputStream os = conn.getOutputStream()) {
            os.write(params.getBytes("utf-8"));
        }

        return getResponse(conn);
    }

    private String sendGetRequest(String urlStr, String accessToken) throws IOException {
        URL url = new URL(urlStr);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Authorization", "Bearer " + accessToken);

        return getResponse(conn);
    }

    private String getResponse(HttpURLConnection conn) throws IOException {
        try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"))) {
            StringBuilder response = new StringBuilder();
            String responseLine;
            while ((responseLine = br.readLine()) != null) {
                response.append(responseLine.trim());
            }
            return response.toString();
        }
    }
}
