package Servlet;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.net.*;

import org.json.JSONObject;

import DAO.UserDAO;

@WebServlet("/NaverLoginServlet")
public class NaverLoginServlet extends HttpServlet {
    private static final String CLIENT_ID = System.getenv("NAVER_CLIENT_ID");
    private static final String CLIENT_SECRET = System.getenv("NAVER_CLIENT_SECRET"); 
    private static final String REDIRECT_URI = "http://everywear.duckdns.org/JSPTP/NaverLoginServlet";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String code = request.getParameter("code");
        String state = request.getParameter("state");

        if (code == null || state == null) {
            System.out.println("ERROR: code 또는 state 파라미터가 없음");
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // 1. Access Token 요청
            String tokenUrl = "https://nid.naver.com/oauth2.0/token";
            String params = "grant_type=authorization_code"
                    + "&client_id=" + CLIENT_ID
                    + "&client_secret=" + CLIENT_SECRET
                    + "&redirect_uri=" + URLEncoder.encode(REDIRECT_URI, "UTF-8")
                    + "&code=" + code
                    + "&state=" + state;

            String tokenResponse = sendGetRequest(tokenUrl + "?" + params);
            System.out.println("Access Token 응답: " + tokenResponse);

            JSONObject tokenJson = new JSONObject(tokenResponse);
            String accessToken = tokenJson.getString("access_token");

            // 2. 사용자 정보 요청
            String userInfoJson = getUserInfo(accessToken);
            System.out.println("네이버 사용자 정보 JSON: " + userInfoJson);

            JSONObject userInfo = new JSONObject(userInfoJson);
            JSONObject responseObj = userInfo.getJSONObject("response");

            String email = responseObj.optString("email", null);
            String name = responseObj.optString("name", "");
            String nickname = responseObj.optString("nickname", "");

            if (email == null) {
                throw new Exception("이메일 정보가 없습니다. 네이버 계정에서 이메일 제공 동의가 필요합니다.");
            }

            // 3. 세션 저장
            HttpSession session = request.getSession();
            session.setAttribute("id", email);
            session.setAttribute("userType", "Naver");

            // 4. 가입 여부 확인
            UserDAO userDao = new UserDAO();
            if (userDao.isSocialUserExists(email, "Naver")) {
                System.out.println("이미 가입된 네이버 회원입니다: " + email);
                userDao.insertLog(email, "로그인");
                response.sendRedirect("main.jsp");
            } else {
            	session.setAttribute("id", email);
			    session.setAttribute("userType", "Naver");
            	System.out.println("네이버 첫 로그인 회원입니다: " + email);
                response.sendRedirect("signup.jsp?social=Naver");
            }

        } catch (Exception e) {
            System.out.println("❌ NaverLoginServlet 처리 중 에러 발생:");
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private String sendGetRequest(String urlStr) throws IOException {
        URL url = new URL(urlStr);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");

        return readResponse(conn);
    }

    private String getUserInfo(String accessToken) throws IOException {
        String userInfoUrl = "https://openapi.naver.com/v1/nid/me";
        URL url = new URL(userInfoUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Authorization", "Bearer " + accessToken);

        return readResponse(conn);
    }

    private String readResponse(HttpURLConnection conn) throws IOException {
        try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"))) {
            StringBuilder response = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                response.append(line.trim());
            }
            return response.toString();
        }
    }
}
