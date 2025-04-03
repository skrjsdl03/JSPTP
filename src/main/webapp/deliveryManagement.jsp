<!-- deliveryManagement.jsp -->

<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>배송지 관리 | everyWEAR</title>
  <link rel="stylesheet" type="text/css" href="css/delivery.css">
  <link rel="stylesheet" type="text/css" href="css/header.css">
  <link rel="icon" type="image/png" href="images/logo-white.png">
</head>
<body>

<%@ include file="includes/mypageHeader.jsp" %>

  <div class="delivery-container">
    <div class="sidebar">
  <div class="user-box">
    <p class="username">정새영 님</p>
    <div class="user-info">
      <div class="label">적립금</div><div class="value">25,000 ￦</div>
      <div class="label">쿠폰</div><div class="value">2 개</div>
    </div>
  </div>

  <ul class="side-menu">
    <li>회원 정보 수정</li>
    <li>주문 내역</li>
    <li>장바구니</li>
    <li>찜 상품</li>
    <li>게시글 관리</li>
    <li class="active">배송지 관리</li>
  </ul>
</div>


<div class="delivery-title-wrap">
  <h2 class="delivery-title">배송지 관리</h2>
</div>

		<div class="delivery-box">
		  <div class="delivery-top">
		    <label><input type="radio" name="selected" checked> 기본 배송지</label>
		  </div>
		
		  <div class="delivery-inputs">
		    <input type="text" class="input-tag" placeholder="회사">
		    <input type="text" class="input-zipcode" placeholder="47340">
		    <button class="btn-search">주소 검색</button>
		  </div>
		
		  <div class="delivery-inputs">
		    <input type="text" class="input-full" placeholder="부산광역시 부산진구 엄광로 176">
		    <input type="text" class="input-full" placeholder="동의대학교 중앙도서관">
		    <a href="#" class="btn-edit">수정</a>
		  </div>
		</div>

    </div>
  </div>

  <footer>2025©everyWEAR</footer>

</body>
</html>
