<!-- findPwd.jsp -->

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>아이디 찾기 | everyWEAR</title>
  <link rel="stylesheet" type="text/css" href="css/find.css">
  <link rel="icon" type="image/png" href="images/fav-icon.png">
</head>
<body>

<%@ include file="includes/loginHeader.jsp" %>

<div class="find-id-container">
  <h2>비밀번호 찾기</h2>

  <form id="findPwdForm">

    <!-- 인증 방식 -->
    <label>본인확인 인증</label>
    <div class="radio-group">
      <input type="radio" name="authType" id="phone" value="phone" checked>
      <label for="phone">휴대폰번호</label>
      <input type="radio" name="authType" id="email" value="email">
      <label for="email">이메일</label>
    </div>

    <!-- 아이디 입력 -->
    <label for="name">아이디</label>
    <input type="text" id="name" name="name" placeholder="아이디를 입력하세요" required>
    
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

  <!-- 실제 서버로 보낼 숨은 필드 -->
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

<!-- 스크립트: 이메일 주소 조합 및 인증 방식 전환 -->
<script>
  const emailId = document.getElementById("emailId");
  const emailDomain = document.getElementById("emailDomain");
  const emailFull = document.getElementById("email");

  const form = document.getElementById("findIdForm");
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
</script>

<script>
  // 인증 버튼 클릭 시 인증번호 입력창 보이기
  function showVerification() {
    document.getElementById('authBtnBox').style.display = 'none';
    document.getElementById('verifyBox').style.display = 'block';
  }

  // 요소 가져오기
  const phoneRadio = document.getElementById("phone");
  const emailRadio = document.getElementById("email");
  const phoneInputGroup = document.getElementById("phoneInputGroup");
  const emailInputGroup = document.getElementById("emailInputGroup");
  const authBtnBox = document.getElementById("authBtnBox");
  const verifyBox = document.getElementById("verifyBox");

  // 라디오 버튼 변경 시 실행
  phoneRadio.addEventListener("change", toggleAuthInput);
  emailRadio.addEventListener("change", toggleAuthInput);

  function toggleAuthInput() {
    // 입력창 전환
    if (phoneRadio.checked) {
      phoneInputGroup.style.display = "block";
      emailInputGroup.style.display = "none";
    } else if (emailRadio.checked) {
      phoneInputGroup.style.display = "none";
      emailInputGroup.style.display = "block";
    }

    // ✅ 인증 상태 초기화
    verifyBox.style.display = "none";
    authBtnBox.style.display = "block";
  }

  // 페이지 로드시 초기 세팅
  window.addEventListener("DOMContentLoaded", toggleAuthInput);
</script>

</body>
</html>
