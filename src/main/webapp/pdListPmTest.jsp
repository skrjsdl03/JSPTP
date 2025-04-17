<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%
// 카테고리 파라미터 처리
String category = request.getParameter("category");
if (category == null) {
	category = "all";
}

// 임시 상품 데이터
class Product {
	String id;
	String name;
	int price;
	String image;
	String category;

	Product(String id, String name, int price, String image, String category) {
		this.id = id;
		this.name = name;
		this.price = price;
		this.image = image;
		this.category = category;
	}
}

List<Product> allProducts = new ArrayList<>();
allProducts.add(new Product("101", "후리스 자켓", 59000, "images/main-cloth1.png", "outer"));
allProducts.add(new Product("102", "셔츠 블라우스", 49000, "images/main-cloth2.png", "top"));
allProducts.add(new Product("103", "데님 팬츠", 69000, "images/main-cloth3.png", "bottom"));
allProducts.add(new Product("104", "롱코트", 129000, "images/main-cloth4.png", "acc"));
allProducts.add(new Product("105", "기본 티셔츠", 19000, "images/main-cloth5.png", "outer"));
allProducts.add(new Product("106", "후리스 자켓", 59000, "images/main-cloth1.png", "outer"));
allProducts.add(new Product("107", "셔츠 블라우스", 49000, "images/main-cloth2.png", "top"));
allProducts.add(new Product("108", "데님 팬츠", 69000, "images/main-cloth3.png", "bottom"));
allProducts.add(new Product("109", "롱코트", 129000, "images/main-cloth4.png", "acc"));
allProducts.add(new Product("110", "기본 티셔츠", 19000, "images/main-cloth5.png", "outer"));
allProducts.add(new Product("111", "후리스 자켓", 59000, "images/main-cloth1.png", "outer"));
allProducts.add(new Product("112", "셔츠 블라우스", 49000, "images/main-cloth2.png", "top"));
allProducts.add(new Product("113", "데님 팬츠", 69000, "images/main-cloth3.png", "bottom"));
allProducts.add(new Product("114", "롱코트", 129000, "images/main-cloth4.png", "acc"));
allProducts.add(new Product("115", "기본 티셔츠", 19000, "images/main-cloth5.png", "outer"));

// 필터링
List<Product> filteredProducts = new ArrayList<>();
for (Product p : allProducts) {
	if (category.equals("all") || p.category.equals(category)) {
		filteredProducts.add(p);
	}
}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>에브리웨어 | everyWEAR</title>
<link rel="stylesheet" type="text/css" href="css/pdListPmTest.css">
<link rel="icon" type="image/png" href="images/fav-icon.png">
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

	<!-- 상품 리스트 출력 -->
	<div class="product-list">
		<%
		for (Product p : filteredProducts) {
		%>
		<div class="product-card" onclick="openDetail()">
			<img src="<%=p.image%>" alt="<%=p.name%>">
			<p><%=p.name%></p>
			<p>
				KRW
				<%=p.price%></p>
		</div>
		<%
		}
		%>
	</div>

	<script>
  	window.addEventListener("DOMContentLoaded", () => {
    	const params = new URLSearchParams(window.location.search);
    	const currentCate = params.get("cate") || "ALL"; // 기본값 ALL

    	// 모든 a 태그 탐색
    	document.querySelectorAll(".sub-nav ul li a").forEach(link => {
      	const url = new URL(link.href);
      	const linkCate = new URLSearchParams(url.search).get("cate");

      	if (linkCate === currentCate) {
        	link.classList.add("active");
      	} else {
        	link.classList.remove("active");
      	}
    	});
  	});
	</script>

</body>
</html>