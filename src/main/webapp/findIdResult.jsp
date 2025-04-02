<!-- findIdResult.jsp -->

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>검색 결과 | everyWEAR</title>
  <link rel="stylesheet" type="text/css" href="css/find.css">
  <link rel="stylesheet" type="text/css" href="css/header.css">
  <link rel="stylesheet" type="text/css" href="css/findResult.css">
  <link rel="icon" type="image/png" href="images/logo-white.png">
</head>
<body>

<%@ include file="includes/loginHeader.jsp" %>

<div class="result-container">
  <h2>아이디 찾기</h2>

  <div class="description">
    아이디 찾기가 완료되었습니다.<br>
    가입된 아이디가 총 <strong>2개</strong> 있습니다.
  </div>

  <!-- 기존 -->
<div class="result-box">
  <input type="radio" id="user1" name="selectedId" checked>
  <label for="user1"><strong>pwpmlk2002</strong> (개인회원, 2025-03-30 가입)</label>
</div>

<!-- 추가 -->
<div class="result-box">
  <input type="radio" id="user2" name="selectedId">
  <label for="user2"><strong>everyuser99</strong> (기업회원, 2024-11-10 가입)</label>
</div>


  <div class="btn-group">
    <a href="login.jsp" class="btn black">로그인</a>
    <a href="findPassword.jsp" class="btn white">비밀번호 찾기</a>
  </div>
</div>

<footer>2025©everyWEAR</footer>

</body>
</html>