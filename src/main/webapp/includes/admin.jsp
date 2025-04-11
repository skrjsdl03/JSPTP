<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- CSS 스타일시트 링크 -->
<head>
  <meta charset="UTF-8">
  <link rel="icon" type="image/png" href="images/fav-icon.png">
  <link rel="stylesheet" href="css/admin_member.css">
  <link rel="stylesheet" href="css/admin_order_list.css">
</head>
<body>
<div class="header-container">
  <!-- 로그아웃 버튼 -->
  <div class="admin-logout" style="text-align: right; margin-bottom: 10px;">
    <a href="logout.jsp" style="color: #2c3e50; font-weight: bold; text-decoration: none;">LOGOUT</a>
  </div>

  <nav class="admin-nav">
    <ul class="main-menu">
      <li><a href="#">대시보드</a></li>
      <li><a href="#">주문</a></li>
      <li><a href="#">상품</a></li>
      <li><a href="#">회원</a></li>
      <li><a href="#">게시판</a></li>
    </ul>

    <div class="megamenu">
      <div class="menu-column"></div>
      <div class="menu-column">
        <a href="#">주문 내역 조회</a>
        <a href="#">주문 취소/환불</a>
        <a href="#">배송 상태 변경</a>
      </div>
      <div class="menu-column">
        <a href="#">상품 관리</a>
        <a href="#">상품 등록</a>
      </div>
      <div class="menu-column">
        <a href="admin_member.jsp">회원 목록 조회</a>
        <a href="admin_member_manage.jsp">회원 관리</a>
      </div>
      <div class="menu-column">
        <a href="#">공지사항</a>
        <a href="#">리뷰</a>
        <a href="#">Q&A</a>
      </div>
    </div>
  </nav>
</div>
</body>

