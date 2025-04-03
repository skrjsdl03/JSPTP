<!-- memberEditBasic.jsp -->

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
  String userId = (String) session.getAttribute("userId");
  if (userId == null) userId = "guest@everywear.com";
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>회원 정보 수정 | everyWEAR</title>
  <link rel="stylesheet" href="css/header.css">
  <link rel="stylesheet" href="css/memberEdit.css">
  <link rel="icon" type="image/png" href="images/logo-white.png">
</head>
<body>

<%@ include file="includes/mypageHeader.jsp" %>

<div class="edit-container">
  <div class="sidebar">
    <div class="user-box">
      <p class="username">정시영 님</p>
      <div class="user-info">
        <div class="label">적립금</div><div class="value">25,000 ￦</div>
        <div class="label">쿠폰</div><div class="value">2 개</div>
      </div>
    </div>

    <ul class="side-menu">
      <li class="active">회원 정보 수정</li>
      <li>주문 내역</li>
      <li>장바구니</li>
      <li>찜 상품</li>
      <li>게시글 관리</li>
      <li>배송지 관리</li>
    </ul>
  </div>

  <div class="edit-content">
    <form>
      <!-- ID -->
      <div class="form-group">
        <label>ID *</label>
        <div class="id-box">
          <span class="id-text"><%= userId %></span>
        </div>
      </div>

      <!-- PW -->
      <div class="form-group">
        <label>비밀번호 *</label>
        <input type="password" placeholder="비밀번호를 입력하세요" required>
      </div>

      <!-- 이름 -->
      <div class="form-group">
        <label>이름 *</label>
        <input type="text" value="정시영" placeholder="이름을 입력하세요" required>
      </div>

      <!-- 휴대전화 -->
      <div class="form-group">
        <label>휴대전화 *</label>
        <div class="phone-group">
          <input type="text" value="010" readonly>
          <input type="text" id="phone2" value="1234">
          <input type="text" id="phone3" value="5678">
          <button type="button" class="btn-change" onclick="showVerification()">인증</button>
        </div>
        <div id="verifyBox" class="verify-group" style="display:none;">
          <input type="text" id="verifyCode" placeholder="인증번호 입력">
          <button type="button" class="btn-change">확인</button>
        </div>
      </div>

      <!-- 이메일 -->
      <div class="form-group">
        <label>이메일</label>
        <input type="email" value="donguei123@naver.com">
      </div>

      <!-- 성별 -->
      <div class="form-group">
        <label>성별 *</label>
        <label><input type="radio" name="gender" checked> 남자</label>
        <label><input type="radio" name="gender"> 여자</label>
      </div>

      <!-- 키 & 몸무게 -->
      <div class="form-group">
        <label>키 & 몸무게</label>
        <div class="hw-group">
          <input type="number" placeholder="cm" min="0">
          <input type="number" placeholder="kg" min="0">
        </div>
      </div>

      <!-- 생년월일 -->
      <div class="form-group">
        <label>생년월일 *</label>
        <div class="birth-group">
          <select name="birthYear" required>
            <option value="">년도 선택</option>
            <option>1998</option><option>1999</option><option>2000</option>
            <option>2001</option><option>2002</option><option>2003</option>
          </select>년
          <select name="birthMonth" required>
            <option value="">월</option>
            <% for (int i = 1; i <= 12; i++) { %>
              <option><%= (i < 10 ? "0" : "") + i %></option>
            <% } %>
          </select>월
          <select name="birthDay" required>
            <option value="">일</option>
            <% for (int i = 1; i <= 31; i++) { %>
              <option><%= (i < 10 ? "0" : "") + i %></option>
            <% } %>
          </select>일
        </div>
      </div>

      <button type="submit" class="submit-btn">회원 정보 수정</button>
      <a href="withdraw.jsp" class="withdraw-link">회원탈퇴</a>
    </form>
  </div>
</div>

<footer>2025©everyWEAR</footer>

<script>
  function showVerification() {
    document.getElementById('verifyBox').style.display = 'flex';
  }
</script>

</body>
</html>
