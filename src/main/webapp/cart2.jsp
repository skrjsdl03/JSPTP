<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>에브리웨어 | everyWEAR</title>
<link rel="icon" type="image/png" href="images/fav-icon.png">
<link rel="stylesheet" type="text/css" href="css/cart.css">
</head>
<body>

	<%@ include file="includes/header.jsp"%>

	<section2 class="content2">
	<h3>장바구니</h3>
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
			<!-- 장바구니 본문 -->
			<div class="order-content">
				<!-- 상단 선택/삭제 -->
				<div class="order-row"
					style="justify-content: space-between; border-bottom: 1px solid #ddd;">
					<label><input type="checkbox" checked> 전체 선택</label>
					<div style="display: flex; align-items: center; gap: 6px;">
						<span>선택 삭제</span> <span style="cursor: pointer;">&#10005;</span>
					</div>
				</div>

				<!-- 상품 1 -->
				<div class="order-row">
					<input type="checkbox" checked> <img
						src="images/fav-icon.png" alt="신발">
					<div class="order-info">
						<p class="item-name">Onitsuka Tiger Tokuten Gray</p>
						<p class="item-option">220</p>
						<div class="qty-control-custom">
							<button class="btn-decrease" onclick="changeQty(this, -1)">-</button>
							<span class="qty-value">1</span>
							<button class="btn-increase" onclick="changeQty(this, 1)">+</button>
						</div>
					</div>
					<div class="order-meta">
						<p style="text-align: right;">
							<a href="#"
								style="color: #999; font-size: 13px; text-decoration: none;">삭제</a>
							<br> <a href="#" style="font-size: 13px;">옵션 변경</a> <br>
							<strong style="font-size: 14px;">199,000 원</strong>
						</p>
					</div>
				</div>

				<!-- 상품 2 -->
				<div class="order-row">
					<input type="checkbox" checked> <img
						src="images/fav-icon.png" alt="가방">
					<div class="order-info">
						<p class="item-name">Montbell Poketable Light Pack 18 Black</p>
						<p class="item-option">one size</p>
						<div class="cart-quantity">
							<button class="qty-btn" onclick="changeQty(this, -1)">-</button>
							<span class="qty-value">1</span>
							<button class="qty-btn" onclick="changeQty(this, 1)">+</button>
						</div>
					</div>
					<div class="order-meta">
						<p style="text-align: right;">
							<a href="#"
								style="color: #999; font-size: 13px; text-decoration: none;">삭제</a>
							<br> <a href="#" style="font-size: 13px;">옵션 변경</a> <br>
							<strong style="font-size: 14px;">140,000 원</strong>
						</p>
					</div>
				</div>

				<!-- 주문하기 버튼 -->
				<div
					style="width: 100%; display: flex; justify-content: center; margin-top: 40px;">
					<button
						style="background: black; color: white; border: none; padding: 12px 40px; font-size: 14px; border-radius: 6px; cursor: pointer;">주문하기</button>
				</div>
			</div>
		</section>
	</div>

</body>