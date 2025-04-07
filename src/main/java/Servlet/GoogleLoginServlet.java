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
    private static final String CLIENT_SECRET = System.getenv("GOOGLE_CLIENT_SECRET"); // 환경 변수로 저장 추천
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
            String idToken = tokenJson.getString("id_token"); // 🔹 id_token 추가

            // 2. 사용자 정보 요청
            String userInfoResponse = sendGetRequest("https://www.googleapis.com/oauth2/v2/userinfo", accessToken);
            JSONObject userJson = new JSONObject(userInfoResponse);
            String email = userJson.getString("email");
            String name = userJson.getString("name");

			/*
			 * // 3. 세션 저장 (로그인 처리) HttpSession session = request.getSession();
			 * session.setAttribute("userEmail", email); session.setAttribute("userName",
			 * name);
			 */
            
            HttpSession session = request.getSession();
            String id = (String)session.getAttribute("id");
            if(email.equals(id)) {	//이미 로그인 했을 때
            	response.sendRedirect("main.jsp");
            } else {	//로그인 상태가 아닐때
                UserDAO userDao = new UserDAO();
                if(userDao.idCheck(email)) {	//이미 회원가입 한적 있을 떄
                    response.sendRedirect("main.jsp");
                } else {	//처음 가입할 때
	                userDao.insertSocialUser(email, name, "Google");
	                session.setAttribute("id", email);
	                response.sendRedirect("main.jsp");
                }
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
