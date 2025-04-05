<!-- signup.jsp -->
<%@ page import="DAO.PhoneSMS" %>
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
<style>
  .terms-section {
    font-size: 14px;
    display: flex;
    flex-direction: column;
    gap: 10px;
    margin-top: 20px;
  }

  .term-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .term-item label {
    display: flex;
    align-items: center;
    gap: 6px;
    margin: 0;
  }

  .term-item a {
    color: blue;
    text-decoration: underline;
    white-space: nowrap;
    font-size: 13px;
  }
  
 .phone-group {
    display: flex;
    align-items: center;
    gap: 5px;
    margin-top: 4px;
    margin-bottom: 10px;
  }

.phone-group input {
  width: 109px;
  height: 42px;
  padding: 0 10px;
  border: 1px solid #ccc;
  border-radius: 10px;
  background-color: #f7fbff;
  text-align: center;
  font-size: 15px;
}


  .verify-btn {
    margin-top: 5px;
    width: 100%;
    padding: 10px;
    background-color: black;
    color: white;
    border: none;
    border-radius: 10px;
    cursor: pointer;
    font-weight: bold;
  }

  .auth-box {
    margin-top: 15px;
  }

.auth-box input {
  height: 42px;
  padding: 0 12px;
  font-size: 15px;
  border-radius: 10px;
  border: 1px solid #dcdcdc;
  background-color: #f7fbff;
}


  .auth-btns {
    display: flex;
    justify-content: space-between;
    margin-top: 10px;
    gap: 10px;
  }

  .resend-btn {
    flex: 1;
    padding: 10px;
    border-radius: 10px;
    border: 1px solid #dcdcdc;
    background-color: white;
    cursor: pointer;
  }

  .confirm-btn {
    flex: 1;
    padding: 10px;
    border-radius: 10px;
    background-color: black;
    color: white;
    border: none;
    cursor: pointer;
    font-weight: bold;
  }
  
</style>
<body>


<%@ include file="includes/loginHeader.jsp" %>

<div class="signup-container">
  <h2>회원가입</h2>

  <form action="signup" method="post" id="register" onsubmit="return handleEmailSubmit()">

<%if(social == null){ %>
    <!-- 아이디 -->
    <label for="userId">아이디 <span style="color: red;">*</span></label>
    <div class="address-group">
	    <input type="text" id="userId" name="userId" placeholder="아이디를 입력하세요" required>
		<button type="button" class="search-btn" onclick="checkId()">중복 체크</button>
	</div>
	<div id="checkResult" style="font-size: 0.9em; margin-top: 5px;"></div>
		

    <!-- 비밀번호 -->
    <label for="password">비밀번호 <span style="color: red;">*</span></label>
    <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요" required>

    <!-- 비밀번호 확인 -->
    <label for="confirmPassword">비밀번호 확인 <span style="color: red;">*</span></label>
    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="비밀번호를 다시 입력하세요" required>

    <div id="pwCheckMsg"></div>
<%} %>
    <!-- 이름 -->
    <label for="name">이름 <span style="color: red;">*</span></label>
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
    <label for="address">주소 <span style="color: red;">*</span></label>
    <div class="address-group">
      <input type="text" id="zipcode" name="zipcode" placeholder="우편번호" readonly>
      <button type="button" class="search-btn" onclick="execDaumPostcode()">주소 검색</button>
    </div>
    <input type="text" id="address1" name="address1" placeholder="기본 주소" required>
    <input type="text" id="address2" name="address2" placeholder="나머지 주소">

<!--     성별
    <label >성별 <span style="color: red;">*</span></label>
    <div class="gender-group">
      <input type="radio" id="male" name="gender" value="남자" required>
      <label for="male">남자</label>
      <input type="radio" id="female" name="gender" value="여자">
      <label for="female">여자</label>
    </div> -->
    
    <div>
	    <table class="gender-hw">
	    	<tr>
	    		<td width="70px"><label >성별 <span style="color: red;">*</span></label></td>
	    		<td width="70px"></td>
	    		<td width="130px"><label>키(선택사항)</label></td>
	    		<td width="130px"><label>몸무게(선택사항)</label></td>
	    	</tr>
	    	<tr>
	    		<td><input type="radio" id="male" name="gender" value="남자" required><span style="font-size: 15px">남자</span></td>
	    		<td><input type="radio" id="female" name="gender" value="여자"><span style="font-size: 15px">여자</span></td>
	    		<td><input type="text" id="height" name="height" maxlength="3" placeholder="키 (cm)"></td>
	    		<td><input type="text"  id="weight" name="weight" maxlength="3" placeholder="몸무게 (kg)"></td>
	    	</tr>
	    </table>
	</div>
<!--         키 & 몸무게
        <label>(선택사항)</label>
    <div class="hw-group">
      <input type="text" name="height" maxlength="3" placeholder="키 (cm)">
      <input type="text" name="weight" maxlength="3" placeholder="몸무게 (kg)">
    </div> -->

    <!-- 생년월일 -->
    <label for="birth">생년월일 <span class="required" style="color: red;">*</span></label>
    <div class="birth-container">
        <input type="text" name="year" id="year" maxlength="4" placeholder="년" required>
        <span class="birth-label">년</span>
        <input type="text" name="month" id="month" maxlength="2" placeholder="월" required>
        <span class="birth-label">월</span>
        <input type="text" name="day" id="day" maxlength="2" placeholder="일" required>
        <span class="birth-label">일</span>
    </div>

	<!-- 휴대전화 -->
	<label for="phone1">휴대전화 <span style="color: red;">*</span></label>
	<div class="phone-group">
	  <input type="text" id="phone1" name="phone1" maxlength="3" value="010" readonly>
	  <span>-</span>
	  <input type="text" id="phone2" name="phone2" maxlength="4" placeholder="1234" required>
	  <span>-</span>
	  <input type="text" id="phone3" name="phone3" maxlength="4" placeholder="5678" required>
	</div>
	<button type="button" id="sendCodeBtn" class="verify-btn" onclick="showAuthBox()">인증</button>
	
	<!-- 인증번호 입력 박스 (초기에는 숨김) -->
	<div id="authBox" class="auth-box" style="display: none;">
	  <label for="authCode">인증번호</label>
	  <input type="text" id="authCode" placeholder="인증번호를 입력하세요">
	  <div class="auth-btns">
	    <button type="button" class="resend-btn" onclick="showAuthBox()">재전송</button>
	    <button type="button" class="confirm-btn" onclick="checkCode()">확인</button>
	  </div>
	</div>
	
	<!-- 최종 전송용 hidden input -->
	<input type="hidden" id="phone" name="phone">


    <!-- 약관 동의 -->
<div class="terms-section">
  <h3>약관 동의</h3>

  <div class="term-item">
    <label><input type="checkbox" id="checkAll"> 약관 전체 동의하기(선택 동의 포함)</label>
  </div>

  <div class="term-item">
    <label><input type="checkbox" class="term-check" required> 만 14세 이상입니다. (필수)</label>
    <a href="#">자세히</a>
  </div>

  <div class="term-item">
    <label><input type="checkbox" class="term-check" required> 에브리웨어 이용 약관 (필수)</label>
    <a href="#">자세히</a>
  </div>

  <div class="term-item">
    <label><input type="checkbox" name = "marketing" class="term-check"> 광고성 정보 수신 동의 (선택)</label>
    <a href="#">자세히</a>
  </div>
</div>
    <button type="button" class="signup-btn" onclick="register()">회원가입</button>
  </form>
</div>

<footer>2025©everyWEAR</footer>

<!-- ✅ Script 영역 -->
<script>
let isIdChecked = false;  // 중복확인 여부 저장

function register(){
	const pwd = document.getElementById("password").value.trim();
	const pwd_ck = document.getElementById("confirmPassword").value.trim();
	  if (!isIdChecked) {
		    alert("아이디 중복 확인을 먼저 해주세요!");
		    return;
	  }
	  
	  
}

	//아이디 중복 체크
function checkId() {
	  const userIdInput = document.getElementById("userId");
	  const userId = userIdInput.value;
	  const resultDiv = document.getElementById("checkResult");

	  if (userId === "") {
	    resultDiv.innerText = "아이디를 입력하세요.";
	    resultDiv.style.color = "red";
	    return;
	  }

	  fetch("checkId?userId=" + encodeURIComponent(userId))
	    .then(response => response.text())
	    .then(data => {
	      resultDiv.innerText = data;

	      if (data.includes("사용 중")) {
	        // 이미 사용 중인 아이디
	        resultDiv.style.color = "red";
	        isIdChecked = false;
	      } else if (data.includes("사용 가능")) {
	        // 사용 가능한 아이디
	        resultDiv.style.color = "green";
	        isIdChecked = true;
	      } else {
	        // 기타 메시지
	        resultDiv.style.color = "black";
	        isIdChecked = false;
	      }
	    })
	    .catch(error => {
	      resultDiv.innerText = "서버 에러가 발생했습니다.";
	      resultDiv.style.color = "red";
	      console.error("에러:", error);
	    });
    }
document.getElementById("userId").addEventListener("input", () => {
	  isIdChecked = false;
	  document.getElementById("checkResult").innerText = ""; // 결과 초기화
	});

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
    const emailDomain = document.getElementById("emailDomain").value.trim();

    console.log(emailId);
    console.log(emailDomain);
    if (emailId && emailDomain) {
    	document.getElementById("email").value = emailId + "@" + emailDomain;
    } else {
    	document.getElementById("email").value = null;
    }
    return true;
  }
  
  	function showAuthBox() {
		    // 휴대전화 번호 결합
		  const p1 = document.getElementById('phone1').value.trim();
		  const p2 = document.getElementById('phone2').value.trim();
		  const p3 = document.getElementById('phone3').value.trim();
		  console.log("p1:", p1, typeof p1);
		  console.log("p2:", p2, typeof p2);
		  console.log("p3:", p3, typeof p3);
		  const p = p1+p2+p3;
		  
		  console.log("전화번호:", p); // 디버깅용
		    if (!p.match(/^010\d{4}\d{4}$/)) {
		      alert("전화번호 형식이 올바르지 않습니다.");
		      return;
		    }
		    // 인증 버튼 숨기고 인증번호 입력창 보이기
		    document.getElementById("sendCodeBtn").style.display = "none";
		    document.getElementById("authBox").style.display = "block";
		    
		    fetch("sendSMS.jsp?phone=" + encodeURIComponent(p))
		      .then(res => res.json())
		      .then(data => {
		        if (data.result === "success") {
		          alert("인증번호가 전송되었습니다.");
		          document.getElementById("authBox").style.display = "block";
		        } else {
		          alert("전송 실패");
		        }
		      });
	  }
  		
	function checkCode(){
		const writeCode = document.getElementById('authCode').value.trim();
		 fetch("verifyCode.jsp?code=" + encodeURIComponent(writeCode))
		    .then(res => res.json())
		    .then(data => {
		      if (data.result === "success") {
		        alert("확인되었습니다.");
			    document.getElementById("authBox").style.display = "none";
			    document.getElementById("phone2").readOnly = true;
			    document.getElementById("phone3").readOnly = true;
		      } else {
		        alert("인증번호가 틀렸습니다.");
		      }
		    });
	}

	  // 숫자만 입력되게
	  ['phone2', 'phone3', 'authCode'].forEach(id => {
	    document.getElementById(id).addEventListener('input', (e) => {
	      e.target.value = e.target.value.replace(/[^0-9]/g, '');
	    });
	  });

  
  /* 생년월일 숫자만 입력 가능 */
  document.querySelectorAll('.birth-container input').forEach(input => {
      input.addEventListener('input', (e) => {
          e.target.value = e.target.value.replace(/[^0-9]/g, ''); // 숫자만 입력 가능
      });
  });
  
  /* 신체정보 숫자만 입력 가능 */
	  ['height', 'weight'].forEach(id => {
	    document.getElementById(id).addEventListener('input', (e) => {
	      e.target.value = e.target.value.replace(/[^0-9]/g, '');
	    });
	  });
  
  
  /* 약관 전체 동의 */
  const checkAll = document.getElementById("checkAll");
  const termChecks = document.querySelectorAll(".term-check");

  // 전체 동의 체크/해제
  checkAll.addEventListener("change", function () {
    termChecks.forEach(chk => chk.checked = this.checked);
  });

  // 개별 체크 해제 시 전체 동의 체크 해제
  termChecks.forEach(chk => {
    chk.addEventListener("change", function () {
      if (!this.checked) {
        checkAll.checked = false;
      } else {
        const allChecked = Array.from(termChecks).every(chk => chk.checked);
        checkAll.checked = allChecked;
      }
    });
  });

</script>

</body>
</html>
