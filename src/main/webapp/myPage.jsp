<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
String userId = (String) session.getAttribute("userId");
if (userId == null)
	userId = "guest@everywear.com";
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>에브리웨어 | everyWEAR</title>
<link rel="icon" type="image/png" href="images/fav-icon.png">
<link rel="stylesheet" type="text/css" href="css/myPage.css?v=5646574">
</head>
<body>

	<%@ include file="includes/header.jsp"%>

	<section2 class="content2">
	<h3>회원 정보 수정</h3>
	</section2>

	<div class="container">
		<div class="user-box">
			<p class="username">정시영 님</p>
			<div class="user-info">
				<div class="label">적립금</div>
				<div class="value">25,000 ￦</div>
				<div class="label">쿠폰</div>
				<div class="value">2 개</div>
			</div>
		</div>

		<aside class="sidebar2">
			<ul>
				<li><a href="myPage.jsp">회원 정보 수정</a></li>
				<li><a href="orderHistory2.jsp">주문 내역</a></li>
				<li><a href="cart.jsp">장바구니</a></li>
				<li><a href="wishList.jsp">찜 상품</a></li>
				<li><a href="postMn.jsp">게시물 관리</a></li>
			</ul>
		</aside>

		<section class="content">
			<div class="edit-content">
				<form>
					<!-- ID -->
					<div class="form-group">
						<label>ID *</label>
						<div class="id-box">
							<span class="id-text"><%=userId%></span>
						</div>
					</div>

					<!-- 기존 비밀번호 -->
					<div class="form-group">
						<label>기존 비밀번호</label>
						<div class="phone-group">
							<!-- 휴대전화 입력 스타일을 재활용 -->
							<input type="password" value="********" readonly
								class="readonly-password">
							<button type="button" class="btn-change"
								onclick="togglePasswordChange()">변경</button>
						</div>
					</div>

					<!-- 새 비밀번호 입력 영역 (처음엔 숨김) -->
					<div id="newPwBox" style="display: none; margin-top: 20px;">

						<!-- 새 비밀번호 -->
						<div class="form-group">
							<label>새 비밀번호</label> <input type="password" id="newPassword"
								onkeyup="checkPasswordMatch()" placeholder="새 비밀번호 입력">

							<!-- 안내 문구 아래 마진 추가! -->
							<small class="guide-text"
								style="color: #888; display: block; margin-top: 5px; margin-bottom: 12px;">
								영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 8자~16자 </small>
						</div>

						<!-- 새 비밀번호 확인 -->
						<div class="form-group">
							<label>새 비밀번호 확인</label> <input type="password"
								id="confirmPassword" onkeyup="checkPasswordMatch()"
								placeholder="새 비밀번호 재입력">
							<div id="passwordMatchMsg" class="msg" style="margin-top: 8px;"></div>
						</div>

					</div>

					<!-- 이름 -->
					<div class="form-group">
						<label>이름 *</label> <input type="text" value="정시영"
							placeholder="이름을 입력하세요" required>
					</div>

					<!-- 휴대전화 -->
					<div class="form-group">
						<label>휴대전화 *</label>
						<div class="phone-group">
							<input type="text" value="010" readonly> <input
								type="text" id="phone2" value="1234"> <input type="text"
								id="phone3" value="5678">
							<button type="button" class="btn-change"
								onclick="showVerification()">인증</button>
						</div>

						<!-- 인증번호 입력 영역 (처음엔 숨김) -->
						<div id="verifyBox" class="verify-group" style="display: none;">
							<input type="text" id="verifyCode" placeholder="인증번호 입력">
							<button type="button" class="btn white">재전송</button>
							<button type="button" class="btn-change">확인</button>
						</div>

					</div>

					<!-- 이메일 -->
					<div class="form-group">
						<label>이메일</label> <input type="email"
							value="donguei123@naver.com">
					</div>

					<!-- 성별 -->
					<div class="form-group">
						<label>성별 *</label> <label><input type="radio"
							name="gender" checked> 남자</label> <label><input
							type="radio" name="gender"> 여자</label>
					</div>

					<!-- 키 & 몸무게 -->
					<div class="form-group">
						<label>키 & 몸무게</label>
						<div class="hw-group">
							<input type="number" placeholder="cm" min="0"> <input
								type="number" placeholder="kg" min="0">
						</div>
					</div>

					<!-- 생년월일 -->
					<div class="form-group">
						<label>생년월일 *</label>
						<div class="birth-group">
							<select name="birthYear" required>
								<option value="">년도 선택</option>
								<option>1998</option>
								<option>1999</option>
								<option>2000</option>
								<option>2001</option>
								<option>2002</option>
								<option>2003</option>
							</select>년 <select name="birthMonth" required>
								<option value="">월</option>
								<%
								for (int i = 1; i <= 12; i++) {
								%>
								<option><%=(i < 10 ? "0" : "") + i%></option>
								<%
								}
								%>
							</select>월 <select name="birthDay" required>
								<option value="">일</option>
								<%
								for (int i = 1; i <= 31; i++) {
								%>
								<option><%=(i < 10 ? "0" : "") + i%></option>
								<%
								}
								%>
							</select>일
						</div>
					</div>

					<button type="submit" class="submit-btn">회원 정보 수정</button>
					<a href="withdraw.jsp" class="withdraw-link">회원탈퇴</a>
				</form>
			</div>
		</section>
	</div>

</body>