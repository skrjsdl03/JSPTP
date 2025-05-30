<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>에브리웨어 | everyWEAR</title>
<link rel="icon" type="image/png" href="images/fav-icon.png">
<link rel="stylesheet" type="text/css" href="css/orderHistory.css">
</head>
<body>

	<%@ include file="includes/header.jsp"%>

	<section2 class="content2">
	<h3>주문 내역</h3>
	</section2>

	<div class="container">
		<div class="user-box">
			<p class="username">정시영 님</p>
			<div class="user-info">
				<div class="label">적립금</div>
				<div class="value">25,000 ￦</div>
				<div class="label"><a href="coupon.jsp">쿠폰</a></div>
				<div class="value">2 개</div>
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
			<!-- 주문 내역 본문 시작 -->
			<div class="order-content">

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
						<img src="images/orderHistory2.jpg" alt="상품 이미지">
						<div class="order-info">
							<p class="item-name">S.S PRINT T-SHIRT</p>
							<p class="item-option">L</p>
							<p class="item-count">수량: 1개</p>
						</div>
						<div class="order-meta">
							<p class="order-date">
								주문번호<br>2025-03-30
							</p>
							<p class="order-status shipping">배송중</p>
						</div>
					</div>

					<div class="order-row cancel">
						<img src="images/orderHistory.jpg" alt="상품 이미지">
						<div class="order-info">
							<p class="item-name">2P GYM SACK</p>
							<p class="item-option">one size</p>
							<p class="item-count">수량: 1개</p>
						</div>
						<div class="order-meta">
							<p class="order-date">
								주문번호<br>2025-03-30
							</p>
							<p class="order-status cancel">주문 취소</p>
						</div>
					</div>

					<div class="order-row done">
						<img src="images/orderHistory3.jpg" alt="상품 이미지">
						<div class="order-info">
							<p class="item-name">AETHER NYLON JACKET</p>
							<p class="item-option">one size</p>
							<p class="item-count">수량: 1개</p>
						</div>
						<div class="order-meta">
							<p class="order-date">
								주문번호<br>2025-03-30
							</p>
							<p class="order-status done">배송 완료</p>
							<button class="review-button" onclick="location.href='reviewForm.jsp'">리뷰작성</button>
						</div>
					</div>

				</div>
			</div>
		</section>
	</div>

</body>