<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>주문 내역 조회 | everyWEAR</title>
  <link rel="icon" type="image/png" href="images/fav-icon.png">
  <link rel="stylesheet" href="css/admin_header.css">
  <link rel="stylesheet" href="css/admin_member.css">
  <link rel="stylesheet" href="css/admin_order_list.css">
</head>
<body>
<header>
  <div class="header-container">
    <nav class="admin-nav">
      <ul class="main-menu">
        <li><a href="#">대시보드</a></li>
        <li><a href="#">주문</a></li>
        <li><a href="#">상품</a></li>
        <li><a href="#">회원</a></li>
        <li><a href="#">게시판</a></li>
        <li><a href="#">통계</a></li>
      </ul>
      <div class="megamenu">
        <div class="menu-column"></div>
        <div class="menu-column">
          <a href="#">주문 내역 조회</a>
          <a href="#">주문 취소/환불</a>
        </div>
        <div class="menu-column">
          <a href="#">상품 관리</a>
          <a href="#">상품 등록</a>
        </div>
        <div class="menu-column">
          <a href="#">회원 목록 조회</a>
          <a href="#">회원 관리</a>
        </div>
        <div class="menu-column">
          <a href="#">공지사항</a>
          <a href="#">리뷰</a>
          <a href="#">Q&A</a>
        </div>
        <div class="menu-column">
          <a href="#">매출 분석</a>
          <a href="#">상품 분석</a>
        </div>
      </div>
    </nav>
  </div>
</header>

<main>
  <div class="container">
    <div class="order-header">
      <h2>주문 내역 조회</h2>
      <select class="custom-select">
        <option>전체</option>
      </select>
    </div>

    <table class="order-table">
      <thead>
        <tr>
          <th><input type="checkbox"></th>
          <th>No.</th>
          <th>배송지명</th>
          <th>송장번호</th>
          <th>택배사명</th>
          <th>배송상태</th>
          <th>배송시작일</th>
          <th>배송완료일</th>
          <th>메모내용</th>
        </tr>
      </thead>
      <tbody>
        <%-- 반복 예시 --%>
        <c:forEach var="i" begin="1" end="9">
          <tr>
            <td><input type="checkbox"></td>
            <td>${i}</td>
            <td>동의대 중앙도서관</td>
            <td>89884086567</td>
            <td>CJ대한통운</td>
            <td>
              <select class="custom-select">
                <option>배송중</option>
                <option>배송완료</option>
              </select>
            </td>
            <td>2025-04-20</td>
            <td>2025-04-21</td>
            <td><a href="#">메모 내용</a></td>
          </tr>
        </c:forEach>
      </tbody>
    </table>

    <div class="order-footer">
      <button class="save-button">저장</button>
    </div>
  </div>
</main>
</body>
</html>
