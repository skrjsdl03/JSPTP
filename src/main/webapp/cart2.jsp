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
			<!-- 장바구니 본문 -->
			<div class="order-content">
				<!-- 상단 선택/삭제 -->
				<div class="order-row"
					style="justify-content: space-between; border-bottom: 1px solid #ddd;">
					<label><input type="checkbox" id="select-all" checked> 전체 선택</label>
					<div class="delete-box">
					  <span class="delete-text">선택 삭제</span>
					  <span class="delete-icon">&#10005;</span>
					</div>
				</div>

				<!-- 상품 1 -->
				<div class="order-row">
					<input type="checkbox"class="item-checkbox" checked> 
					<img src="images/fav-icon.png" alt="신발">
					<div class="order-info">
						<p class="item-name">Onitsuka Tiger Tokuten Gray</p>
						<p class="item-option">220</p>
						<div class="qty-control">
							<button class="qty-btn" onclick="changeQty(this, -1)">-</button>
							<span class="qty-value">1</span>
							<button class="qty-btn" onclick="changeQty(this, 1)">+</button>
						</div>
					</div>
					<div class="order-meta">
						<p style="text-align: right;">
							<a href="#"
								style="color: #999; font-size: 13px; text-decoration: none;">삭제</a>
							<br> <a href="#" class="option-button">옵션 변경</a> <br>
							<strong style="font-size: 14px;">199,000 원</strong>
						</p>
					</div>
				</div>

				<!-- 상품 2 -->
				<div class="order-row">
					<input type="checkbox" class="item-checkbox" checked> 
					<img src="images/fav-icon.png" alt="가방">
					<div class="order-info">
						<p class="item-name">Montbell Poketable Light Pack 18 Black</p>
						<p class="item-option">one size</p>
						<div class="qty-control">
							<button class="qty-btn" onclick="changeQty(this, -1)">-</button>
							<span class="qty-value">1</span>
							<button class="qty-btn" onclick="changeQty(this, 1)">+</button>
						</div>
					</div>
					<div class="order-meta">
						<p style="text-align: right;">
							<a href="#"
								style="color: #999; font-size: 13px; text-decoration: none;">삭제</a>
							<br> <a href="#" class="option-button">옵션 변경</a> <br>
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
<script>
  // 전체 선택 체크박스 클릭 시
  document.getElementById("select-all").addEventListener("change", function () {
    const isChecked = this.checked;
    document.querySelectorAll(".item-checkbox").forEach(cb => {
      cb.checked = isChecked;
    });
  });

  // 하위 체크박스 변경 시 → 전체선택 체크박스 상태 자동 반영
  document.querySelectorAll(".item-checkbox").forEach(cb => {
    cb.addEventListener("change", function () {
      const all = document.querySelectorAll(".item-checkbox").length;
      const checked = document.querySelectorAll(".item-checkbox:checked").length;
      document.getElementById("select-all").checked = all === checked;
    });
  });
</script>
</html>
