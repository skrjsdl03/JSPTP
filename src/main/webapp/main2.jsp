<!-- main2.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>에브리웨어 | everyWEAR</title>
<link rel="stylesheet" type="text/css" href="css/main2.css?v=389">
<link rel="icon" type="image/png" href="images/fav-icon.png">
<link rel="stylesheet"
	href="https://unpkg.com/swiper/swiper-bundle.min.css" />
</head>
<body>

	<%@ include file="includes/header.jsp"%>
	
	<%
	String category = request.getParameter("category");
	if (category == null) category = "all"; // 기본값
	%>

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
			<video class="collection-video" autoplay muted loop playsinline>
				<source src="videos/mainvideo-white.mp4" type="video/mp4">
				브라우저가 비디오 태그를 지원하지 않습니다.
			</video>
		</div>
	</section>

	<!-- Swiper 스크립트 -->
	<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
	<script>
		document.addEventListener('DOMContentLoaded', function() {
			const swiper = new Swiper('.swiper', {
				speed : 650,
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
			})
		});
	</script>

	<!-- 메인 중앙 이미지 슬라이더 영역 -->
	<div class="slider-container">
		<button class="slider-btn prev">&#10094;</button>
		<div class="slider-wrapper">
			<div class="slider-track">
				<div class="slide">
					<img src="images/bald2.jpg" alt="look1">
					<div class="slide-text">
						<strong>2025 SS</strong><br> <strong>STORY BEHIND</strong><br>
						THE IMAGES(NOW BASED IN BUENOS AIRES)
					</div>
				</div>
				<div class="slide">
					<img src="images/bald.png" alt="look2">
					<div class="slide-text">
						<strong>2025 SS</strong><br> <strong>STORY BEHIND</strong><br>
						THE IMAGES(NOW BASED IN BUENOS AIRES)
					</div>
				</div>
				<div class="slide">
					<img src="images/mainac1.jpg" alt="look1">
					<div class="slide-text">
						<strong>2025 SS</strong><br> <strong>STORY BEHIND</strong><br>
						THE IMAGES(NOW BASED IN BUENOS AIRES)
					</div>
				</div>
				<div class="slide">
					<img src="images/mainac2.jpg" alt="look1">
					<div class="slide-text">
						<strong>2025 SS</strong><br> <strong>STORY BEHIND</strong><br>
						THE IMAGES(NOW BASED IN BUENOS AIRES)
					</div>
				</div>
				<div class="slide">
					<img src="images/mainac3.jpg" alt="look1">
					<div class="slide-text">
						<strong>2025 SS</strong><br> <strong>STORY BEHIND</strong><br>
						THE IMAGES(NOW BASED IN BUENOS AIRES)
					</div>
				</div>
				<div class="slide">
					<img src="images/mainac4.jpg" alt="look2">
					<div class="slide-text">
						<strong>2025 SS</strong><br> <strong>STORY BEHIND</strong><br>
						THE IMAGES(NOW BASED IN BUENOS AIRES)
					</div>
				</div>
				<div class="slide">
					<img src="images/mainac5.jpg" alt="look2">
					<div class="slide-text">
						<strong>2025 SS</strong><br> <strong>STORY BEHIND</strong><br>
						THE IMAGES(NOW BASED IN BUENOS AIRES)
					</div>
				</div>
				<div class="slide">
					<img src="images/mainac6.jpg" alt="look2">
					<div class="slide-text">
						<strong>2025 SS</strong><br> <strong>STORY BEHIND</strong><br>
						THE IMAGES(NOW BASED IN BUENOS AIRES)
					</div>
				</div>
			</div>
		</div>
		<button class="slider-btn next">&#10095;</button>
	</div>

	<script>
  const track = document.querySelector('.slider-track');
  const slides = document.querySelectorAll('.slide');
  const prevBtn = document.querySelector('.prev');
  const nextBtn = document.querySelector('.next');
  
  let index = 0;

  function getOffset() {
    let offset = 0;
    for (let i = 0; i < index; i++) {
      offset += slides[i].offsetWidth + 40; // margin-right 고려
    }
    return offset;
  }

  function updateSlider() {
	  const maxOffset = track.scrollWidth - track.clientWidth;
	  const offset = getOffset();
	  track.style.transform = `translateX(-\${Math.min(offset, maxOffset)}px)`;
  }

  prevBtn.addEventListener('click', () => {
	  index = (index - 1 + slides.length) % slides.length;
    updateSlider();
  });

  nextBtn.addEventListener('click', () => {
	  index = (index + 1) % slides.length;
    updateSlider();
  });

  // 자동 슬라이드 (3초 간격)
  setInterval(() => {
    index = (index + 1) % slides.length;
    updateSlider();
  }, 3500);
  
	</script>

	<!-- 메인 하단 이미지 영역 -->
	<div class="bottom-image-section">
		<img src="images/logo-black.png" alt="로고 이미지" class="background-logo">
		<img src="images/main-model.png" alt="모델 이미지" class="main-model">
	</div>

	<%@ include file="includes/footer.jsp"%>

	<button id="topBtn">TOP</button>

	<script>
  	document.getElementById("topBtn").addEventListener("click", function () {
    	window.scrollTo({ top: 0, behavior: 'smooth' });
  	});
	</script>

</body>
</html>