<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
// 1. 상품 ID 받기
/* String id = request.getParameter("id");
if (id == null)
	id = "101"; */

// 2. 가짜 상품 데이터 생성
class Product {
	String id, name, size, color;
	int price;
	String thumbnail; // 대표 이미지
	List<String> detailImages; // 상세 이미지들

	Product(String id, String name, int price, String size, String color, String thumbnail, List<String> detailImages) {
		this.id = id;
		this.name = name;
		this.price = price;
		this.size = size;
		this.color = color;
		this.thumbnail = thumbnail;
		this.detailImages = detailImages;
	}
}

List<Product> allProducts = new ArrayList<>();
allProducts.add(new Product("101", "오버핏 자켓", 89000, "M / L", "Black", "images/main-cloth1.png",
		Arrays.asList("images/main-cloth2.png", "images/main-cloth3.png")));
allProducts.add(new Product("102", "데님 팬츠", 69000, "S / M / L", "Blue", "images/main-cloth1.png",
		Arrays.asList("images/main-cloth2.png", "images/main-cloth3.png")));

// 3. 상품 찾기
/* Product selected = null;
for (Product p : allProducts) {
	if (p.id.equals(id)) {
		selected = p;
		break;
	}
} */

/* if (selected == null) {
	out.println("<h2>해당 상품을 찾을 수 없습니다.</h2>");
	return;
} */
%>
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

	<!-- 대분류 카테고리 -->
	<nav class="sub-nav">
		<ul>
			<li><a href="splitTest2.jsp?cat=all">ALL</a></li>
			<li><a href="splitTest2.jsp?cat=outer">OUTER</a></li>
			<li><a href="splitTest2.jsp?cat=top">TOP</a></li>
			<li><a href="splitTest2.jsp?cat=bottom">BOTTOM</a></li>
			<li><a href="splitTest2.jsp?cat=acc">ACC</a></li>
			<li><a href="splitTest2.jsp?cat=etc">ETC</a></li>
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
						<button class="btn outline">ADD TO CART</button>
						<button class="btn filled">BUY NOW</button>
						<button class="btn wishlist-btn" id="wishlistBtn">🤍</button>
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
				<div class="rating-row">
					<div class="rating-label">아주 좋아요</div>
					<div class="bar">
						<div class="fill" style="width: 100%;"></div>
					</div>
					<div class="rating-count">10</div>
				</div>
				<div class="rating-row">
					<div class="rating-label">맘에 들어요</div>
					<div class="bar">
						<div class="fill" style="width: 0%;"></div>
					</div>
					<div class="rating-count">0</div>
				</div>
				<div class="rating-row">
					<div class="rating-label">보통이에요</div>
					<div class="bar">
						<div class="fill" style="width: 0%;"></div>
					</div>
					<div class="rating-count">0</div>
				</div>
				<div class="rating-row">
					<div class="rating-label">그냥 그래요</div>
					<div class="bar">
						<div class="fill" style="width: 0%;"></div>
					</div>
					<div class="rating-count">0</div>
				</div>
				<div class="rating-row">
					<div class="rating-label">별로예요</div>
					<div class="bar">
						<div class="fill" style="width: 0%;"></div>
					</div>
					<div class="rating-count">0</div>
				</div>
				<!-- 나머지도 동일하게 반복 -->
			</div>

		</div>

		<!-- 필터 및 정렬 -->
		<div class="review-filters">
			<div class="sort">
				<span class="sort-option inactive">추천순</span> |
				<span class="sort-option active">최신순</span>
			</div>
			<div class="photo-toggle">📷 포토/영상 리뷰만 보기</div>
			<input type="text" placeholder="리뷰 키워드 검색" />
		</div>
		
		<div class="review-filters2">
			<div class="filter-box">
				<button class="filter-btn" data-target="star-filter">별점 ▽</button>
				<button class="filter-btn" data-target="height-filter">키 ▽</button>
				<button class="filter-btn" data-target="weight-filter">몸무게 ▽</button>
				<button class="filter-btn" data-target="size-filter">사이즈 ▽</button>
			</div>

			<!-- 별점 필터 드롭다운 -->
			<div class="filter-dropdown" id="star-filter">
				<div class="dropdown-header">
					<span>별점</span>
					<button class="reset-btn">초기화 🔄</button>
				</div>
				<ul class="star-options">
					<li><span>★★★★★</span> 아주 좋아요 <input type="checkbox"></li>
					<li><span>★★★★☆</span> 맘에 들어요 <input type="checkbox"></li>
					<li><span>★★★☆☆</span> 보통이에요 <input type="checkbox"></li>
					<li><span>★★☆☆☆</span> 그냥 그래요 <input type="checkbox"></li>
					<li><span>★☆☆☆☆</span> 별로예요 <input type="checkbox"></li>
				</ul>
				<button class="complete-btn">완료</button>
			</div>
		</div>
		
		<!-- 키 필터 드롭다운 -->
<div class="filter-dropdown" id="height-filter">
  <div class="dropdown-header">
    <span>키</span>
    <button class="reset-btn" onclick="resetHeightFilter()">초기화 🔄</button>
  </div>
  
  <div class="height-options">
    <button class="height-btn">149 cm 이하</button>
    <button class="height-btn">150 ~ 152 cm</button>
    <button class="height-btn">153 ~ 155 cm</button>
    <button class="height-btn">156 ~ 158 cm</button>
    <button class="height-btn">159 ~ 161 cm</button>
    <button class="height-btn">162 ~ 164 cm</button>
    <button class="height-btn">165 ~ 167 cm</button>
    <button class="height-btn">168 ~ 170 cm</button>
    <button class="height-btn">171 ~ 173 cm</button>
    <button class="height-btn">174 ~ 176 cm</button>
    <button class="height-btn">177 ~ 179 cm</button>
    <button class="height-btn">180 ~ 182 cm</button>
    <button class="height-btn">183 ~ 185 cm</button>
    <button class="height-btn">186 ~ 188 cm</button>
    <button class="height-btn">189 ~ 191 cm</button>
    <button class="height-btn">192 cm 이상</button>
  </div>

  <button class="complete-btn">완료</button>
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

	<!-- Q&A 영역 -->
	<section class="qna-section">
		<h2>Q&amp;A</h2>
		<hr class="qna-divider">

		<div class="qna-list">
			<div class="qna-item">
				<span class="qna-lock">🔒</span> <span class="qna-title">배송관련
					문의입니다.</span>
				<div class="qna-meta">
					<span class="qna-status">답변 예정</span> <span class="qna-date">2025-03-30</span>
					<span class="qna-category">배송 문의</span>
				</div>
			</div>

			<div class="qna-item">
				<span class="qna-lock">🔒</span> <span class="qna-title">제품
					상세 문의입니다.</span>
				<div class="qna-meta">
					<span class="qna-status">답변 완료</span> <span class="qna-date">2025-03-30</span>
					<span class="qna-category">제품 상세 문의</span>
				</div>
			</div>

			<div class="qna-item">
				<span class="qna-lock">🔒</span> <span class="qna-title">배송관련
					문의입니다.</span>
				<div class="qna-meta">
					<span class="qna-status">답변 완료</span> <span class="qna-date">2025-03-30</span>
					<span class="qna-category">배송 문의</span>
				</div>
			</div>
		</div>

		<div class="qna-btn-wrapper">
			<button class="qna-write-btn"
			onclick="location.href='qnaForm.jsp'">작성하기</button>
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

	<script>
 		document.addEventListener("DOMContentLoaded", () => {
    	const wishlistBtn = document.getElementById("wishlistBtn");

    	wishlistBtn.addEventListener("click", () => {
      	wishlistBtn.classList.toggle("active");
      	wishlistBtn.textContent = wishlistBtn.classList.contains("active") ? "❤️" : "🤍";
    	});
  	});
	</script>

	<script>
	document.addEventListener("DOMContentLoaded", () => {
	  // 필터 버튼 클릭 시 드롭다운 열기
	  document.querySelectorAll(".filter-btn").forEach(btn => {
	    btn.addEventListener("click", () => {
	      const targetId = btn.dataset.target;
	      const dropdown = document.getElementById(targetId);
	
	      // 다른 드롭다운 닫기
	      document.querySelectorAll(".filter-dropdown").forEach(el => {
	        if (el !== dropdown) el.style.display = "none";
	      });
	
	      // 현재 드롭다운 토글
	      dropdown.style.display = dropdown.style.display === "block" ? "none" : "block";
	    });
	  });
	
	  // ✅ 완료 버튼 클릭 시 드롭다운 닫기
	  document.querySelectorAll(".complete-btn").forEach(btn => {
	    btn.addEventListener("click", () => {
	      const dropdown = btn.closest(".filter-dropdown");
	      dropdown.style.display = "none";
	    });
	  });
	
	  // ✅ 바깥 클릭 시 드롭다운 닫기 (선택)
	  document.addEventListener("click", (e) => {
	    if (!e.target.closest(".filter-box") && !e.target.closest(".filter-dropdown")) {
	      document.querySelectorAll(".filter-dropdown").forEach(el => el.style.display = "none");
	    }
	  });
	});
	</script>

</body>
</html>