<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>결제 완료 | everyWEAR</title>
  <link rel="stylesheet" href="css/payComplete.css">
</head>
<body>

<%@ include file="includes/header.jsp"%>

<section class="content2">
  <h3 class="order-complete-message">결제 완료</h3>
</section>

<div class="order-container">

  <!-- 주문상품 -->
  <section class="product-section">
    <p class="section-title">주문상품</p>
    <div class="product-box">
      <img src="images/fav-icon.png" alt="상품 이미지" class="product-img">
      <div class="product-detail">
        <p class="product-name">Onitsuka Tiger Tokuten Gray</p>
        <p class="product-option">220</p>
        <p class="product-qty">수량 : <strong>1</strong></p>
      </div>
      
      <div class="product-price-box">
        <div class="order-summary-box">
          <p class="order-number">주문번호 : ORDER123456</p>
          <p class="final-price"><strong>202,000 원</strong></p>
        </div>
      </div>
    </div>
  </section>

  <!-- 접히는 정보 영역 -->
  <div class="dropdown-section">배송지</div>
  <div class="dropdown-content">
    <div class="info-row"><span class="label">주문자 정보와 동일</span><span class="value">47340 / 부산광역시 부산진구 엄광로 176 / 동의대학교</span></div>
  </div>

  <div class="dropdown-section">주문자 정보</div>
  <div class="dropdown-content">
    <div class="info-row"><span class="label">이름</span><span class="value">정시영</span></div>
    <div class="info-row"><span class="label">주소</span><span class="value">47340 / 부산광역시 부산진구 엄광로 176 / 동의대학교</span></div>
    <div class="info-row"><span class="label">휴대전화</span><span class="value">010-1234-5678</span></div>
    <div class="info-row"><span class="label">이메일</span><span class="value">dongeui123@naver.com</span></div>
  </div>

  <div class="dropdown-section">결제 정보</div>
  <div class="dropdown-content">
    <div class="info-row"><span class="label">상품 금액</span><span class="value">199,000 원</span></div>
    <div class="info-row"><span class="label">배송비</span><span class="value">+3,000 원</span></div>
    <div class="info-row"><span class="label">할인/부가결제</span><span class="value">-0 원</span></div>
  </div>

  <div class="dropdown-section">적립</div>
  <div class="dropdown-content">
    <div class="info-row"><span class="label">회원 적립금</span><span class="value">3,990 원</span></div>
    <div class="info-row"><span class="label">상품 적립금</span><span class="value">1,990 원</span></div>
  </div>

  <!-- main으로 돌아가기 -->
  <div class="back-to-home">
    <button onclick="location.href='main2.jsp'">홈으로 돌아가기</button>
  </div>
</div>

<footer class="footer">2025©everyWEAR</footer>

<script>
  // 드롭다운 기능
  document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll(".dropdown-section").forEach(function (section) {
      section.addEventListener("click", function () {
        section.classList.toggle("active");
      });
    });
  });
</script>

</body>
</html>
