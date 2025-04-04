<!-- signup.jsp -->

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
		String social = request.getParameter("social");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>회원가입 | everyWEAR</title>
  <link rel="stylesheet" type="text/css" href="css/signup.css">
  <link rel="icon" type="image/png" href="images/logo-white.png">
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>

<%@ include file="includes/loginHeader.jsp" %>

<div class="signup-container">
  <h2>회원가입</h2>

  <form action="signup" method="post" onsubmit="return handleEmailSubmit()">

<%if(social == null){ %>
    <!-- 아이디 -->
    <label for="userId">아이디 *</label>
    <input type="text" id="userId" name="userId" placeholder="아이디를 입력하세요" required>

    <!-- 비밀번호 -->
    <label for="password">비밀번호 *</label>
    <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요" required>

    <!-- 비밀번호 확인 -->
    <label for="confirmPassword">비밀번호 확인 *</label>
    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="비밀번호를 다시 입력하세요" required>

    <div id="pwCheckMsg"></div>
<%} %>
    <!-- 이름 -->
    <label for="name">이름 *</label>
    <input type="text" id="name" name="name" placeholder="이름을 입력하세요" required>

    <!-- 이메일 -->
<label for="emailId">이메일</label>
<div class="email-input-group">
  <input type="text" id="emailId" placeholder="이메일 아이디 입력">
  <span>@</span>
  <select id="emailDomain">
    <option value="">선택</option>
    <option value="gmail.com">gmail.com</option>
    <option value="naver.com">naver.com</option>
    <option value="daum.net">daum.net</option>
    <option value="hanmail.net">hanmail.net</option>
    <option value="nate.com">nate.com</option>
  </select>
</div>
<!-- 서버로 전달할 hidden 필드 -->
<input type="hidden" id="email" name="email">

    <!-- 추천인 -->
    <label for="referrer">추천인 아이디</label>
    <input type="text" id="referrer" name="referrer" placeholder="추천인 아이디를 입력하세요">

    <!-- 주소 -->
    <label for="address">주소 *</label>
    <div class="address-group">
      <input type="text" id="zipcode" name="zipcode" placeholder="우편번호" readonly>
      <button type="button" class="search-btn" onclick="execDaumPostcode()">주소 검색</button>
    </div>
    <input type="text" id="address1" name="address1" placeholder="기본 주소" required>
    <input type="text" id="address2" name="address2" placeholder="나머지 주소">

    <!-- 성별 -->
    <label>성별 *</label>
    <div class="gender-group">
      <input type="radio" id="male" name="gender" value="남자" required>
      <label for="male">남자</label>
      <input type="radio" id="female" name="gender" value="여자">
      <label for="female">여자</label>
    </div>

    <!-- 생년월일 -->
    <label for="birth">생년월일 <span class="required">*</span></label>
    <div class="birth-container">
        <input type="text" id="year" maxlength="4" placeholder="년">
        <span class="birth-label">년</span>
        <input type="text" id="month" maxlength="2" placeholder="월">
        <span class="birth-label">월</span>
        <input type="text" id="day" maxlength="2" placeholder="일">
        <span class="birth-label">일</span>
    </div>

    <!-- 키 & 몸무게 -->
    <div class="hw-group">
      <input type="number" name="height" placeholder="키 (cm)">
      <input type="number" name="weight" placeholder="몸무게 (kg)">
    </div>

    <!-- 휴대전화 -->
    <label for="phone">휴대전화 *</label>
    <input type="text" id="phone" name="phone" placeholder="전화번호를 입력하세요" required>

    <!-- 약관 동의 -->
    <div class="terms">
      <label><input type="checkbox" required> 만 14세 이상입니다. (필수)</label><br>
      <label><input type="checkbox" required> 에브리웨어 이용 약관 (필수)</label><br>
      <label><input type="checkbox"> 마케팅 수신 동의 (선택)</label><br>
      <label><input type="checkbox"> 광고성 정보 수신 동의 (선택)</label><br>
    </div>

    <button type="submit" class="signup-btn">회원가입</button>
  </form>
</div>

<footer>2025©everyWEAR</footer>

<!-- ✅ Script 영역 -->
<script>
  // 비밀번호 일치 확인
  const passwordInput = document.getElementById("password");
  const confirmPasswordInput = document.getElementById("confirmPassword");
  const pwCheckMsg = document.getElementById("pwCheckMsg");

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
    } else {
      pwCheckMsg.textContent = "비밀번호가 일치하지 않습니다.";
      pwCheckMsg.className = "not-match";
    }
  }

  passwordInput.addEventListener("input", checkPasswordMatch);
  confirmPasswordInput.addEventListener("input", checkPasswordMatch);

  // 다음 주소 검색 API
  function execDaumPostcode() {
    new daum.Postcode({
      oncomplete: function(data) {
        document.getElementById("zipcode").value = data.zonecode;
        document.getElementById("address1").value = data.roadAddress;
        document.getElementById("address2").focus();
      }
    }).open();
  }

  // 이메일 조합 후 hidden 필드에 입력
  function handleEmailSubmit() {
    const emailId = document.getElementById("emailId").value.trim();
    const emailDomain = document.getElementById("emailDomain").value;
    const emailFull = document.getElementById("email");

    if (emailId && emailDomain) {
      emailFull.value = `${emailId}@${emailDomain}`;
    } else {
      emailFull.value = "";
    }

    return true;
  }
  
  document.querySelectorAll('.birth-container input').forEach(input => {
      input.addEventListener('input', (e) => {
          e.target.value = e.target.value.replace(/[^0-9]/g, ''); // 숫자만 입력 가능
      });
  });
</script>

</body>
</html>
