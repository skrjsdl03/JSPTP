<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>에브리웨어 | everyWEAR</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="icon" type="image/png" href="images/logo-white.png">
<link rel="stylesheet"
	href="https://unpkg.com/swiper/swiper-bundle.min.css" />
</head>
<body>
 
	<%@ include file="includes/header.jsp"%>

	<!-- 여기부터 메인 컨텐츠 시작 -->
	<section class="main-collection">
		<div class="collection-left">
			<h2 class="collection-title">2025 SS COLLECTION</h2>

			<!-- Swiper 슬라이드 시작 -->
			<div class="swiper">
				<div class="swiper-wrapper">
					<div class="swiper-slide">
						<img src="images/main-cloth2.png" alt="WL VARSITY JACKET">
					</div>
					<div class="swiper-slide">
						<img src="images/main-cloth3.png" alt="WL VARSITY JACKET 2">
					</div>
					<div class="swiper-slide">
						<img src="images/main-cloth1.png" alt="WL VARSITY JACKET 3">
					</div>
					<div class="swiper-slide">
						<img src="images/main-cloth4.png" alt="WL VARSITY JACKET">
					</div>
					<div class="swiper-slide">
						<img src="images/main-cloth5.png" alt="WL VARSITY JACKET">
					</div>
				</div>

				<!-- 화살표 버튼 -->
				<div class="swiper-button-next"></div>
				<div class="swiper-button-prev"></div>
			</div>
			<!-- Swiper 슬라이드 끝 -->
		</div>

		<div class="collection-right">
			<video class="collection-video" controls autoplay muted loop>
				<source src="videos/mainvideo-white.mp4" type="video/mp4">
				브라우저가 비디오 태그를 지원하지 않습니다.
			</video>
		</div>
	</section>

	<!-- Swiper 스크립트 -->
	<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
	<script>
		const swiper = new Swiper('.swiper', {
			speed: 650,
			navigation : {
				nextEl : '.swiper-button-next',
				prevEl : '.swiper-button-prev',
			},
			autoplay : {
				delay : 3000,
				disableOnInteraction : false,
			},
			grabCursor : true,
			loop : true,
			slidesPerView : 1, // 한 번에 1장만 보이게
			centeredSlides : false, // 가운데 정렬 X (필요 시 true로도 가능)
			spaceBetween : 0,
		});
	</script>

	<div class="slider-container">

		<!-- 왼쪽 화살표 -->
		<button class="arrow left">&#10094;</button>

		<div class="slider">
			<div class="slide">
				<img src="images/대머리2.jpg" alt="Image 1">
				<div class="caption">
					<p>
						2025 SS<br>STORY BEHIND<br>THE IMAGES (NOW BASED IN
						BUENOS AIRES)
					</p>
				</div>
			</div>
			<div class="slide">
				<img src="images/대머리.png" alt="Image 2">
				<div class="caption">
					<p>
						2025 SS<br>ALMOND SEA US
					</p>
				</div>
			</div>
		</div>

		<!-- 오른쪽 화살표 -->
		<button class="arrow right">&#10095;</button>
	</div>

	<!-- 메인 하단 이미지 영역 -->
	<div class="bottom-image-section">
		<img src="images/logo-black.png" alt="로고 이미지" class="background-logo">
		<img src="images/main-model.png" alt="모델 이미지" class="main-model">
	</div>

	<%@ include file="includes/footer.jsp"%>

</body>
</html>