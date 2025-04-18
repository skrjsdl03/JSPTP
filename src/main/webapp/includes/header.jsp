<!-- header.jsp -->
<%
String id = (String) session.getAttribute("id");

// 현재 페이지 경로를 얻기 위한 코드
String fullUrl = request.getRequestURI();
String queryString = request.getQueryString();
if (queryString != null) {
	fullUrl += "?" + queryString;
}
%>
<head>
<link rel="stylesheet" type="text/css" href="css/header.css">
</head>
<!-- 상위 네비 -->
<body>
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
		
		<%
		if (id == null) {
		%>
		<div class="nav-right">
			<a href="login.jsp?redirect=<%= java.net.URLEncoder.encode(fullUrl, "UTF-8") %>">LOGIN</a> <a href="cart2.jsp">CART</a>
		</div>
		<% 
		} else {
		%>
		<div class="nav-right">
			<a href="logout.jsp?redirect=<%= java.net.URLEncoder.encode(fullUrl, "UTF-8") %>">LOGOUT</a> <a href="cart2.jsp">CART</a>
		</div>
		<%
		}
		%>

		<!-- 사이드바 메뉴 -->
		<div id="sidebar" class="sidebar">
			<a href="splitTest3.jsp">NEW</a>
			<a href="splitTest4.jsp">BEST</a>
			<a href="splitTest2.jsp?cat=all" class="group-gap">ALL</a>
			<a href="splitTest2.jsp?cat=outer">OUTER</a>
			<a href="splitTest2.jsp?cat=top">TOP</a>
			<a href="splitTest2.jsp?cat=bottom">BOTTOM</a>
			<a href="splitTest2.jsp?cat=acc">ACC</a>
			<a href="#">SALE</a>
			<a href="myPage.jsp" class="group-gap">MY PAGE</a>
			<a href="board.jsp">BOARD</a>
		</div>

		<div id="overlay" class="overlay" onclick="closeSidebar()"></div>

	</header>

	<!-- 로고 -->
	<div class="logo-wrap">
		<a href="main2.jsp">
		<img src="images/logo-black.png" alt="everyWEAR" class="logo-img">
		</a>
	</div>

</body>
