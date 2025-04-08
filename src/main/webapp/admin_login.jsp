<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 로그인 | everyWEAR</title>
<link rel="icon" type="image/png" href="images/fav-icon.png">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/admin_login.css">
</head>
<body>
	<div class="login-container">
		<img src="<%=request.getContextPath()%>/images/logo-black.png"
			alt="Logo" class="login-logo">
		<h2>관리자 로그인</h2>
		<form>
			<label>ID</label> <input type="text" name="adminId"
				placeholder="아이디를 입력하세요" required> <br> <label>PWD</label> <input
				type="password" name="adminPwd" placeholder="비밀번호를 입력하세요"> <label>Email</label>
			<input type="email" name="adminEmail" placeholder="이메일을 입력하세요">

			<button type="button" class="btn" id="verifyBtn">인증번호 받기</button>

			<div id="codeInputDiv" class="hidden">
				<label>인증번호</label> <input type="text" name="verifyCode"
					placeholder="인증번호를 입력하세요">
			</div>

			<div id="actionBtnDiv" class="btn-group hidden">
				<button type="button" class="btn" id="resendBtn">재전송</button>
				<button type="button" class="btn" id="loginBtn">로그인</button>
			</div>
		</form>
	</div>

	<script>
  document.addEventListener("DOMContentLoaded", function () {
    const verifyBtn = document.getElementById("verifyBtn");
    const resendBtn = document.getElementById("resendBtn");
    const loginBtn = document.getElementById("loginBtn");

    const codeInputDiv = document.getElementById("codeInputDiv");
    const actionBtnDiv = document.getElementById("actionBtnDiv");

    const adminIdInput = document.querySelector('input[name="adminId"]');
    const adminPwdInput = document.querySelector('input[name="adminPwd"]');
    const adminEmailInput = document.querySelector('input[name="adminEmail"]');
    const verifyCodeInput = document.querySelector('input[name="verifyCode"]');

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    function sendVerificationCode() {
      const adminId = adminIdInput.value.trim();
      const adminPwd = adminPwdInput.value.trim();
      const adminEmail = adminEmailInput.value.trim();

      if (!adminId || !adminPwd || !adminEmail) {
        alert("ID, 비밀번호, 이메일을 모두 입력해주세요.");
        return;
      }

      if (!emailRegex.test(adminEmail)) {
        alert("이메일 형식이 올바르지 않습니다.");
        return;
      }

      adminIdInput.readOnly = true;
      adminPwdInput.readOnly = true;
      adminEmailInput.readOnly = true;
      verifyBtn.style.display = "none";
      codeInputDiv.classList.remove("hidden");
      actionBtnDiv.classList.remove("hidden");

      verifyCodeInput.focus(); // 🔽 인증번호 입력란으로 커서 이동
      
      fetch("<%=request.getContextPath()%>/AdminAuthServlet", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: new URLSearchParams({ email: adminEmail })
      })
      .then(res => res.json())
      .then(data => {
        if (!data.success) {
          alert("인증번호 전송 실패: " + (data.message || ""));
        }
      })
      .catch(err => {
        console.error("에러 발생:", err);
        alert("서버 오류로 인증번호를 보낼 수 없습니다.");
      });
    }

    verifyBtn.addEventListener("click", sendVerificationCode);
    resendBtn.addEventListener("click", sendVerificationCode);

    loginBtn.addEventListener("click", function () {
      const adminId = adminIdInput.value.trim();
      const adminPwd = adminPwdInput.value.trim();
      const adminEmail = adminEmailInput.value.trim();
      const verifyCode = verifyCodeInput.value.trim();

      if (!adminId || !adminPwd || !adminEmail || !verifyCode) {
        alert("모든 입력값을 입력해주세요.");
        return;
      }

      if (!emailRegex.test(adminEmail)) {
        alert("이메일 형식이 올바르지 않습니다.");
        return;
      }

      fetch("<%=request.getContextPath()%>/AdminLogin", {
        method: "POST",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: new URLSearchParams({
          adminId,
          adminPwd,
          adminEmail,
          verifyCode
        })
      })
      .then(response => response.json())
      .then(data => {
        alert(data.message || "알 수 없는 오류가 발생했습니다.");
        if (data.success) {
          location.href = "<%=request.getContextPath()%>/admin_main.jsp";
        } else {
        	location.href = "<%=request.getContextPath()%>/admin_login.jsp";
        }
      })
      .catch(error => {
        console.error("에러 발생:", error);
        alert("서버 오류로 로그인에 실패했습니다.");
      });
    });
  });
  </script>
</body>
</html>
