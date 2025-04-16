<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>에브리웨어 | everyWEAR</title>
<link rel="stylesheet" type="text/css" href="css/pdDetail.css">
<link rel="icon" type="image/png" href="images/fav-icon.png">
</head>
<body>

	<%@ include file="includes/header.jsp"%>

	<!-- 하위 네비 -->
	<nav class="sub-nav">
		<ul>
			<li><a href="splitTest.jsp" class="active">ALL</a></li>
			<li><a href="#">OUTER</a></li>
			<li><a href="#">TOP</a></li>
			<li><a href="#">BOTTOM</a></li>
			<li><a href="#">ACC</a></li>
		</ul>
	</nav>

	<div class="container">

		<div class="detail-panel" id="detailPanel">

			<div class="inner-panel left-panel">
				<div class="product-detail-wrapper">
					<img src="images/main-cloth1.png" alt="SLASH ZIPPER JACKET"
						class="product-image" />
					<h2 class="product-name">SLASH ZIPPER JACKET - WASHED GRAY</h2>
					<div class="price">KRW 199,500</div>

					<div class="section">
						<label class="section-title">COLOR</label>
						<div class="color-options">
							<div class="color-circle" style="background-color: #61584F;"></div>
							<div class="color-circle" style="background-color: #2A2B32;"></div>
						</div>
					</div>

					<div class="section">
						<label class="section-title">SIZE</label>
						<div class="size-options">
							<button class="size-btn disabled">S [재입고 알림]</button>
							<button class="size-btn">M</button>
							<button class="size-btn">L</button>
						</div>
					</div>

					<div class="selection-preview">
						SLASH ZIPPER JACKET - WASHED GRAY 옵션: S <span class="remove">X</span>
					</div>

					<div class="notify-btn">
						<button>🔔 재입고 알림</button>
					</div>

					<div class="total-price">TOTAL: KRW 0 (0개)</div>

					<div class="buy-buttons">
						<button class="btn outline">ADD TO BAG</button>
						<button class="btn filled">BUY NOW</button>
					</div>

					<div class="section">
						<h4 class="guide-title">SIZE(cm) / GUIDE</h4>
						<p>
							S - Length 58.5 / Shoulder 47 / Chest 57 / Arm 62<br> M -
							Length 61 / Shoulder 49 / Chest 59.5 / Arm 63<br> L - Length
							63.5 / Shoulder 51 / Chest 62 / Arm 64
						</p>
						<p>
							MODEL<br>MAN : 181CM(L SIZE)
						</p>
						<p>
							COTTON 65%<br>NYLON 35%
						</p>
						<p>
							WAIST SNAP<br>2WAY ZIPPER (YKK社)
						</p>
					</div>

					<div class="info-note">
						* 워싱 제품 특성상 개체 차이가 존재 합니다.<br> * Object differences exist due
						to the nature of the washed product.<br> <br> * 두꼬운 포리벡
						특성상 옷에 슬립제가 무다나올 수 있습니다.<br> * 어두운 색 계열의 상품 구매 시 보이는 슬립제는 불량의
						사유가 아니라는 것을 알려드립니다.<br> * The slip agent on dark clothes is
						not defective.
					</div>
				</div>
			</div>

			<div class="inner-panel right-panel">
				<div class="image-wrapper">
					<img src="images/main-cloth1.png">
					<img src="images/main-cloth1.png">
					<img src="images/main-cloth1.png">
				</div>
			</div>

		</div>

	</div>

</body>
</html>