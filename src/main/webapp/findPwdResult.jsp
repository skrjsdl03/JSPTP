<!-- resetPwd.jsp -->

<%@page import="DTO.UserDTO"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<jsp:useBean id="userDao" class="DAO.UserDAO"/>
<%
		String type = request.getParameter("authType");
		Vector<UserDTO> ulist = new Vector<UserDTO>();
		String name = null;
		String id = null;
		boolean flag = false;
		if(type.equals("phone")) {
			id = request.getParameter("id");
			name = request.getParameter("name");
			String phone1 = request.getParameter("phone1");
			String phone2 = request.getParameter("phone2");
			String phone3 = request.getParameter("phone3");
			String phone = phone1 + "-" + phone2 + "-" + phone3;
			flag = userDao.findPwdByPhone(id, name, phone);
		} else if(type.equals("email")) {
			id = request.getParameter("id");
			name = request.getParameter("name");
			String email = request.getParameter("email");
			flag = userDao.findPwdByEmail(id, name, email);
		}
%>
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

  <%if(flag){ %>
<div class="login-container">
  <h2 class="form-title">비밀번호 찾기</h2>
  <form action="resetPwd" method="post" id="resetPwd">
	<label for="username">아이디</label>
	<input type="text" id="userId" name="userId" value="<%=id%>" class="readonly-input" readonly>

    <label for="newPassword">비밀번호</label>
    <input type="password" id="newPassword" name="newPassword" placeholder="비밀번호를 입력하세요." required>
    <p class="input-hint">⋇ 영문 대소문자 + 숫자 포함(4자 이상 16자 이하 & 특수문자 1개 이상 포함)</p>

    <label for="confirmPassword">비밀번호 확인</label>
    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="비밀번호를 입력하세요." required>
    <div id="pwCheckMsg"></div>

    <button type="button" class="login-btn" onclick="pwdCheck()">로그인</button>
  </form>
</div>
<%} else{ %>
<%} %>

<footer>2025©everyWEAR</footer>

<script>
	// 비밀번호 일치 확인
   const passwordInput = document.getElementById("newPassword");
   const confirmPasswordInput = document.getElementById("confirmPassword");
   const pwCheckMsg = document.getElementById("pwCheckMsg");
   let isPwdChecked = false;

   function checkPasswordMatch() {
     const pw = passwordInput.value;
     const confirmPw = confirmPasswordInput.value;

     if (confirmPw.length === 0) {
       pwCheckMsg.textContent = "";
       pwCheckMsg.className = "";
       return;
     }

     if (pw === confirmPw) {
       pwCheckMsg.textContent = "비밀번호가 일치합니다.";
       pwCheckMsg.className = "match";
       isPwdChecked = true;
     } else {
       pwCheckMsg.textContent = "비밀번호가 일치하지 않습니다.";
       pwCheckMsg.className = "not-match";
       isPwdChecked = false;
     }
   }

   passwordInput.addEventListener("input", checkPasswordMatch);
   confirmPasswordInput.addEventListener("input", checkPasswordMatch);

function pwdCheck(){
	if(isPwdChecked)
		document.getElementById("resetPwd").submit();
}
</script>

</body>
</html>
