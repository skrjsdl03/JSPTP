<!-- orderHistory.jsp -->

<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>주문 내역 | everyWEAR</title>
  <link rel="stylesheet" href="css/delivery.css">
  <link rel="stylesheet" href="css/order.css">
  <link rel="icon" type="image/png" href="images/logo-white.png">
</head>
<body>

<%@ include file="includes/mypageHeader.jsp" %>

<div class="order-container">
  <!-- 사이드바 -->
  <div class="sidebar">
    <div class="user-box">
      <p class="username">정시영 님</p>
      <div class="user-info">
        <div class="label">적립금</div><div class="value">25,000 ￦</div>
        <div class="label">쿠폰</div><div class="value">2 개</div>
      </div>
    </div>

    <ul class="side-menu">
      <li>회원 정보 수정</li>
      <li class="active">주문 내역</li>
      <li>장바구니</li>
      <li>찜 상품</li>
      <li>게시글 관리</li>
      <li>배송지 관리</li>
    </ul>
  </div>

<!-- 주문 내역 본문 시작 -->
<div class="order-content">
  <!-- 타이틀 + 경계선 -->
  <div class="delivery-title-wrap">
    <h2 class="delivery-title">주문 내역</h2>
  </div>

  <!-- 필터 드롭다운 -->
	<div class="order-filter">
	  <select id="statusFilter" onchange="filterOrders()">
	    <option value="all">전체</option>
	    <option value="shipping">배송중</option>
	    <option value="done">배송 완료</option>
	    <option value="cancel">주문 취소</option>
	  </select>
	</div>

  <!-- 주문 리스트 -->
  <div class="order-list">
    
    <!-- 주문 항목 -->
    <div class="order-row shipping">
      <img src="images/fav-icon.png" alt="상품 이미지">
      <div class="order-info">
        <p class="item-name">Onitsuka Tiger Tokuten Gray</p>
        <p class="item-option">220</p>
        <p class="item-count">수량: 1개</p>
      </div>
      <div class="order-meta">
        <p class="order-date">주문번호<br>2025-03-30</p>
        <p class="order-status shipping">배송중</p>
      </div>
    </div>

    <div class="order-row cancel">
      <img src="images/fav-icon.png" alt="상품 이미지">
      <div class="order-info">
        <p class="item-name">Montbell Poketable Light Pack 18 Black</p>
        <p class="item-option">one size</p>
        <p class="item-count">수량: 1개</p>
      </div>
      <div class="order-meta">
        <p class="order-date">주문번호<br>2025-03-30</p>
        <p class="order-status cancel">주문 취소</p>
      </div>
    </div>

    <div class="order-row done">
      <img src="images/fav-icon.png" alt="상품 이미지">
      <div class="order-info">
        <p class="item-name">Arc'teryx Konseal 15 Backpack Black</p>
        <p class="item-option">one size</p>
        <p class="item-count">수량: 1개</p>
      </div>
      <div class="order-meta">
        <p class="order-date">주문번호<br>2025-03-30</p>
        <p class="order-status done">배송 완료</p>
      </div>
    </div>

  </div>
</div>
</div>

		<!-- 페이지네이션 -->
		<div class="simple-pagination">
		  <a href="#" class="page-link">Prev</a>
		  <a href="#" class="page-link active">1</a>
		  <a href="#" class="page-link">2</a>
		  <a href="#" class="page-link">3</a>
		  <a href="#" class="page-link">4</a>
		  <a href="#" class="page-link">5</a>
		  <a href="#" class="page-link">Next</a>
		</div>

<footer>2025©everyWEAR</footer>

<script>
  function filterOrders() {
    const selected = document.getElementById("statusFilter").value;
    const orders = document.querySelectorAll(".order-row");

    orders.forEach(order => {
      if (selected === "all") {
        order.style.display = "flex";
      } else {
        order.style.display = order.classList.contains(selected) ? "flex" : "none";
      }
    });
  }
</script>

</body>
</html>
