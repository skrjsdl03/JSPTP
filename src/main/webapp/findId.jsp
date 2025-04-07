<!-- findId.jsp -->

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>아이디 찾기 | everyWEAR</title>
  <link rel="stylesheet" type="text/css" href="css/find.css">
  <link rel="icon" type="image/png" href="images/logo-white.png">
</head>
<body>

<%@ include file="includes/loginHeader.jsp" %>

<div class="find-id-container">
  <h2>아이디 찾기</h2>

  <form id="findPwdForm">

    <!-- 인증 방식 -->
    <label>본인확인 인증</label>
    <div class="radio-group">
      <input type="radio" name="authType" id="phone" value="phone" checked>
      <label for="phone">휴대폰번호</label>
      <input type="radio" name="authType" id="email" value="email">
      <label for="email">이메일</label>
    </div>

    <!-- 이름 입력 -->
    <label for="name">이름</label>
    <input type="text" id="name" name="name" placeholder="이름을 입력하세요" required>

    <!-- 휴대폰번호 입력창 (기본 노출) -->
    <div id="phoneInputGroup">
      <label for="phone1">휴대폰번호로 찾기</label>
      <div class="phone-input-group">
        <input type="text" id="phone1" maxlength="3" required>
        <span>-</span>
        <input type="text" id="phone2" maxlength="4" required>
        <span>-</span>
        <input type="text" id="phone3" maxlength="4" required>
      </div>
    </div>

    <!-- 이메일 입력창 -->
    <div id="emailInputGroup" class="email-input-group" style="display: none;">
      <label for="emailId">이메일로 찾기</label>
      <div class="email-input-wrap">
        <input type="text" id="emailId" placeholder="이메일 아이디 입력" required>
        <span>@</span>
        <select id="emailDomain" required>
          <option value="">선택</option>
          <option value="gmail.com">gmail.com</option>
          <option value="naver.com">naver.com</option>
          <option value="daum.net">daum.net</option>
          <option value="hanmail.net">hanmail.net</option>
          <option value="nate.com">nate.com</option>
        </select>
      </div>
      <input type="hidden" id="email" name="email">
    </div>

    <!-- 인증 버튼 -->
    <div id="authBtnBox">
      <button type="button" class="btn black" onclick="showVerification()">인증</button>
    </div>

    <!-- 인증번호 입력 영역 -->
    <div id="verifyBox" style="display:none;">
      <label for="verifyCode">인증번호</label>
      <input type="text" id="verifyCode" name="verifyCode" placeholder="인증번호를 입력하세요">
      <div class="verify-btn-group">
        <button type="button" class="btn white">재전송</button>
        <button type="submit" class="btn black">확인</button>
      </div>
    </div>

  </form>
</div>

<footer>2025©everyWEAR</footer>

<script>
  const emailId = document.getElementById("emailId");
  const emailDomain = document.getElementById("emailDomain");
  const emailFull = document.getElementById("email");

  const form = document.getElementById("findPwdForm");
  form.addEventListener("submit", function(e) {
    if (emailRadio.checked) {
      const id = emailId.value.trim();
      const domain = emailDomain.value;
      if (!id || !domain) {
        alert("이메일 아이디와 도메인을 모두 입력해주세요.");
        e.preventDefault();
        return;
      }
      emailFull.value = `${id}@${domain}`;
    }
  });

  function showVerification() {
    document.getElementById('authBtnBox').style.display = 'none';
    document.getElementById('verifyBox').style.display = 'block';
  }

  const phoneRadio = document.getElementById("phone");
  const emailRadio = document.getElementById("email");
  const phoneInputGroup = document.getElementById("phoneInputGroup");
  const emailInputGroup = document.getElementById("emailInputGroup");

  phoneRadio.addEventListener("change", toggleAuthInput);
  emailRadio.addEventListener("change", toggleAuthInput);

  function toggleAuthInput() {
    phoneInputGroup.style.display = phoneRadio.checked ? "block" : "none";
    emailInputGroup.style.display = emailRadio.checked ? "block" : "none";
    document.getElementById('verifyBox').style.display = 'none';
    document.getElementById('authBtnBox').style.display = 'block';
  }

  window.addEventListener("DOMContentLoaded", toggleAuthInput);
</script>

</body>
</html>
