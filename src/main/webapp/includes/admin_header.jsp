<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- CSS 스타일시트 링크 -->
<style>
@charset "UTF-8";
/* ===== 헤더 및 네비게이션 ===== */
header {
	background-color: #2c3e50;
	color: white;
	padding: 10px 0;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.header-container {
	max-width: 1200px;
	margin: 0 auto;
	padding: 0 20px;
}

.admin-logout {
	text-align: right;
	padding: 10px 20px 0 0;
}

.admin-logout a {
	color: white;
	font-weight: bold;
	text-decoration: none;
}

.admin-logout a:hover {
	text-decoration: underline;
}

/* 관리자 상단 메뉴 영역 */
.admin-nav {
	position: relative;
}

/* 상위 메뉴 */
.main-menu {
	display: grid;
	grid-template-columns: repeat(6, 1fr);
	list-style: none;
	margin: 0;
	padding: 0;
	background-color: #2c3e50;
}

.main-menu>li>a {
	display: block;
	padding: 15px 0;
	text-align: center;
	color: white;
	font-weight: bold;
	text-decoration: none;
	transition: background-color 0.3s;
}

.main-menu>li>a:hover {
	background-color: #1abc9c;
}

/* 하위 메뉴 */
.megamenu {
	display: none;
	position: absolute;
	top: 100%;
	left: 0;
	width: 100%;
	background-color: rgba(255, 255, 255, 0.7);
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
	z-index: 1000;
	display: none;
	grid-template-columns: repeat(6, 1fr);
	gap: 0;
	padding: 20px 0;
}

.admin-nav:hover .megamenu {
	display: grid;
}

.menu-column {
	text-align: center;
}

.menu-column h4 {
	font-size: 16px;
	margin-bottom: 10px;
	color: #2c3e50;
	border-bottom: 1px solid #ccc;
	padding-bottom: 5px;
}

.menu-column a {
	display: block;
	margin-bottom: 6px;
	font-size: 14px;
	color: #333;
	text-decoration: none;
	transition: color 0.2s;
}

.menu-column a:hover {
	color: #1abc9c;
	text-decoration: underline;
}
</style>
<!-- admin_header.jsp: 관리자 공통 헤더 -->
<header>
	<div class="header-container">
		<nav class="admin-nav">
			<ul class="main-menu">
				<li><a href="admin_main.jsp">대시보드</a></li>
				<li><a href="#">주문</a></li>
				<li><a href="#">상품</a></li>
				<li><a href="#">회원</a></li>
				<li><a href="#">게시판</a></li>
				<li><a href="#">통계</a></li>
			</ul>
			<div class="megamenu">
				<div class="menu-column"></div>
				<div class="menu-column">
					<a href="#">주문 내역 조회</a> <a href="#">주문 취소/환불</a>
				</div>
				<div class="menu-column">
					<a href="#">상품 관리</a> <a href="#">상품 등록</a>
				</div>
				<div class="menu-column">
					<a href="admin_member.jsp">회원 목록 조회</a> <a
						href="admin_wdmember_manage.jsp">회원 관리</a>
				</div>
				<div class="menu-column">
					<a href="#">공지사항</a> <a href="#">리뷰</a> <a href="#">Q&A</a>
				</div>
				<div class="menu-column">
					<a href="#">매출 분석</a> <a href="#">상품 분석</a>
				</div>
			</div>
		</nav>
	</div>
</header>


