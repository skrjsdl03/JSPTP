<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>에브리웨어 | everyWEAR</title>
<link rel="stylesheet" type="text/css" href="css/pdDetail.css">
<link rel="icon" type="image/png" href="images/fav-icon.png">
<!-- Swiper CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />

<!-- Swiper JS -->
<script
	src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

</head>
<body>

	<%@ include file="includes/header.jsp"%>

	<!-- 하위 네비 -->
	<nav class="sub-nav">
		<ul>
			<li><a href="splitTest2.jsp" class="active">ALL</a></li>
			<li><a href="#">OUTER</a></li>
			<li><a href="#">TOP</a></li>
			<li><a href="#">BOTTOM</a></li>
			<li><a href="#">ACC</a></li>
		</ul>
	</nav>
	<nav class="sub-nav2">
		<ul>
			<li><a href="pdListAll.jsp" class="active">HEAVY OUTER</a></li>
			<li><a href="#">HOODED ZIP-UP</a></li>
			<li><a href="#">JACKET</a></li>
			<li><a href="#">JUMPER</a></li>
			<li><a href="#">VEST</a></li>
			<li><a href="#">WIND BREAKER</a></li>
		</ul>
	</nav>

	<div class="container">

		<div class="detail-panel" id="detailPanel">

			<div class="inner-panel left-panel">
				<div class="product-detail-wrapper">
					<img src="images/main-cloth4.png" alt="SLASH ZIPPER JACKET"
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

					<div class="section2">
						<button class="guide-toggle" onclick="toggleGuide()">
							SIZE(cm) / GUIDE</button>
						<div class="guide-content" id="guideContent">
							<p>
								S (WOMAN) - Length 52 / Shoulder 36.5 / Chest 46 / Arm 17<br>
								M - Length 71 / Shoulder 53.5 / Chest 58 / Arm 23.5<br> L -
								Length 74 / Shoulder 56 / Chest 60.5 / Arm 24.5<br> XL -
								Length 77 / Shoulder 58.5 / Chest 63 / Arm 25.5
							</p>
							<p>
								MODEL<br> MAN : 175CM(L SIZE)
							</p>
							<p>
								COTTON 65%<br> NYLON 35%
							</p>
							<p>
								WAIST SNAP<br> 2WAY ZIPPER (YKK社)
							</p>
							<p>
								* 워싱 제품 특성상 개체 차이가 존재 합니다.<br> * Object differences exist
								due to the nature of the washed product.
							</p>
							<p>
								* 두꼬운 포리벡 특성상 옷에 슬립제가 무다나올 수 있습니다.<br> * 어두운 색 계열의 상품 구매 시
								보이는 슬립제는 불량의 사유가 아니라는 것을 알려드립니다.<br> * The slip agent on
								dark clothes is not defective.
							</p>
						</div>
					</div>

					<div class="section2">
						<button class="guide-toggle" onclick="toggleGuide()">
							SHIPPING</button>
						<div class="guide-content" id="guideContent">
							<p>
								배송 방법 : 택배<br> 배송 지역 : 전국지역<br> 배송 비용 : 무료<br> 배송
								기간 : 3일 ~ 7일<br> 배송 안내 :<br> 고객님께서 주문하신 상품은 결제 확인 후 발송
								됩니다.
							</p>
							<p>오전 9시 이전 결제건에 대해서는 당일 발송 됩니다.</p>
							<p>배송 완료까지 1~2 영업일 소요 됩니다.</p>
							<p>다만, 상품 종류에 따라서 상품의 배송이 다소 지연될 수 있습니다.</p>
						</div>
					</div>
					<div class="section2">
						<button class="guide-toggle" onclick="toggleGuide()">
							RETURN</button>
						<div class="guide-content" id="guideContent">
							<p>
								교환 및 반품이 가능한 경우<br> - 상품을 공급 받으신 날로부터 7일 이내 교환/반품 신청이
								가능합니다.<br> - 물류 센터에 반송된 상품의 입고 여부가 확인된 후에 제품 검품 후 환불 처리
								됩니다.<br> - 단순변심(색상 교환, 사이즈 교환 등 포함)으로 인한 상품의 교환/반품의 경우, 택배
								비용은 고객 부담이오니 이 점 양해 바랍니다.
							</p>
							<p>
								교환 및 반품이 불가능한 경우<br> - 상품 수령 후 7일이 지난 경우<br> - 포장을
								개봉하였거나 포장이 훼손되어 상품 가치가 현저히 상실된 경우<br> - 고객의 사용 또는 일부 소비에
								의하여 상품의 가치가 현저히 감소한 경우 (예: 제품의 구김이나 기타 오염, 세탁, 채취, 화장품의 흔적, 애완동물
								털 등)<br> - 상품의 택, 스티커, 비닐 포장 등을 훼손 및 멸실한 경우<br> - 시간의
								경과에 의하여 재판매가 곤란할 정도로 상품 등의 가치가 현저히 감소한 경우<br> - 상품과 함께
								동봉해드린 사은품이 누락된 경우
							</p>
						</div>
					</div>

				</div>

			</div>

			<div class="inner-panel right-panel">
				<div class="image-wrapper">
					<img src="images/main-cloth1.png"> <img
						src="images/main-cloth1.png"> <img
						src="images/main-cloth1.png">
				</div>
			</div>
		</div>
	</div>

	<div class="buy-with-section">
		<h3>BUY WITH</h3>

		<div class="swiper buy-with-slider">
			<div class="swiper-wrapper">
				<div class="swiper-slide slider-item">
					<img src="images/main-cloth1.png" alt="NM LEATHER BELT" />
					<p class="item-name">NM LEATHER BELT - BLACK</p>
					<p class="item-price">
						<del>KRW 69,000</del>
						KRW 65,550
					</p>
					<a href="#">ADD TO BAG</a>
				</div>

				<div class="swiper-slide slider-item">
					<img src="images/main-cloth2.png" alt="METAL SYMBOL BELT" />
					<p class="item-name">METAL SYMBOL BELT - BLACK</p>
					<p class="item-price">
						<del>KRW 73,000</del>
						KRW 69,350
					</p>
					<a href="#">ADD TO BAG</a>
				</div>

				<div class="swiper-slide slider-item">
					<img src="images/main-cloth2.png" alt="METAL SYMBOL BELT" />
					<p class="item-name">METAL SYMBOL BELT - BLACK</p>
					<p class="item-price">
						<del>KRW 73,000</del>
						KRW 69,350
					</p>
					<a href="#">ADD TO BAG</a>
				</div>

				<div class="swiper-slide slider-item">
					<img src="images/main-cloth2.png" alt="METAL SYMBOL BELT" />
					<p class="item-name">METAL SYMBOL BELT - BLACK</p>
					<p class="item-price">
						<del>KRW 73,000</del>
						KRW 69,350
					</p>
					<a href="#">ADD TO BAG</a>
				</div>

				<div class="swiper-slide slider-item">
					<img src="images/main-cloth2.png" alt="METAL SYMBOL BELT" />
					<p class="item-name">METAL SYMBOL BELT - BLACK</p>
					<p class="item-price">
						<del>KRW 73,000</del>
						KRW 69,350
					</p>
					<a href="#">ADD TO BAG</a>
				</div>

				<div class="swiper-slide slider-item">
					<img src="images/main-cloth2.png" alt="METAL SYMBOL BELT" />
					<p class="item-name">METAL SYMBOL BELT - BLACK</p>
					<p class="item-price">
						<del>KRW 73,000</del>
						KRW 69,350
					</p>
					<a href="#">ADD TO BAG</a>
				</div>

				<div class="swiper-slide slider-item">
					<img src="images/main-cloth2.png" alt="METAL SYMBOL BELT" />
					<p class="item-name">METAL SYMBOL BELT - BLACK</p>
					<p class="item-price">
						<del>KRW 73,000</del>
						KRW 69,350
					</p>
					<a href="#">ADD TO BAG</a>
				</div>

				<div class="swiper-slide slider-item">
					<img src="images/main-cloth2.png" alt="METAL SYMBOL BELT" />
					<p class="item-name">METAL SYMBOL BELT - BLACK</p>
					<p class="item-price">
						<del>KRW 73,000</del>
						KRW 69,350
					</p>
					<a href="#">ADD TO BAG</a>
				</div>

				<!-- 필요한 만큼 slide 복사 -->
			</div>
		</div>
	</div>

	<!-- 리뷰 영역 -->
	<section class="review-section">
		<h3>REVIEW (0)</h3>
		<div class="review-summary">
			<div class="rating-box">
				<div class="star-score">★ 4.8</div>
				<p>99%의 구매자가 이 상품을 좋아합니다.</p>
				<button class="write-review-btn">상품 리뷰 작성하기</button>
			</div>
			<div class="rating-bars">
				<p>
					아주 좋아요 <span class="bar"><span class="fill"
						style="width: 100%;"></span></span> 10
				</p>
				<p>
					맘에 들어요 <span class="bar"><span class="fill"
						style="width: 0%;"></span></span> 0
				</p>
				<p>
					보통이에요 <span class="bar"><span class="fill"
						style="width: 0%;"></span></span> 0
				</p>
				<p>
					그냥 그래요 <span class="bar"><span class="fill"
						style="width: 0%;"></span></span> 0
				</p>
				<p>
					별로예요 <span class="bar"><span class="fill" style="width: 0%;"></span></span>
					0
				</p>
			</div>
		</div>

		<!-- 필터 및 정렬 -->
		<div class="review-filters">
			<div class="sort">추천순 | 최신순</div>
			<div class="filter-box">
				<button>별점</button>
				<button>키</button>
				<button>몸무게</button>
				<button>평소 사이즈</button>
			</div>
			<div class="photo-toggle">📷 포토/영상 리뷰만 보기</div>
			<input type="text" placeholder="리뷰 키워드 검색" />
		</div>

		<!-- 리뷰 리스트 -->
		<div class="review-list">
			<div class="review-item">
				<p class="review-text">
					너무 예뻐요 흑흑흑<br>다른 색상도 사고 싶어용
				</p>
				<p class="review-meta">
					pw****님의 리뷰입니다.<br>키 | 몸무게 | 평소사이즈<br> <span
						class="review-sub">color</span> / <span class="review-sub">size</span>
				</p>
			</div>
		</div>
	</section>

	<script>
  	document.querySelectorAll(".guide-toggle").forEach(button => {
    	button.addEventListener("click", () => {
      	const content = button.nextElementSibling;
	
      	button.classList.toggle("active");
      	content.classList.toggle("open");
      	
    	});
  	});
	</script>

	<script>
  	document.addEventListener("DOMContentLoaded", function () {
    	new Swiper(".buy-with-slider", {
      	slidesPerView: "auto", // 슬라이드 너비에 맞춰 자동
      	spaceBetween: 40,
      	grabCursor: true, // 커서 스타일 변경
      	freeMode: true, // 드래그한 만큼 넘어감
    	});
  	});
	</script>


</body>
</html>