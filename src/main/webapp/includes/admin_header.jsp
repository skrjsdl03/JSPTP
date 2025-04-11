<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String currentMenu = (String)request.getAttribute("currentMenu");
	String subMenu = (String)request.getAttribute("subMenu");
	if(currentMenu == null) currentMenu = "";
	if(subMenu == null) subMenu = "";
%>
<!-- 공통 스타일 포함 -->
<!-- ↓↓↓↓↓이게 css임↓↓↓↓↓ -->
<jsp:include page="/includes/admin_styles.jsp" />

<!-- admin_header.jsp: 관리자 공통 헤더 -->
<header>
	<div class="header-container">
		<div class="logo-container">
			<a href="admin_main.jsp">
				<img src="images/logo-white.png" alt="everyWEAR 로고" class="header-logo">
			</a>
		</div>
		<nav class="admin-nav">
			<ul class="main-menu">
				<li><a href="admin_main.jsp" <%= "main".equals(currentMenu) ? "class=\"active\"" : "" %>>대시보드</a></li>
				<li><a href="#" <%= "order".equals(currentMenu) ? "class=\"active\"" : "" %>>주문</a></li>
				<li><a href="#" <%= "product".equals(currentMenu) ? "class=\"active\"" : "" %>>상품</a></li>
				<li><a href="#" <%= "member".equals(currentMenu) ? "class=\"active\"" : "" %>>회원</a></li>
				<li><a href="#" <%= "board".equals(currentMenu) ? "class=\"active\"" : "" %>>게시판</a></li>
			</ul>
			<div class="megamenu">
				<div class="menu-column"></div>
				<div class="menu-column">
					<a href="admin_order_list.jsp" <%= "order_list".equals(subMenu) ? "class=\"active\"" : "" %>>주문 내역 조회</a>
					<a href="admin_order_refund.jsp" <%= "order_cancel".equals(subMenu) ? "class=\"active\"" : "" %>>주문 취소/환불</a>
					<a href="admin_order_delivery.jsp" <%= "order_list".equals(subMenu) ? "class=\"active\"" : "" %>>배송 상태 변경</a>
				</div>
				<div class="menu-column">
					<a href="#" <%= "product_list".equals(subMenu) ? "class=\"active\"" : "" %>>상품 관리</a>
					<a href="#" <%= "product_add".equals(subMenu) ? "class=\"active\"" : "" %>>상품 등록</a>
				</div>
				<div class="menu-column">
					<a href="admin_member.jsp" <%= "member_list".equals(subMenu) ? "class=\"active\"" : "" %>>회원 목록 조회</a>
					<a href="admin_wdmember_manage.jsp" <%= "member_manage".equals(subMenu) ? "class=\"active\"" : "" %>>탈퇴회원 관리</a>
				</div>
				<div class="menu-column">
					<a href="admin_notice.jsp" <%= "notice".equals(subMenu) ? "class=\"active\"" : "" %>>공지사항</a>
					<a href="#" <%= "review".equals(subMenu) ? "class=\"active\"" : "" %>>리뷰</a>
					<a href="#" <%= "qna".equals(subMenu) ? "class=\"active\"" : "" %>>Q&A</a>
				</div>
			</div>
		</nav>
		<div class="logout-container">
			<a href="admin_login.jsp" class="logout-btn">로그아웃</a>
		</div>
	</div>
</header>


