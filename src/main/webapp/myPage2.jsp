<%@page import="java.text.DecimalFormat"%>
<%@page import="DTO.UserCouponDTO"%>
<%@page import="DTO.UserDTO"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<jsp:useBean id="userDao" class="DAO.UserDAO"/>
<%
		String userId = (String) session.getAttribute("id");
		String userType = (String) session.getAttribute("userType");
		if(userId == null || userId == ""){
			// 현재 페이지 경로를 얻기 위한 코드
			String fullUrl = request.getRequestURI();
			String queryString = request.getQueryString();
			if (queryString != null) {
				fullUrl += "?" + queryString;
			}
			response.sendRedirect("login.jsp?redirect=" + java.net.URLEncoder.encode(fullUrl, "UTF-8"));
			return;
		}
		UserDTO userDto = userDao.getOneUser(userId, userType);
		int couponCnt = userDao.showOneUserCoupon(userId, userType);
		String phone2 = userDto.getUser_phone().split("-")[1];
		String phone3 = userDto.getUser_phone().split("-")[2];
		
        DecimalFormat formatter = new DecimalFormat("#,###");

        String point = formatter.format(userDto.getUser_point());
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>에브리웨어 | everyWEAR</title>
<link rel="icon" type="image/png" href="images/fav-icon.png">
<link rel="stylesheet" type="text/css" href="css/myPage2.css?v=5646574">
</head>
<body>

	<%@ include file="includes/header.jsp"%>

	<section2 class="content2">
	<h3>회원 정보 수정</h3>
	</section2>

	<div class="container">
		<div class="user-box">
			<p class="username"><%=userDto.getUser_name()%> 님</p>
			<div class="user-info">
				<div class="label">적립금</div>
				<div class="value"><%=point%> ￦</div>
				<div class="label">쿠폰</div>
				<div class="value"><%=couponCnt%> 개</div>
			</div>
		</div>
		
		
		<aside class="sidebar2">
		<br>
			<ul>
				<li><a href="myPage.jsp">회원 정보 수정</a></li>
				<li><a href="orderHistory2.jsp">주문 내역</a></li>
				<li><a href="cart2.jsp">장바구니</a></li>
				<li><a href="wishList2.jsp">찜 상품</a></li>
				<li><a href="postMn.jsp">게시물 관리</a></li>
				<li><a href="deliveryMn.jsp">배송지 관리</a></li>
			</ul>
		</aside>

		<section class="content">
			<div class="edit-content">
				<form>
					<!-- ID -->
				    <label for="id">ID</label>
				    <input type="text" id="id" name="id" value="<%=userDto.getUser_name()%>" disabled>

				<%if(userType.equals("일반")){ %>
					<!-- 기존 비밀번호 -->
				    <label for="currentPw">비밀번호</label>
			        <div class="input-group">
				      <input type="password" id="currentPw" placeholder="기존 비밀번호">
				      <button class="change-btn" onclick="togglePasswordChange()">변경</button>
				    </div>
<!-- 					<div class="phone-group">
						휴대전화 입력 스타일을 재활용
						<input type="password" name="password" id="password" class="readonly-password">
						<button type="button" class="btn-change" onclick="togglePasswordChange()">변경</button>
					</div> -->

					<!-- 새 비밀번호 입력 영역 (처음엔 숨김) -->
					<div id="newPwBox" style="display: none;">

						<!-- 새 비밀번호 -->
						<div class="form-group">
							<label>새 비밀번호</label> 
							<input type="password" id="newPassword" placeholder="새 비밀번호 입력">
							
							<div id="pwCheck"></div>
							
<!-- 							안내 문구 아래 마진 추가!
							<small class="guide-text" style="color: #888; display: block; margin-top: 5px; margin-bottom: 12px;">
								영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 8자~16자 </small> -->
						</div>

						<!-- 새 비밀번호 확인 -->
						<div class="form-group" style="margin-top: 10px;">
							<label>새 비밀번호 확인</label> 
							<input type="password" id="confirmPassword" onkeyup="checkPasswordMatch()" placeholder="새 비밀번호 재입력">
							
							<div id="pwCheckMsg"></div>
							<!-- <div id="passwordMatchMsg" class="msg" style="margin-top: 8px;"></div> -->
						</div>

					</div>
					<%} %>

					<!-- 이름 -->
				    <label for="name">NAME <span style="color: red;">*</span></label>
				    <input type="text" id="name" name="name" value="<%=userDto.getUser_name()%>">

					<!-- 휴대전화 -->
					<label for="phone">휴대전화 <span style="color: red;">*</span></label>
    				<div class="input-group">	
						<input type="text" maxlength="3" value="010" readonly> 
						<input type="text" maxlength="4" id="phone2" value="<%=phone2%>"> 
						<input type="text" maxlength="4" id="phone3" value="<%=phone3%>">
						<button type="button" class="change-btn" onclick="showAuthBox()">인증</button>
					</div>

					<!-- 인증번호 입력 영역 (처음엔 숨김) -->
					<label for="authCode">인증번호</label>
				  	<input type="text" id="authCode" placeholder="인증번호를 입력하세요">
				  	<div class="auth-btns">
				    	<button type="button" class="resend-btn" onclick="showAuthBox()">재전송</button>
				    	<button type="button" class="confirm-btn" onclick="checkCode()">확인</button>
				  	</div>


					<!-- 이메일 -->
				    <label for="email">이메일</label>
				    <input type="email" id="email" value="<%=userDto.getUser_email().isEmpty() ? "" : userDto.getUser_email()%>">

					<!-- 성별 -->
					<label>성별 <span style="color: red;">*</span></label> 
				    <div class="radio-group">
					<label><input type="radio" name="gender" <%=userDto.getUser_gender().equals("남자") ? "checked" : ""%>> 남자</label> 
					<label><input type="radio" name="gender" <%=userDto.getUser_gender().equals("여자") ? "checked" : ""%>> 여자</label>
					</div>
					
					<!-- 키 & 몸무게 -->
				    <label for="height">키</label>
				    <input type="text" id="height" name="height" placeholder="cm" value="<%=userDto.getUser_height()==0 ? "" : userDto.getUser_height() + "cm"%>">
				
				    <label for="weight">몸무게</label>
				    <input type="text" id="weight" name="weight" placeholder="kg" value="<%=userDto.getUser_weight()==0 ? "" : userDto.getUser_weight() + "kg"%>">

					<!-- 키 & 몸무게 -->
<%-- 					<div class="form-group">
						<label>키 & 몸무게</label>
						<div class="hw-group">
							<input type="text" placeholder="cm" min="0" id="height" name="height" value="<%=userDto.getUser_height() == 0 ? "" : userDto.getUser_height()%>"> 
							<input type="text" placeholder="kg" min="0" id="weight" name="weight" value="<%=userDto.getUser_weight() == 0 ? "" : userDto.getUser_weight()%>">
						</div>
					</div> --%>

					<!-- 생년월일 -->
					<label>생년월일 <span style="color: red;">*</span></label>
					<div class="birth-group">
				        <input type="text" name="year" id="year" maxlength="4" placeholder="년" required>
				        <span class="birth-label">년</span>
				        <input type="text" name="month" id="month" maxlength="2" placeholder="월" required>
				        <span class="birth-label">월</span>
				        <input type="text" name="day" id="day" maxlength="2" placeholder="일" required>
				        <span class="birth-label">일</span>
					</div>

					<button type="submit" class="submit-btn">회원 정보 수정</button>
					<a href="withdraw.jsp" class="withdraw-link">회원탈퇴</a>
				</form>
			</div>
		</section>
	</div>
	
	<script>
	const userType = '<%= session.getAttribute("userType") %>';
  let isPwdChecked = true;
  
  if(userType === "일반"){
	function togglePasswordChange(){
		const p = document.getElementById("password").value;
		
	    fetch("isPwd.jsp?password=" + encodeURIComponent(p))
	      .then(res => res.json())
	      .then(data => {
	        if (data.result === "success") {		//자기 비밀번호를 입력하였을때 
	    		document.getElementById("newPwBox").style.display = "block";
	        	isPwdChecked = false;
	    		const passwordInput = document.getElementById("newPassword");
	    		const confirmPasswordInput = document.getElementById("confirmPassword");
	    		const pwCheckMsg = document.getElementById("pwCheckMsg");
	    		const pwCheck = document.getElementById("pwCheck");
	    		
	    		  function validatePasswords() {
	    			    const pw = passwordInput.value;
	    			    const confirmPw = confirmPasswordInput.value;
	    			    const regex = /^(?=.*[!@#$%^&*(),.?":{}|<>]).{4,16}$/;

	    			    if (pw === "") {
	    			      pwCheck.textContent = "";        // ← 이 부분 추가!
	    			      pwCheck.className = "";
	    			      pwCheckMsg.textContent = "";
	    			      pwCheckMsg.className = "";
	    			      isPwdChecked = false;
	    			      return;
	    			    }

	    			    if (!regex.test(pw)) {
	    			    	pwCheck.textContent = "4자 이상 16자 이하이며, 특수문자 1개 이상을 포함";
	    			    	pwCheck.className = "not-match";
	    			      isPwdChecked = false;
	    			      return;
	    			    } else{
	    			    	pwCheck.textContent = "조건에 맞는 비밀번호입니다!";
	    			    	pwCheck.className = "match";
	    			    	 isPwdChecked = false;
	    			    }
	    			    

	    			    if (pw !== confirmPw) {
	    			    	if(confirmPw === ""){
	    				  	      pwCheckMsg.textContent = "";
	    					      pwCheckMsg.className = "";
	    					      isPwdChecked = false;
	    					      return;
	    			    	}
	    			      pwCheckMsg.textContent = "비밀번호가 일치하지 않습니다.";
	    			      pwCheckMsg.className = "not-match";
	    			      isPwdChecked = false;
	    			      return;
	    			    } else {
	    			      pwCheckMsg.textContent = "비밀번호가 일치합니다.";
	    			      pwCheckMsg.className = "match";
	    			      isPwdChecked = true;
	    			      return;
	    			    }
	    			    
	    			  }

	    			  passwordInput.addEventListener("input", validatePasswords);
	    			  confirmPasswordInput.addEventListener("input", validatePasswords);
	    		
	    		
	        } else if(data.result === "fail") {	//다른 비밀번호를 입력하였을때
	          alert("일치하지 않은 비밀번호입니다.");
	        }
	      });
		
		

	}
  }
	
	
	  /* 생년월일 숫자만 입력 가능 */
	  document.querySelectorAll('.birth-group input').forEach(input => {
	      input.addEventListener('input', (e) => {
	          e.target.value = e.target.value.replace(/[^0-9]/g, ''); // 숫자만 입력 가능
	      });
	  });
	  document.addEventListener("DOMContentLoaded", function () {
		  const yearInput = document.getElementById("year");
		  const monthInput = document.getElementById("month");
		  const dayInput = document.getElementById("day");

		  function isValidDate(y, m, d) {
		    const year = parseInt(y, 10);
		    const month = parseInt(m, 10);
		    const day = parseInt(d, 10);

		    // 간단한 범위 확인
		    if (isNaN(year) || isNaN(month) || isNaN(day)) return false;
		    if (year < 1900 || year > new Date().getFullYear()) return false;
		    if (month < 1 || month > 12) return false;
		    if (day < 1 || day > 31) return false;

		    // 실제 날짜 확인
		    const date = new Date(year, month - 1, day);
		    return date.getFullYear() === year &&
		           date.getMonth() === month - 1 &&
		           date.getDate() === day;
		  }

		  function validateBirthDate() {
		    const year = yearInput.value;
		    const month = monthInput.value;
		    const day = dayInput.value;

		    if (year && month && day) {
		      if (!isValidDate(year, month, day)) {
		        alert("유효하지 않은 생년월일입니다.");
		        yearInput.value = "";
		        monthInput.value = "";
		        dayInput.value = "";
		        yearInput.focus();
		      }
		    }
		  }

		  yearInput.addEventListener("blur", validateBirthDate);
		  monthInput.addEventListener("blur", validateBirthDate);
		  dayInput.addEventListener("blur", validateBirthDate);
		});
	  
	  
	  /* 신체정보 숫자만 입력 가능 */
		  ['height', 'weight'].forEach(id => {
		    document.getElementById(id).addEventListener('input', (e) => {
		      e.target.value = e.target.value.replace(/[^0-9]/g, '');
		    });
		  });
		  document.addEventListener("DOMContentLoaded", function () {
			    const heightInput = document.getElementById("height");
			    const weightInput = document.getElementById("weight");

			    function isValidHeight(value) {
			      const num = Number(value);
			      return !isNaN(num) && num >= 50 && num <= 250; // 키는 50~250cm
			    }

			    function isValidWeight(value) {
			      const num = Number(value);
			      return !isNaN(num) && num >= 10 && num <= 300; // 몸무게는 10~300kg
			    }

			    function validateInput(input, validator, fieldName) {
			      input.addEventListener("blur", function () {
			        const value = input.value.trim();
			        if (value === "") return; // 비어있으면 검사 안 함

			        if (!validator(value)) {
			          /* alert(`${fieldName} 값이 올바르지 않습니다.`); */
			          alert(fieldName + " 값이 올바르지 않습니다");
			          input.value = "";
			          input.focus();
			        }
			      });
			    }

			    validateInput(heightInput, isValidHeight, "키");
			    validateInput(weightInput, isValidWeight, "몸무게");
			  });
		  
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
			        isPhoneChecked = true;
				    document.getElementById("authBox").style.display = "none";
				    document.getElementById("phone2").readOnly = true;
				    document.getElementById("phone3").readOnly = true;
			      } else {
			        alert("인증번호가 틀렸습니다.");
			        let isPhoneChecked = false;
			      }
			    });
		}
		  
		  
		  
		  // 숫자만 입력되게
		  ['phone2', 'phone3', 'authCode'].forEach(id => {
		    document.getElementById(id).addEventListener('input', (e) => {
		      e.target.value = e.target.value.replace(/[^0-9]/g, '');
		    });
		  });
	
	</script>

</body>