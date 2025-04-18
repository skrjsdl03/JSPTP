<%@page import="java.text.DecimalFormat"%>
<%@page import="DTO.ProductDTO"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<jsp:useBean id="pDao" class="DAO.ProductDAO"/>
<jsp:useBean id="uDao" class="DAO.UserDAO"/>
<jsp:useBean id="fDao", class="DAO.FavoriteDAO"/>
<%
		String userId = (String)session.getAttribute("id");
		String userType = (String)session.getAttribute("userType");
	
		// 단일 값 파라미터 받기
		String zipcode = request.getParameter("zipcode");
		String address1 = request.getParameter("address1");
		String address2 = request.getParameter("address2");
		String o_name = request.getParameter("o_name");
		String o_phone = request.getParameter("o_phone");
		String o_email = request.getParameter("o_email");
		String priceStr = request.getParameter("price");
		String o_num = request.getParameter("o_num");
		String mileageStr = request.getParameter("mileage");
		String pdPrice = request.getParameter("pdPrice");
		String deliFee = request.getParameter("deliFee");
		String dc = request.getParameter("dc");
		
		int mileage = Integer.parseInt(mileageStr.replaceAll("[^0-9]", ""));
		int discount = Integer.parseInt(dc.replaceAll("[^0-9]", ""));
		if(userId != null && !userId.equals("")){
			uDao.updatePointForOrder(mileage, userId, userType);
			if(discount != 0){
				uDao.updatePointWhenOrder(discount, userId, userType);
			}
		}
		String[] fIds = request.getParameterValues("f_id");
		if(fIds.length != 0){
			for(int i = 0; i<fIds.length; i++){
				fDao.deleteCartAfterOrder(Integer.parseInt(fIds[i]));
			}
		}
				
		// 숫자 변환
		int price = priceStr != null ? Integer.parseInt(priceStr) : 0;
 		/* int mileage = mileageStr != null ? Integer.parseInt(mileageStr) : 0;  */
		
		// 배열 파라미터 받기
		String[] pd_ids = request.getParameterValues("pd_id");
		String[] quantities = request.getParameterValues("quantity");
		
		DecimalFormat formatter = new DecimalFormat("#,###");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>결제 완료 | everyWEAR</title>
  <link rel="stylesheet" href="css/payComplete.css">
</head>
<body>

<%@ include file="includes/header.jsp"%>

<section class="content2">
  <h3 class="order-complete-message">결제 완료</h3>
</section>

<div class="order-container">

  <!-- 주문상품 -->
  <section class="product-section">
    <p class="section-title">주문상품</p>
  <%for(int i = 0; i<pd_ids.length; i++){ 
	  String size = pDao.getOnePdSizeForCart(Integer.parseInt(pd_ids[i]));
		Vector<String> img = pDao.getOnePdImgForCart(Integer.parseInt(pd_ids[i]));
		ProductDTO pd = pDao.getOnePdForCart(Integer.parseInt(pd_ids[i]));
  %>
    <div class="product-box">
      <img src="<%=img.get(i)%>" alt="상품 이미지" class="product-img">
      <div class="product-detail">
        <p class="product-name"><%=pd.getP_name()%></p>
        <p class="product-option">SIZE | <%=size%></p>
        <p class="product-qty">수량 : <strong><%=quantities[i]%></strong></p>
      </div>
      
      <div class="product-price-box">
        <div class="order-summary-box">
          <p class="order-number">주문번호 : <%=o_num%></p>
          <p class="final-price"><strong><%=formatter.format(Integer.parseInt(quantities[i]) * pd.getP_price())%> 원</strong></p>
        </div>
      </div>
    </div>
  <%} %>
  </section>

  <!-- 접히는 정보 영역 -->
  <div class="dropdown-section">배송지</div>
  <div class="dropdown-content">
    <div class="info-row"><span class="label"> </span><span class="value"><%=zipcode%> / <%=address1%> <%=address2 != null && !address2.isEmpty() ? "/ " + address2 : ""%></span></div>
  </div>

  <div class="dropdown-section">주문자 정보</div>
  <div class="dropdown-content">
    <div class="info-row"><span class="label">이름</span><span class="value"><%=o_name%></span></div>
    <div class="info-row"><span class="label">주소</span><span class="value"><%=zipcode%> / <%=address1%> <%=address2 != null && !address2.isEmpty() ? "/ " + address2 : ""%></span></div>
    <div class="info-row"><span class="label">휴대전화</span><span class="value"><%=o_phone%></span></div>
   <%if(o_email != null && !o_email.equals("")){ %>
    <div class="info-row"><span class="label">이메일</span><span class="value"><%=o_email%></span></div>
   <%} %>
  </div>

  <div class="dropdown-section">결제 정보</div>
  <div class="dropdown-content">
    <div class="info-row"><span class="label">상품 금액</span><span class="value"><%=pdPrice%></span></div>
    <div class="info-row"><span class="label">배송비</span><span class="value"><%=deliFee%></span></div>
    <%if(userId != null && !userId.equals("")){ %>
    <div class="info-row"><span class="label">할인/부가결제</span><span class="value"><%=dc%></span></div>
    <%} %>
    <div class="info-row"><span class="label">총 결제 금액</span><span class="value"><%=formatter.format(price)%> 원</span></div>
  </div>

<%if(userId != null && !userId.equals("")){ %>
  <div class="dropdown-section">적립</div>
  <div class="dropdown-content">
<!--     <div class="info-row"><span class="label">회원 적립금</span><span class="value">3,990 원</span></div> -->
    <div class="info-row"><span class="label">상품 적립금</span><span class="value"><%=mileageStr%></span></div>
  </div>
    <%} %>

  <!-- main으로 돌아가기 -->
  <div class="back-to-home">
    <button onclick="location.href='main2.jsp'">홈으로 돌아가기</button>
  </div>
</div>

<footer class="footer">2025©everyWEAR</footer>

<script>
  // 드롭다운 기능
  document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll(".dropdown-section").forEach(function (section) {
      section.addEventListener("click", function () {
        section.classList.toggle("active");
      });
    });
  });
</script>

</body>
</html>
