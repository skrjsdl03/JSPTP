<!-- header.jsp -->
<%
		String id = (String)session.getAttribute("id");
%>

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
		  document.getElementById("overlay").classList.remove("active");
		}
		</script>
		
	</div>
	<%if(id==null){ %>
	<div class="nav-right">
		<a href="login.jsp">LOGIN</a> <a href="#">CART</a>
	</div>
	<%}else{ %>
	<div class="nav-right">
		<a href="logout.jsp">LOGOUT</a> <a href="#">CART</a>
	</div>
	<%} %>
	
	<!-- 사이드바 메뉴 -->
	<div id="sidebar" class="sidebar">
	
  <a href="#">NEW</a>
  <a href="#">BEST</a>
  
  <a href="#" class="group-gap">ALL</a>
  <a href="#">OUTER</a>
  <a href="#">TOP</a>
  <a href="#">BOTTOM</a>
  <a href="#">ACC</a>
  <a href="#">SALE</a>
  
  <a href="#" class="group-gap">MY PAGE</a>
  <a href="#">BOARD</a>
	</div>
	
	<div id="overlay" class="overlay" onclick="closeSidebar()"></div>
	
</header>

<!-- 로고 -->
<div class="logo-wrap">
	<a href="main.jsp"> <img src="images/logo-black.png"
		alt="everyWEAR" class="logo-img">
	</a>
</div>

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