<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>에브리웨어 | everyWEAR</title>
<link rel="icon" type="image/png" href="images/fav-icon.png">
<link rel="stylesheet" type="text/css" href="css/wishList2.css">
</head>
<body>

	<%@ include file="includes/header.jsp"%>

	<section2 class="content2">
	<h3>찜 목록</h3>
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
				<li><a href="cart2.jsp">장바구니</a></li>
				<li><a href="wishList2.jsp">찜 상품</a></li>
				<li><a href="postMn.jsp">게시물 관리</a></li>
				<li><a href="deliveryMn.jsp">배송지 관리</a></li>
			</ul>
		</aside>

		<section class="content">
			<!-- 찜 목록 본문 -->
			<div class="wishlist-content">

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
						<p class="wishlist-name">Montbell Poketable Light Pack 18
							Black</p>
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
		</section>
	</div>
</body>