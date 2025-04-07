<!-- resetPwd.jsp -->

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>비밀번호 찾기 | everyWEAR</title>
  <link rel="stylesheet" href="css/login.css">
<link rel="stylesheet" href="css/resetPwd.css">
  <link rel="icon" type="image/png" href="images/logo-white.png">
</head>
<body>

<%@ include file="includes/loginHeader.jsp" %>

<div class="login-container">
  <h2 class="form-title">비밀번호 찾기</h2>
  
	<label for="username">아이디</label>
	<input type="text" id="username" name="username" value="pwpnk2002" class="readonly-input" readonly>

    <label for="newPassword">비밀번호</label>
    <input type="password" id="newPassword" name="newPassword" placeholder="비밀번호를 입력하세요." required>
    <p class="input-hint">⋇ 영문 대소문자 + 숫자 포함(4자 이상 16자 이하 & 특수문자 1개 이상 포함)</p>

    <label for="confirmPassword">비밀번호 확인</label>
    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="비밀번호를 입력하세요." required>

    <button type="submit" class="login-btn">로그인</button>
  </form>
</div>

<footer>2025©everyWEAR</footer>

</body>
</html>
