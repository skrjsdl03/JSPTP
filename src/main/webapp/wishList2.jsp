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
			<!-- 찜 목록 본문 -->
			<div class="wishlist-content">

				<!-- 상품 1 -->
				<div class="wishlist-item">
					<img src="images/wishList1.jpg" alt="바지">
					<div class="wishlist-info">
						<p class="wishlist-name">B.C.L DENIM PANTS</p>
						<p class="wishlist-price">89,000 원</p>
					</div>
					<div class="wishlist-cart" onclick="addToCart(this)">🛒</div>
					<div class="wishlist-heart active" onclick="toggleWishlistHeart(this)">❤️</div>
				</div>
				
				<!-- 상품 3 -->
				<div class="wishlist-item">
					<img src="images/wishList2.jpg" alt="아우터">
					<div class="wishlist-info">
						<p class="wishlist-name">SYMBOL LOGO HOODED ZIP-UP </p>
						<p class="wishlist-price">109,000 원</p>
					</div>
					<div class="wishlist-cart" onclick="addToCart(this)">🛒</div>
					<div class="wishlist-heart active" onclick="toggleWishlistHeart(this)">❤️</div>
				</div>

				<!-- 상품 2 (품절) -->
				<div class="wishlist-item soldout">
					<img src="images/wishList3.jpg" alt="양말">
					<div class="wishlist-info">
						<p class="wishlist-name">NM TRIBAL SOCKS</p>
						<p class="wishlist-price">9,000 원</p>
					</div>
					<div class="wishlist-heart-group">
					  <div class="wishlist-cart" onclick="addToCart(this)">🛒</div>
					  <div class="wishlist-heart active" onclick="toggleWishlistHeart(this)">❤️</div>
					</div>
				</div>
		</section>
	</div>
</body>
<script>

function addToCart(el) {
	  const item = el.closest(".wishlist-item");

	  // 혹시라도 JS 쪽에서 한 번 더 체크하고 싶다면 (선택사항)
	  if (item.classList.contains("soldout")) {
	    alert("품절 상품은 장바구니에 담을 수 없습니다.");
	    return;
	  }

	  const itemName = item.querySelector(".wishlist-name").innerText;
	  alert(`'${itemName}' 상품을 장바구니에 담았습니다.`);

	  // TODO: 장바구니에 실제 추가하는 로직
	}
  
  function toggleWishlistHeart(el) {
    const item = el.closest(".wishlist-item");
    const isActive = el.classList.contains("active");

    if (isActive) {
      // 확인 창
      const confirmDelete = confirm("찜 상품을 해제하시겠습니까?");
      if (!confirmDelete) return;

      // 찜 해제 처리
      el.classList.remove("active");
      el.innerText = "🤍";
      item.remove(); // DOM에서 삭제
    } else {
      el.classList.add("active");
      el.innerText = "❤️";
      // 다시 찜하기 기능은 여기에 필요 시 추가
    }

    // TODO: 서버에 찜 상태 변경 요청 (AJAX 등)
  }
</script>

</html>