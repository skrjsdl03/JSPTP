<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
// 1. 상품 ID 받기
String productId = request.getParameter("id");
if (productId == null)
	productId = "101";

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
allProducts.add(new Product("103", "오버핏 자켓", 89000, "M / L", "Black", "images/main-cloth1.png",
		Arrays.asList("images/main-cloth2.png", "images/main-cloth3.png")));
allProducts.add(new Product("104", "데님 팬츠", 69000, "S / M / L", "Blue", "images/main-cloth1.png",
		Arrays.asList("images/main-cloth2.png", "images/main-cloth3.png")));
allProducts.add(new Product("105", "오버핏 자켓", 89000, "M / L", "Black", "images/main-cloth1.png",
		Arrays.asList("images/main-cloth2.png", "images/main-cloth3.png")));
allProducts.add(new Product("106", "데님 팬츠", 69000, "S / M / L", "Blue", "images/main-cloth1.png",
		Arrays.asList("images/main-cloth2.png", "images/main-cloth3.png")));
allProducts.add(new Product("107", "오버핏 자켓", 89000, "M / L", "Black", "images/main-cloth1.png",
		Arrays.asList("images/main-cloth2.png", "images/main-cloth3.png")));
allProducts.add(new Product("108", "데님 팬츠", 69000, "S / M / L", "Blue", "images/main-cloth1.png",
		Arrays.asList("images/main-cloth2.png", "images/main-cloth3.png")));
allProducts.add(new Product("109", "오버핏 자켓", 89000, "M / L", "Black", "images/main-cloth1.png",
		Arrays.asList("images/main-cloth2.png", "images/main-cloth3.png")));
allProducts.add(new Product("110", "데님 팬츠", 69000, "S / M / L", "Blue", "images/main-cloth1.png",
		Arrays.asList("images/main-cloth2.png", "images/main-cloth3.png")));
allProducts.add(new Product("111", "오버핏 자켓", 89000, "M / L", "Black", "images/main-cloth1.png",
		Arrays.asList("images/main-cloth2.png", "images/main-cloth3.png")));
allProducts.add(new Product("112", "데님 팬츠", 69000, "S / M / L", "Blue", "images/main-cloth1.png",
		Arrays.asList("images/main-cloth2.png", "images/main-cloth3.png")));
allProducts.add(new Product("113", "오버핏 자켓", 89000, "M / L", "Black", "images/main-cloth1.png",
		Arrays.asList("images/main-cloth2.png", "images/main-cloth3.png")));
allProducts.add(new Product("114", "데님 팬츠", 69000, "S / M / L", "Blue", "images/main-cloth1.png",
		Arrays.asList("images/main-cloth2.png", "images/main-cloth3.png")));
allProducts.add(new Product("115", "데님 팬츠", 69000, "S / M / L", "Blue", "images/main-cloth1.png",
		Arrays.asList("images/main-cloth2.png", "images/main-cloth3.png")));

// 3. 상품 찾기
Product selected = null;
for (Product p : allProducts) {
	if (p.id.equals(productId)) {
		selected = p;
		break;
	}
}

if (selected == null) {
	out.println("<h2>해당 상품을 찾을 수 없습니다.</h2>");
	return;
}
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
			<li><a href="pdListPmTest.jsp?category=all" class="active">ALL</a></li>
			<li><a href="pdListPmTest.jsp?category=outer">OUTER</a></li>
			<li><a href="pdListPmTest.jsp?category=top">TOP</a></li>
			<li><a href="pdListPmTest.jsp?category=bottom">BOTTOM</a></li>
			<li><a href="pdListPmTest.jsp?category=acc">ACC</a></li>
		</ul>
	</nav>

	<div class="container">
		<!-- ✅ 왼쪽 패널: 상품 요약 -->
		<div class="left-panel">
			<img src="<%=selected.thumbnail%>" alt="<%=selected.name%>">
			<p class="product-name"><%=selected.name%></p>
			<p class="price">
				KRW
				<%=selected.price%></p>
			<p class="info">
				사이즈:
				<%=selected.size%></p>
			<p class="info">
				컬러:
				<%=selected.color%></p>
		</div>

		<!-- ✅ 오른쪽 패널: 상세 이미지 -->
		<div class="right-panel">
			<%
			for (String img : selected.detailImages) {
			%>
			<img src="<%=img%>" alt="상세 이미지">
			<%
			}
			%>
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