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
			<li><a href="#">ALL</a></li>
			<li><a href="#">OUTER</a></li>
			<li><a href="#">TOP</a></li>
			<li><a href="#">BOTTOM</a></li>
			<li><a href="#">ACC</a></li>
		</ul>
	</nav>

	<!-- 상품 목록 영역 -->
	<section class="product-list">
		<c:forEach var="product" items="${productList}">
			<div class="product-card">
				<img src="${product.imagePath}" alt="${product.name}">
				<p class="product-name">${product.name}</p>
				<p class="product-price">KRW ${product.price}</p>
			</div>
		</c:forEach>
	</section>

	<!-- 더 보기 버튼 -->
	<div class="load-more-wrap">
		<button class="load-more">VIEW MORE</button>
	</div>

</body>
</html>