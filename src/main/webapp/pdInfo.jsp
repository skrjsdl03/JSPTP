<!-- main2.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>에브리웨어 | everyWEAR</title>
<link rel="stylesheet" type="text/css" href="css/pdListAll.css">
<link rel="icon" type="image/png" href="images/fav-icon.png">
<link rel="stylesheet"
	href="https://unpkg.com/swiper/swiper-bundle.min.css" />
</head>
<body>

	<%@ include file="includes/header.jsp"%>

	<!-- 하위 네비 -->
	<nav class="sub-nav">
		<ul>
			<li><a href="pdListAll.jsp" class="active">ALL</a></li>
			<li><a href="#">OUTER</a></li>
			<li><a href="#">TOP</a></li>
			<li><a href="#">BOTTOM</a></li>
			<li><a href="#">ACC</a></li>
		</ul>
	</nav>

	<div class="product-detail-wrapper">

		<!-- 상품 이미지 및 정보 -->
		<div class="product-top">
			<div class="product-images">
				<img src="images/main-cloth1.png" alt="제품 메인 이미지">
			</div>
			<div class="product-info">
				<h2>SLUSH ZIPPER JACKET - WASHED GRAY</h2>
				<p class="product-code">Product Code: EW001-GRY</p>

				<div class="color-select">
					<label>COLOR</label>
					<div class="color-options">
						<div class="color gray"></div>
						<div class="color black"></div>
					</div>
				</div>

				<div class="size-select">
					<label>SIZE</label> <select>
						<option>1 (S~M)</option>
						<option>2 (M~L)</option>
						<option>3 (L~XL)</option>
					</select>
				</div>

				<div class="buy-buttons">
					<button class="buy-now">바로 구매</button>
					<button class="wishlist">♡</button>
				</div>

				<div class="product-desc">
					<p>코튼 100% 워싱 가공</p>
					<p>투웨이 지퍼 / 하단 버튼</p>
					<p>사이드 포켓, 암홀 컷팅</p>
				</div>
			</div>
		</div>

		<!-- 상세 이미지 -->
		<div class="product-details">
			<img src="images/main-cloth1.png" alt="디테일1">
			<img src="images/main-cloth1.png" alt="디테일2">
			<img src="images/item01_detail3.jpg" alt="디테일3">
			<img src="images/item01_detail4.jpg" alt="디테일4">
		</div>

		<!-- 리뷰 -->
		<div class="product-review">
			<h3>REVIEW (41)</h3>
			<div class="review-score">⭐ 4.8 / 5.0</div>
			<div class="review-graph">
				<p>5점: ██████████</p>
				<p>4점: ██████</p>
				<p>3점 이하: █</p>
			</div>
		</div>
	</div>

</body>
</html>