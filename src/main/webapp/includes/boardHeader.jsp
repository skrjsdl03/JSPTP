<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>에브리웨어 | everyWEAR</title>
<link rel="stylesheet" type="text/css" href="css/boardHeader.css?v=123">
<link rel="icon" type="image/png" href="images/fav-icon.png">
</head>
<body>

	<!-- 상위 네비 -->
	<header class="top-nav">
		<div class="nav-left">
			<button class="menu-btn" onclick="toggleSidebar()">&#9776;</button>
			<script>
				function toggleSidebar() {
					const sidebar = document.getElementById("sidebar");
					const overlay = document.getElementById("overlay");
					sidebar.classList.toggle("open");
					overlay.classList.toggle("active");
				}

				function closeSidebar() {
					document.getElementById("sidebar").classList.remove("open");
					document.getElementById("overlay").classList
							.remove("active");
				}
			</script>

		</div>
		<div class="nav-right">
			<a href="#">LOGIN</a> <a href="#">CART</a>
		</div>

		<!-- 사이드바 메뉴 -->
		<div id="sidebar" class="sidebar">

			<a href="#">NEW</a> <a href="#">BEST</a> <a href="#"
				class="group-gap">ALL</a> <a href="#">OUTER</a> <a href="#">TOP</a>
			<a href="#">BOTTOM</a> <a href="#">ACC</a> <a href="#">SALE</a> <a
				href="#" class="group-gap">MY PAGE</a> <a href="#">BOARD</a>
		</div>

		<div id="overlay" class="overlay" onclick="closeSidebar()"></div>

	</header>

	<!-- 로고 -->
	<div class="logo-wrap">
		<a href="main.jsp"> <img src="images/logo-black.png"
			alt="everyWEAR" class="logo-img">
		</a>
	</div>

</body>