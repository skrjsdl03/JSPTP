<!-- login.jsp -->

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>로그인 | everyWEAR</title>
<link rel="stylesheet" type="text/css" href="css/login.css?v=2">
  <link rel="stylesheet" type="text/css" href="css/header.css">
  <link rel="icon" type="image/png" href="images/logo-white.png">
</head>
<body>

<%@ include file="includes/loginHeader.jsp" %>

<div class="login-container">
<form action="loginProcess.jsp" method="post" autocomplete="off">
  <label for="userId">ID</label>
  <input type="text" id="userId" name="userId" placeholder="아이디를 입력하세요" required>

  <label for="password">PWD</label>
  <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요" required>

  <!-- 아이디/비밀번호 찾기 영역 -->
  <div class="find-links">
    <a href="findId.jsp">아이디 찾기</a>
    <span class="divider-bar">|</span>
    <a href="findPwd.jsp">비밀번호 찾기</a>
  </div>

  <button type="submit" class="login-btn">Login</button>
</form>


  <div class="divider">Or</div>

  <div class="social-login">
    <button class="social-btn google">
      <img src="images/Google.png" alt="Google">
      <span>Sign in with Google</span>
    </button>
    <button class="social-btn kakao">
      <img src="images/kakao.png" alt="KakaoTalk">
      <span>Sign in with KakaoTalk</span>
    </button>
    <button class="social-btn naver">
      <img src="images/Naver.png" alt="Naver">
      <span>Sign in with Naver</span>
    </button>
  </div>

  <a href="guestOrder.jsp" class="guest-order">비회원 주문 조회</a>

  <div class="signup-section">
    Don't you have an account? <a href="signup.jsp">Sign up</a>
  </div>
</div>

<footer>2025©everyWEAR</footer>

</body>
</html>