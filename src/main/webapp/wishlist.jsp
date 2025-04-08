<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>찜 상품 | everyWEAR</title>
  <link rel="stylesheet" href="css/delivery.css">
  <link rel="stylesheet" href="css/wishlist.css">
  <link rel="icon" type="image/png" href="images/logo-white.png">
</head>
<body>

<%@ include file="includes/mypageHeader.jsp" %>

<div class="wishlist-container">
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
      <li>주문 내역</li>
      <li>장바구니</li>
      <li class="active">찜 상품</li>
      <li>게시글 관리</li>
      <li>배송지 관리</li>
    </ul>
  </div>

  <!-- 찜 목록 본문 -->
  <div class="wishlist-content">
    <div class="wishlist-title-wrap">
      <h2 class="wishlist-title">찜 상품</h2>
    </div>

    <!-- 상품 1 -->
    <div class="wishlist-item">
      <img src="images/fav-icon.png" alt="신발">
      <div class="wishlist-info">
        <p class="wishlist-name">Onitsuka Tiger Tokuten Gray</p>
        <p class="wishlist-price">199,000 원</p>
      </div>
		<div class="wishlist-heart" onclick="removeWishlistItem(this)">❤️</div>
    </div>

    <!-- 상품 2 (품절) -->
    <div class="wishlist-item soldout">
      <img src="images/fav-icon.png" alt="가방">
      <div class="wishlist-info">
        <p class="wishlist-name">Montbell Poketable Light Pack 18 Black</p>
        <p class="wishlist-price">140,000 원</p>
      </div>
		<div class="wishlist-heart" onclick="removeWishlistItem(this)">❤️</div>
    </div>

    <!-- 상품 3 -->
    <div class="wishlist-item">
      <img src="images/fav-icon.png" alt="백팩">
      <div class="wishlist-info">
        <p class="wishlist-name">Arc'teryx Konseal 15 Backpack Black</p>
        <p class="wishlist-price">140,000 원</p>
      </div>
		<div class="wishlist-heart" onclick="removeWishlistItem(this)">❤️</div>
    </div>
  </div>
</div>

<footer>2025©everyWEAR</footer>

<script>
  function removeWishlistItem(heartElement) {
    const item = heartElement.closest('.wishlist-item');
    if (item) {
      item.remove();
    }
  }
</script>

</body>
</html>
