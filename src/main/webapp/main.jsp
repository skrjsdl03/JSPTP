<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>에브리웨어 | everyWEAR</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="icon" type="image/png" href="images/logo-white.png">
</head>
<body>

	<%@ include file="includes/header.jsp"%>

	<!-- 여기부터 메인 컨텐츠 시작 -->
	<section class="main-collection">
		<div class="collection-left">
			<h2 class="collection-title">2025 SS COLLECTION</h2>
			<img src="images/main-cloth1.png" alt="WL VARSITY JACKET"
				class="collection-img">
		</div>
		<div class="collection-right">
			<video class="collection-video" controls autoplay muted loop>
				<source src="videos/mainvideo-white.mp4" type="video/mp4">
				브라우저가 비디오 태그를 지원하지 않습니다.
			</video>
		</div>
	</section>
	<div class="slider-container">
    <button class="arrow left-arrow">&#10094;</button>

    <div class="slider-track" id="sliderTrack">
        <img src="images/jacket1.png" class="slide">
        <img src="images/jacket2.png" class="slide">
        <img src="images/jacket3.png" class="slide">
        <!-- 이미지 더 추가 가능 -->
    </div>

    <button class="arrow right-arrow">&#10095;</button>
</div>
	
</body>
</html>
