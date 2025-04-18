<!-- login.jsp -->
<%@page import="java.net.URLEncoder"%>
<%@page import="DAO.UserDAO"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
		String redirect = request.getParameter("redirect");
		System.out.println(redirect);
		if (redirect == null || redirect.equals("")) {
		    redirect = "main2.jsp"; // 기본 리디렉션
		}else{
			session.setAttribute("redirect", redirect);		
		}
		String errorMessage = "";
		String error = request.getParameter("error");
		int fail = 0;
		
		try{
			fail = Integer.parseInt(request.getParameter("fail"));
		} catch(Exception e){}
		
		if ("noUser".equals(error)) {
		    errorMessage = "아이디가 존재하지 않습니다.";
		} else if ("wrong".equals(error)) {
		    errorMessage = "비밀번호가 틀렸습니다 ( " + fail + " / 5 )";
		} else if("resign".equals(error)){
			errorMessage = "이미 탈퇴한 계정입니다.";
		} else if("human".equals(error)){
			errorMessage = "6개월 이상 접속하지 않아 휴먼계정으로 전환되었습니다.";
		} else if("lock".equals(error)){
			errorMessage = "5회 이상 로그인 실패로 인해 계정이 잠금상태가 되었습니다.";
		}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>로그인 | everyWEAR</title>
<link rel="stylesheet" type="text/css" href="css/login.css?v=2">
  <link rel="stylesheet" type="text/css" href="css/header.css">
  <link rel="icon" type="image/png" href="images/fav-icon.png">
</head>
<body>


<%@ include file="includes/loginHeader.jsp" %>

<div class="login-container">
<form action="login" method="post" autocomplete="off">
  <label for="userId">ID</label>
  <input type="text" id="userId" name="userId" placeholder="아이디를 입력하세요" required>

  <label for="password">PWD</label>
  <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요" required>

  <!-- 아이디/비밀번호 찾기 영역 -->
  <div class="find-links">
  <%if("human".equals(error) || "lock".equals(error)){ %>
   	<a href="lockOutAccount.jsp">잠긴 계정 풀기</a>
   	<span class="divider-bar">|</span>
  <%} %>
    <a href="findId.jsp">아이디 찾기</a>
    <span class="divider-bar">|</span>
    <a href="findPwd.jsp">비밀번호 찾기</a>
  </div>
<input type="hidden" name="redirect" value="<%= redirect %>">
  <button type="submit" class="login-btn">Login</button>
</form>
    <% if (!errorMessage.isEmpty()) { %>
        <p style="font-size: 12px; color: red;"><%= errorMessage %><br></p>
    <% } else{%>
    	<p style="font-size: 12px;">&nbsp;</p>
    <%} %>
  <div class="divider">Or</div>

    <%
        String clientId = System.getenv("GOOGLE_CLIENT_ID");
        String redirectUri = "http://everywear.ddns.net/JSPTP/GoogleLoginServlet";
        String scope = "openid email profile";
        String authUrl = "https://accounts.google.com/o/oauth2/v2/auth"
                       + "?scope=" + scope
                       + "&access_type=online"
                       + "&response_type=code"
                       + "&redirect_uri=" + redirectUri
                       + "&client_id=" + clientId
                       + "&prompt=select_account";
    %>
    
    
    <%
	    String clientId_k = System.getenv("KAKAO_CLIENT_ID");
        String redirectUri_k = "http://everywear.ddns.net/JSPTP/KakaoLoginServlet";
        String authUrl_k = "https://kauth.kakao.com/oauth/authorize?response_type=code"
                	   + "&client_id=" + clientId_k
                       + "&redirect_uri=" + redirectUri_k
                       + "&prompt=select_account";
    %>
    
	<%
	    String clientId_n = System.getenv("NAVER_CLIENT_ID");
	    String redirectURI_n = java.net.URLEncoder.encode("http://everywear.duckdns.org/JSPTP/NaverLoginServlet", "UTF-8");
	    
	    // 랜덤 state 값 생성
	    java.util.UUID uuid = java.util.UUID.randomUUID();
	    String state = uuid.toString();
	    
	    // 세션에 state 값 저장
	    session.setAttribute("state", state);
	    
	    String apiURL_n = "https://nid.naver.com/oauth2.0/authorize?response_type=code"
	                  + "&client_id=" + clientId_n
	                  + "&redirect_uri=" + redirectURI_n
	                  + "&state=" + state;
	%>




  <div class="social-login">
    <a class="social-btn google" href="<%=authUrl%>">
      <img src="images/Google.png" alt="Google">
      <span>Sign in with Google</span>
    </a>
    <br>
    <a class="social-btn kakao" href="<%=authUrl_k%>">
      <img src="images/kakao.png" alt="Kakao">
      <span>Sign in with Kakao</span>
    </a>
 	<br>
	<a class="social-btn naver" href="<%= apiURL_n %>">
	  <img src="images/Naver.png" alt="Naver">
	  <span>Sign in with Naver</span>
	</a>
  </div>

  <a href="guestOrder.jsp" class="guest-order">비회원 주문 조회</a>

  <div class="signup-section">
    Don't you have an account? <a href="signup.jsp">Sign up</a>
  </div>
</div>

<footer>2025©everyWEAR</footer>

</body>
</html>