<%@page import="DTO.ProductDTO"%>
<%@page import="DTO.FavoriteDTO"%>
<%@page import="java.util.Vector"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="DTO.UserDTO"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<jsp:useBean id="uDao" class="DAO.UserDAO"/>
<jsp:useBean id="pDao" class="DAO.ProductDAO"/>
<jsp:useBean id="fDao" class="DAO.FavoriteDAO"/>
<%
String userId = (String) session.getAttribute("id");
String userType = (String) session.getAttribute("userType");
if(userId == null || userId == ""){
	// 현재 페이지 경로를 얻기 위한 코드
	String fullUrl = request.getRequestURI();
	String queryString = request.getQueryString();
	if (queryString != null) {
		fullUrl += "?" + queryString;
	}
	response.sendRedirect("login.jsp?redirect=" + java.net.URLEncoder.encode(fullUrl, "UTF-8"));
	return;
}
UserDTO user = uDao.getOneUser(userId, userType);
int couponCnt = uDao.showOneUserCoupon(userId, userType);
DecimalFormat formatter = new DecimalFormat("#,###");

String point = formatter.format(user.getUser_point());

Vector<FavoriteDTO> flist = fDao.getUserCart(userId, userType);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>에브리웨어 | everyWEAR</title>
<link rel="icon" type="image/png" href="images/fav-icon.png">
<link rel="stylesheet" type="text/css" href="css/cart.css">
</head>
<body>

	<%@ include file="includes/header.jsp"%>

	<section2 class="content2">
	<h3>장바구니</h3>
	</section2>

	<div class="container">
		<div class="user-box">
			<p class="username"><%=user.getUser_name()%> 님</p>
			<div class="user-info">
				<div class="label">적립금</div>
				<div class="value"><%=point%> ￦</div>
				<div class="label"><a href="coupon.jsp">쿠폰</a></div>
				<div class="value"><%=couponCnt%> 개</div>
			</div>
		</div>

		<aside class="sidebar2">
		<br>
			<ul>
				<li><a href="myPage.jsp">회원 정보 수정</a></li>
				<li><a href="orderHistory2.jsp">주문 내역</a></li>
				<li><a href="cart2.jsp">장바구니</a></li>
				<li><a href="wishList2.jsp">찜 상품</a></li>
				<li><a href="postMn.jsp">게시물 관리</a></li>
				<li><a href="deliveryMn.jsp">배송지 관리</a></li>
			</ul>
		</aside>

		<section class="content">
			<!-- 장바구니 본문 -->
			<div class="order-content">
				<!-- 상단 선택/삭제 -->
				<div class="order-row"
					style="justify-content: space-between; border-bottom: 1px solid #ddd;">
					<label><input type="checkbox" id="select-all" checked>전체 선택</label>
					<div class="delete-box">
					  <span class="delete-text">선택 삭제</span>
					  <span class="delete-icon">&#10005;</span>
					</div>
				</div>

			<%
					ProductDTO pDto = new ProductDTO();
					if(!flist.isEmpty()){
						for(int i = 0; i<flist.size(); i++){ 
							FavoriteDTO fDto = flist.get(i);
							String size = pDao.getOnePdSizeForCart(fDto.getPd_id());
							pDto = pDao.getOnePdForCart(fDto.getPd_id());
							Vector<String> urllist = pDao.getOnePdImgForCart(fDto.getPd_id());
			%>
				<!-- 상품 1 -->
				<div class="order-row">
					<input type="checkbox"class="item-checkbox" checked> 
					<img src="<%=urllist.get(0)%>" alt="<%=pDto.getP_name()%>">
					<div class="order-info">
						<p class="item-name"><%=pDto.getP_name()%></p>
						<p class="item-option">SIZE  |  <%=size%><br>COLOR  |  <%=pDto.getP_color()%></p>
						<div class="qty-control">
							<button class="qty-btn" onclick="minusQty('<%=i%>', '<%=fDto.getF_id()%>', '<%=fDto.getPd_id()%>')">-</button>
							<span class="qty-value" id="quantity<%=i%>"><%=fDto.getF_quantity()%></span>
							<button class="qty-btn" onclick="plusQty('<%=i%>', '<%=fDto.getF_id()%>', '<%=fDto.getPd_id()%>')">+</button>
						</div>
					</div>
					<div class="order-meta">
						<p style="text-align: right;">
							<a href="#" style="color: #999; font-size: 13px; text-decoration: none;">삭제</a>
							<br> <a href="#" class="option-button">옵션 변경</a> <br>
							<strong style="font-size: 14px;" id="price<%=i%>"><%=formatter.format(pDto.getP_price() * fDto.getF_quantity())%> 원</strong>
						</p>
					</div>
				</div>
				<%
						}
					}else{
				%>
				장바구니가 없음.
				<%} %>

				<!-- 주문하기 버튼 -->
				<div
					style="width: 100%; display: flex; justify-content: center; margin-top: 40px;">
					<button
						style="background: black; color: white; border: none; padding: 12px 40px; font-size: 14px; border-radius: 6px; cursor: pointer;">주문하기</button>
				</div>
			</div>
		</section>
	</div>

<script>/* 체크박스 script */
  // 전체 선택 체크박스 클릭 시
  document.getElementById("select-all").addEventListener("change", function () {
    const isChecked = this.checked;
    document.querySelectorAll(".item-checkbox").forEach(cb => {
      cb.checked = isChecked;
    });
  });

  // 하위 체크박스 변경 시 → 전체선택 체크박스 상태 자동 반영
  document.querySelectorAll(".item-checkbox").forEach(cb => {
    cb.addEventListener("change", function () {
      const all = document.querySelectorAll(".item-checkbox").length;
      const checked = document.querySelectorAll(".item-checkbox:checked").length;
      document.getElementById("select-all").checked = all === checked;
    });
  });
</script>

<script>/* 수량변경 script */
/* function changeQty(button, delta) {
	const qtyValueElem = button.parentElement.querySelector('.qty-value');
	let currentQty = parseInt(qtyValueElem.textContent);

	// 최소 수량 제한 (예: 1)
	const newQty = Math.max(1, currentQty + delta);

	qtyValueElem.textContent = newQty;
} */
function plusQty(i, f_id, pd_id){
	const currentQty = parseInt(document.getElementById("quantity" + i).textContent);
	const price = parseInt(<%=pDto.getP_price()%>);
	
	// 최소 수량 제한 (예: 1)
	const newQty = Math.max(1, currentQty + 1);
	
     fetch("updateCart.jsp?f_id=" + encodeURIComponent(f_id) + "&quantity=" + encodeURIComponent(newQty) + "&pd_id=" + encodeURIComponent(pd_id))
    .then(res => res.json())
    .then(data => {
      if (data.result === "success") {
   		document.getElementById("quantity" + i).textContent = newQty;
   		document.getElementById("price" + i).textContent = (newQty * price).toLocaleString() + " 원";
      } else {
		alert("재고가 부족합니다.");
      }
    });
}

function minusQty(i, f_id, pd_id){
	const currentQty = parseInt(document.getElementById("quantity" + i).textContent);
	const price = parseInt(<%=pDto.getP_price()%>);
	
	// 최소 수량 제한 (예: 1)
	const newQty = Math.max(1, currentQty - 1);
	
    fetch("updateCart.jsp?f_id=" + encodeURIComponent(f_id) + "&quantity=" + encodeURIComponent(newQty) + "&pd_id=" + encodeURIComponent(pd_id))
    .then(res => res.json())
    .then(data => {
      if (data.result === "success") {
   		document.getElementById("quantity" + i).textContent = newQty;
   		document.getElementById("price" + i).textContent = (newQty * price).toLocaleString() + " 원";
      } else {
		alert("재고가 부족합니다.");
      }
    });
}
</script>

</body>
</html>
