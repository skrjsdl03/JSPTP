<%@page import="java.util.UUID"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="DTO.FavoriteDTO"%>
<%@page import="DTO.ProductDTO"%>
<%@page import="DTO.ProductImgDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="DTO.UserAddrDTO"%>
<%@page import="DTO.UserDTO"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<jsp:useBean id="uDao" class="DAO.UserDAO"/>
<jsp:useBean id="pDao" class="DAO.ProductDAO"/>
<jsp:useBean id="fDao" class="DAO.FavoriteDAO"/>
<%
	String userId = (String)session.getAttribute("id");
	String userType = (String)session.getAttribute("userType");
	
	UserDTO userDto = null;
	Vector<UserAddrDTO> addrList = null;
	if(userId != null && !userId.equals("")){
		userDto = uDao.getOneUser(userId, userType);
		addrList = uDao.showAllAddr(userId, userType);
	}
	
    DecimalFormat formatter = new DecimalFormat("#,###");
	
	  String[] selectedFIds = request.getParameterValues("f_ids");

	  if (selectedFIds != null) {
	    for (String f_id : selectedFIds) {
	      System.out.println("선택된 f_id: " + f_id);
	      // 여기에 DB 조회나 가격 합산 처리 가능
	    }
	  } else {
	  }
	  
	  String reqpd_id = request.getParameter("pd_id");
	  String qty = request.getParameter("quantity");
	  int req_pd_id = 0;
	  int req_qty = 0;
	  if(reqpd_id != null && !reqpd_id.equals("")){
		  req_pd_id = Integer.parseInt(reqpd_id);
		  req_qty = Integer.parseInt(qty);
	  }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>주문서 작성 | everyWEAR</title>
  <link rel="icon" type="image/png" href="images/fav-icon.png">
  <link rel="stylesheet" href="css/pay.css">
</head>
<body>

	<%@ include file="includes/header.jsp"%>
	
		<section class="content2">
		<h3>주문서 작성</h3>
	</section>

  <!-- 본문 시작 -->
  <div class="order-container">
  
    <!-- 주문상품 -->
    <p class="section-title">주문상품</p>
    <%
    		if(selectedFIds != null && selectedFIds.length != 0){
    		for(int i = 0; i<selectedFIds.length; i++){ 
    		int pd_id = pDao.getPdWhenOrder(Integer.parseInt(selectedFIds[i]));
    		FavoriteDTO fDto = fDao.getOneFavorite(Integer.parseInt(selectedFIds[i]));
    		String size = pDao.getOnePdSizeForCart(pd_id);
    		Vector<String> img = pDao.getOnePdImgForCart(pd_id);
    		ProductDTO pd = pDao.getOnePdForCart(pd_id);
    %>
    <section class="product-section">
      <div class="product-box">
        <img src="<%=img.get(0)%>" alt="상품 이미지" class="product-img">
        <div class="product-detail">
          <p class="product-name"><%=pd.getP_name()%></p>
          <p class="product-option">SIZE | <%=size%><br>COLOR | <%=pd.getP_color()%></p>
			<div class="qty-wrapper">
			  <label>수량 :</label>
			  <div class="qty-text-control">
			    <span class="qty-number" id="qty-display"><%=fDto.getF_quantity()%></span>
			  </div>
			</div>
        </div>
        <div class="product-price-box">
          <p class="product-price"><%=formatter.format(pd.getP_price() * fDto.getF_quantity())%> 원</p>
        </div>
      </div>
    </section>
	<hr style="color: #E7E7E7; width: 100%;">
    <%} 
   		}
    if(req_pd_id != 0){
		String size = pDao.getOnePdSizeForCart(req_pd_id);
		Vector<String> img = pDao.getOnePdImgForCart(req_pd_id);
		ProductDTO pd = pDao.getOnePdForCart(req_pd_id);
    %>
        <section class="product-section">
      <div class="product-box">
        <img src="<%=img.get(0)%>" alt="상품 이미지" class="product-img">
        <div class="product-detail">
          <p class="product-name"><%=pd.getP_name()%></p>
          <p class="product-option">SIZE | <%=size%><br>COLOR | <%=pd.getP_color()%></p>
			<div class="qty-wrapper">
			  <label>수량 :</label>
			  <div class="qty-text-control">
			    <span class="qty-number" id="qty-display"><%=req_qty%></span>
			  </div>
			</div>
        </div>
        <div class="product-price-box">
          <p class="product-price"><%=formatter.format(pd.getP_price() * req_qty)%> 원</p>
        </div>
      </div>
    </section>
	<hr style="color: #E7E7E7; width: 100%;">
    <%} %>


<%if(userId != null && !userId.equals("")){ %>		<!-- 회원일때 -->
	<!-- 주문자 정보 -->
	<section class="info-section">
	  <p class="section-title">주문자 정보</p>
	  <form class="order-form">
	    <label>이름 *</label>
	    <input type="text" value="<%=userDto.getUser_name()%>" readonly>
	
	    <label>주소 *</label>
	    <div class="address-group">
	      <input type="text" value="<%=addrList.get(0).getAddr_zipcode()%>" readonly>
	    </div>
	    <div class="address-sub">
	      <input type="text" value="<%=addrList.get(0).getAddr_road()%>" readonly>
	      <input type="text" value="<%=addrList.get(0).getAddr_detail()%>" readonly>
	    </div>

        <label>휴대전화 *</label>
		<div class="phone-group">
		  <input type="text" value="<%=userDto.getUser_phone().split("-")[0]%>" readonly>
		  <span class="phone-divider">-</span>
		  <input type="text" value="<%=userDto.getUser_phone().split("-")[1]%>" readonly>
		  <span class="phone-divider">-</span>
		  <input type="text" value="<%=userDto.getUser_phone().split("-")[2]%>" readonly>
		</div>

        <label>이메일</label>
        <input type="email" id="email" value="<%=userDto.getUser_email()%>" <%=(userDto.getUser_email() == null || userDto.getUser_email().equals("")) ? "" : "readonly"%>>
      </form>
    </section>
<!-- 배송지 -->
<section class="info-section">
  <p class="section-title">배송지</p>
  <div class="radio-group">
    <label><input type="radio" name="delivery" value="same" checked onclick="toggleDeliveryUI(false)"> 주문자 정보와 동일</label>
    <label><input type="radio" name="delivery" value="different" onclick="toggleDeliveryUI(true)"> 다른 배송지</label>
  </div>

  <!-- 다른 배송지 선택 시 나타나는 영역 -->
 <div id="delivery-extra">
    <!-- 배송지 유형 버튼 -->
	<div class="delivery-types" id="alias-list">
	<%for(int i = 1; i<addrList.size(); i++){ 
		UserAddrDTO addr = addrList.get(i);
	%>
	  <button class="tag-btn"><%=addr.getAddr_label()%><span class="delete-icon">×</span></button>
	<%} %>
	</div>
</div>

	<!-- 주소 -->
	<label>주소 *</label>
	
	<!-- 우편번호 + 주소 검색 버튼 -->
	<div class="address-row-top">
	  <input type="text" id="zipcode" class="zipcode" placeholder="우편번호" readonly>
	  <button type="button" class="addr-btn" onclick="execDaumPostcode()">주소 검색</button>
		<!-- 별칭 입력란 -->
		<div id="alias-input-row" class="address-combined">
		  <input type="text" class="alias" id="alias" placeholder="배송지 별칭 입력" onfocus="clearPlaceholder(this)" onblur="restorePlaceholder(this)">
		</div>
	</div>
	
	<!-- 기본주소 + 상세주소 -->
	<div class="address-sub">
	  <input type="text" id="address1" placeholder="기본주소" readonly>
	  <input type="text" id="address2" placeholder="상세주소" readonly>
	</div>
</section>

	<!-- 쿠폰 -->
	<section class="info-section">
	  <p class="section-title">쿠폰</p>
	  <div class="inline-group">
	    <input type="text" value="사용가능한 쿠폰이 없습니다." readonly>
	    <button type="button" class="gray-btn">쿠폰 선택</button>
	  </div>
	</section>
	
	<!-- 적립금 -->
	<section class="info-section">
	  <p class="section-title">적립금</p>
	  <div class="inline-group">
	    <input type="text" placeholder="0" id="mileage">
	    <button type="button" class="gray-btn" onclick="allUse()">최대 사용</button>
	  </div>
	  <p class="point-hint">보유 적립금: <strong id="currentMileage"><%=formatter.format(userDto.getUser_point())%></strong> 원</p> <!-- 추가 -->
	</section>
	<%}else{ %>		<!-- 비회원일때 -->
		<!-- 주문자 정보 -->
	<section class="info-section">
	  <p class="section-title">주문자 정보</p>
	  <form class="order-form">
	    <label>이름 *</label>
	    <input type="text" id="name" name="name">
	
		<!-- 주소 -->
		<label>주소 *</label>
		
		<!-- 우편번호 + 주소 검색 버튼 -->
		<div class="address-row-top">
		  <input type="text" id="zipcode" class="zipcode" name="zipcode" placeholder="우편번호" readonly>
		  <button type="button" class="addr-btn" onclick="execDaumPostcode()">주소 검색</button>
			<!-- 별칭 입력란 -->
			<div id="alias-input-row" class="address-combined">
			  <input type="text" class="alias" id="alias" placeholder="배송지 별칭 입력" onfocus="clearPlaceholder(this)" onblur="restorePlaceholder(this)">
			</div>
		</div>
		
		<!-- 기본주소 + 상세주소 -->
		<div class="address-sub">
		  <input type="text" id="address1" name="address1" placeholder="기본주소" readonly>
		  <input type="text" id="address2" name="address2" placeholder="상세주소">
		</div>

        <label>휴대전화 *</label>
		<div class="phone-group">
		  <input type="text" id="phone1" name="phone1" maxlength="3">
		  <span class="phone-divider">-</span>
		  <input type="text" id="phone2" name="phone2" maxlength="4">
		  <span class="phone-divider">-</span>
		  <input type="text" id="phone3" name="phone3" maxlength="4">
		</div>

        <label>이메일</label>
        <input type="email" id="email" name="email">
      </form>
    </section>
	<%} %>
	
	
	
	
	
	<!-- 결제 정보 -->
	<section class="info-section payment-section">
	  <p class="section-title">결제 정보</p>
	  <div class="payment-info">
	    <div><span>주문상품</span><span id="product-price">199,000 원</span></div>
	    <div><span>배송비</span><span id="delivery-fee">+3,000 원</span></div>
	    <div><span>할인/부가결제</span><span id="discount">0 원</span></div>
	  </div>
	<%if(userId != null && !userId.equals("")){ %>
	  <p class="section-title" style="margin-top: 30px;">적립</p>
	  <div class="payment-info">
	    <div><span>상품 적립금</span><span id="product-point">1,990 원</span></div>
	  </div>
	  <%} %>
	
	  <div class="final-price">
	    <span>최종 결제 금액</span>
	    <span id="final-total">202,000 원</span>
	  </div>
	  
	  <!-- 추천 상품 섹션 -->
		<section class="recommend-section">
		  <p class="section-title">추천 상품</p>
		  <div class="recommend-list">
		
		    <!-- 상품 1 -->
		    <div class="recommend-item">
		      <img src="images/main-cloth1.png" alt6="추천 상품 1">
		      <p class="item-name">WL VARSITY JACKET</p>
		      <p class="item-price">129,000 원</p>
		    </div>
		
		    <!-- 상품 2 -->
		    <div class="recommend-item">
		      <img src="images/main-cloth2.png" alt="추천 상품 2">
		      <p class="item-name">PPS HAIRY CARDIGANK</p>
		      <p class="item-price">99,000 원</p>
		    </div>
		
		    <!-- 상품 3 -->
		    <div class="recommend-item">
		      <img src="images/main-cloth3.png" alt="추천 상품 3">
		      <p class="item-name">S.D LONG SLEEVE TEE</p>
		      <p class="item-price">49,000 원</p>
		    </div>
		
		  </div>
		</section>
			  
	<button type="button" class="pay-btn" onclick="fnPay()">결제하기</button>
	</section>
	
	<%
    String date = new SimpleDateFormat("yyyyMMdd").format(new Date());

    // UUID의 일부를 사용해 랜덤 문자열 생성
    String uuid = UUID.randomUUID().toString().replaceAll("-", "").substring(0, 8).toUpperCase();

    String ONUM = "ORD" + date + uuid;
    
    String products = "";
    if(selectedFIds != null && selectedFIds.length != 0){	//장바구니를 통한 구매(회원만 가능)
    	if(selectedFIds.length > 1){
    		ProductDTO pd = pDao.getOnePdForCart(pDao.getPdWhenOrder(Integer.parseInt(selectedFIds[0])));
    		products = pd.getP_name() + " 외 " + (selectedFIds.length - 1) + "개";
    	} else{
    		ProductDTO pd = pDao.getOnePdForCart(pDao.getPdWhenOrder(Integer.parseInt(selectedFIds[0])));
    		products = pd.getP_name();
    	}
    } else if(req_pd_id != 0){		//상품 하나 바로 구매(회원, 비회원 둘 다 가능)
    	ProductDTO pd = pDao.getOnePdForCart(req_pd_id);
    	products = pd.getP_name();
    }
	%>
	
	<form id="payProc" method="post" action="payProc.jsp">
	  <input type="hidden" name="P_INI_PAYMENT" value="card"> <!-- 결제수단 -->
	  <input type="hidden" name="ONum" value="<%=ONUM%>">   <!-- 주문번호 -->
	  <input type="hidden" name="Price" id="Price">        <!-- 결제금액 -->
	  <input type="hidden" name="Products" value="<%=products%>"> <!-- 상품명 -->
	  <input type="hidden" name="P_CHARSET" value="utf8">
	  <input type="hidden" name="P_NEXT_URL" value="http://everywear.ddns.net/JSPTP/payComplete.jsp"> <!-- 결제 후 이동 주소 -->
	  <input type="hidden" name="PName" id="PName"> <!-- 이름 -->
	  <input type="hidden" name="PZipcode" id="PZipcode"> <!-- 주소1 -->
	  <input type="hidden" name="PAddress1" id="PAddress1"> <!-- 주소2 -->
	  <input type="hidden" name="PAddress2" id="PAddress2"> <!-- 주소3 -->
	  <input type="hidden" name="PAddress3" id="PAddress3"> <!-- 주소별칭 -->
	  <input type="hidden" name="PPhone" id="PPhone"> <!-- 전화번호 -->
	  <input type="hidden" name="PEmail" id="PEmail"> <!-- 이메일 -->
	  <%
	  		if(selectedFIds != null && selectedFIds.length != 0){ 
	  			for(int i = 0;i<selectedFIds.length; i++){
  				FavoriteDTO fDto = fDao.getOneFavorite(Integer.parseInt(selectedFIds[i]));
	  %>
	  	<input type="hidden" name="PQty" value="<%=fDto.getF_quantity()%>">
	  	<input type="hidden" name="PPd_id" value="<%=fDto.getPd_id()%>">
	  <%} 
	  	}
	  if(req_pd_id != 0){
	  %>
	  <input type="hidden" name="PQty" value="<%=req_qty%>">
	  	<input type="hidden" name="PPd_id" value="<%=req_pd_id%>">
	  <%} %>
  </form>
		
	<!-- 푸터 -->
	<footer class="footer"> 2025©everyWEAR</footer>
  </div>
  
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://stdpay.inicis.com/stdjs/INIStdPay.js"></script>


<script>
function fnPay(){
	<%if(userId == null || userId.equals("")){%>
		if(document.getElementById("name").value == null || document.getElementById("name").value == ""){
			alert("이름을 입력하시오.");
			return;
		}
		if(document.getElementById("phone2").value == null || document.getElementById("phone2").value == ""){
			alert("전화번호를 입력하시오.");
			return;
		}
		if(document.getElementById("address1").value == null || document.getElementById("address1").value == ""){
			alert("주소를 입력하시오.");
			return;
		}
	<%}%>
	
	const priceStr = document.getElementById("final-total").textContent; // "109,000 원"
	const price = parseInt(priceStr.replace(/[^\d]/g, ""), 10); // 109000
	
	document.getElementById("Price").value = price;
	
    const zipcode = document.getElementById("zipcode").value;
    const address1 = document.getElementById("address1").value;
    const address2 = document.getElementById("address2").value;
    const alias = document.getElementById("alias").value;
    
    document.getElementById("PZipcode").value = zipcode;
    document.getElementById("PAddress1").value = address1;
    document.getElementById("PAddress2").value = address2;
    if(!alias)
    	document.getElementById("PAddress3").value = alias;
    
    const email = document.getElementById("email").value;
    document.getElementById("PEmail").value = email;
    <%if(userId != null && !userId.equals("")){%>
    document.getElementById("PName").value = "<%=userDto.getUser_name()%>";
    document.getElementById("PPhone").value = "<%=userDto.getUser_phone()%>";
    <%}%>
	
	<%if(userId == null || userId.equals("")){%>
	const name = document.getElementById("name").value;
	document.getElementById("PName").value = name;
	const p1 = document.getElementById("phone1").value;
	const p2 = document.getElementById("phone2").value;
	const p3 = document.getElementById("phone3").value;
	document.getElementById("PPhone").value = p1 + "-" + p2 + "-" + p3;
	<%}%>
	document.getElementById("payProc").submit();
}

</script>

<script>
<%if(userId != null && !userId.equals("")){%>
const mileageInput = document.getElementById("mileage");
const currentMileage = parseInt(document.getElementById("currentMileage").textContent.replace(/,/g, ''));

mileageInput.addEventListener("input", function () {
  // 입력값에서 숫자 이외 문자 제거
  this.value = this.value.replace(/[^0-9]/g, '');

  // 정수로 변환
  let inputVal = parseInt(this.value);

  // 만약 입력값이 보유 적립금 초과하면 보유 적립금으로 설정
  if (inputVal > currentMileage) {
    allUse();
  }
});
<%}%>

function calculateTotal() {
  const productPriceElems = document.querySelectorAll('.product-price');
  let totalProductPrice = 0;

  productPriceElems.forEach(elem => {
    const price = parseInt(elem.textContent.replace(/[^\d]/g, ''));
    totalProductPrice += price;
  });
  
  //상품 적립금
  const sm = totalProductPrice / 100;

  // 배송비 계산 (5만원 미만이면 3000원)
  const deliveryFee = (totalProductPrice < 50000) ? 3000 : 0;

  // 쿠폰/적립금 값 가져오기
 /*  const coupon = parseInt(document.getElementById("coupon")?.value || 0); */
  const mileage = parseInt(document.getElementById("mileage")?.value || 0);
  const discount = mileage;
/*   const discount = coupon + mileage; */

  // 최종 결제 금액
  const finalTotal = totalProductPrice + deliveryFee - discount;

  // DOM 반영
  document.getElementById("product-price").textContent = totalProductPrice.toLocaleString() + " 원";
  document.getElementById("delivery-fee").textContent = (deliveryFee > 0 ? "+" : "") + deliveryFee.toLocaleString() + " 원";
  document.getElementById("discount").textContent = discount.toLocaleString() + " 원";
  document.getElementById("final-total").textContent = finalTotal.toLocaleString() + " 원";
  document.getElementById("product-point").textContent = sm.toLocaleString() + " 원";
}

<%if(userId != null && !userId.equals("")){%>
// 쿠폰이나 마일리지 입력 시 자동 업데이트
/* document.getElementById("coupon")?.addEventListener("input", calculateTotal); */
document.getElementById("mileage")?.addEventListener("input", calculateTotal);

// 페이지 로드 시 계산
window.addEventListener("load", calculateTotal);
<%}else{%>
const productPriceElems = document.querySelectorAll('.product-price');
let totalProductPrice = 0;

productPriceElems.forEach(elem => {
  const price = parseInt(elem.textContent.replace(/[^\d]/g, ''));
  totalProductPrice += price;
});
document.getElementById("product-price").textContent = totalProductPrice.toLocaleString() + " 원";
// 배송비 계산 (5만원 미만이면 3000원)
const deliveryFee = (totalProductPrice < 50000) ? 3000 : 0;

document.getElementById("delivery-fee").textContent = (deliveryFee > 0 ? "+" : "") + deliveryFee.toLocaleString() + " 원";

const finalTotal = totalProductPrice + deliveryFee;
document.getElementById("final-total").textContent = finalTotal.toLocaleString() + " 원";
<%}%>
</script>

<script>
<%if(userId == null || userId.equals("")){%>
// 숫자만 입력되게
['phone1', 'phone2', 'phone3'].forEach(id => {
  document.getElementById(id).addEventListener('input', (e) => {
    e.target.value = e.target.value.replace(/[^0-9]/g, '');
  });
});
<%}%>

function allUse(){
	const cm = document.getElementById("currentMileage").textContent;
	document.getElementById("mileage").value = cm.replace(/,/g, '');
 	document.getElementById("discount").textContent = cm + " 원";
	calculateTotal();
}

</script>

<script>
  // 📌 배송지 별칭 → 주소 자동입력
/*   const addressMap = {
    "회사": ["06234", "서울 강남구 테헤란로 231", "OO타워 10층"],
    "학교": ["47340", "부산 부산진구 엄광로 176", "동의대학교"],
    "우리집": ["12345", "서울 마포구 월드컵북로 396", "XX아파트 101동 202호"]
  }; */
  <%if(userId != null && !userId.equals("")){%>
  const addressMap = {
		  <%
		    for (int i = 0; i < addrList.size(); i++) {
		      UserAddrDTO addr = addrList.get(i);
		  %>
		    "<%=addr.getAddr_label()%>": ["<%=addr.getAddr_zipcode()%>", "<%=addr.getAddr_road()%>", "<%=addr.getAddr_detail()%>"]<%= (i < addrList.size() - 1) ? "," : "" %>
		  <% } %>
		  };
  <%}%>
  

  function fillAddressByAlias(alias) {
    const addr = addressMap[alias];
    if (!addr) return;

    document.getElementById("zipcode").value = addr[0];
    document.getElementById("address1").value = addr[1];
    document.getElementById("address2").value = addr[2];
    document.getElementById("address2").readOnly = false;
    document.querySelector(".alias").value = alias;
  }

  // 📌 주소 검색
  function execDaumPostcode() {
    new daum.Postcode({
      oncomplete: function(data) {
        document.getElementById('zipcode').value = data.zonecode;
        document.getElementById('address1').value = data.roadAddress;
        document.getElementById('address2').focus();
        document.getElementById("address2").readOnly = false;
      }
    }).open();
  }

  // 📌 배송지 UI 전환
  function toggleDeliveryUI(show) {
    const aliasList = document.getElementById("alias-list");
    const aliasInputRow = document.getElementById("alias-input-row");
    const addrInputs = document.querySelectorAll('#delivery-extra input');

    if (show) {
      aliasList.style.display = 'flex';
      aliasInputRow.style.display = 'flex';
      addrInputs.forEach(el => el.readOnly = false);
      addrResetEmpty();
    } else {
      aliasList.style.display = 'none';
      aliasInputRow.style.display = 'none';
      addrInputs.forEach(el => el.readOnly = true);
      document.querySelector(".alias").value = "";
      addrReset();
    }
  }
  
  
<%if(addrList != null){%>
  function addrReset(){
	    document.getElementById("zipcode").value = "<%=addrList.get(0).getAddr_zipcode()%>";
	    document.getElementById("address1").value = "<%=addrList.get(0).getAddr_road()%>";
	    document.getElementById("address2").value = "<%=addrList.get(0).getAddr_detail()%>";
  }
<%}%>
  
  function addrResetEmpty(){
	    document.getElementById("zipcode").value = "";
	    document.getElementById("address1").value = "";
	    document.getElementById("address2").value = "";
	    document.getElementById("alias").value = "";
  }

  // 📌 별칭 삭제
  function deleteAlias(event, el) {
    event.stopPropagation();
    if (confirm("정말 삭제할까요?")) {
      const btn = el.closest(".tag-btn");
      if (btn) btn.remove();
    }
  }

  // 📌 별칭 추가
  function addAlias() {
    const input = document.querySelector(".alias");
    const value = input.value.trim();
    const aliasList = document.getElementById("alias-list");

    if (!value) {
      alert("별칭을 입력해주세요.");
      return;
    }

    const exists = Array.from(aliasList.children).some(btn => btn.textContent.includes(value));
    if (exists) {
      alert("이미 있는 별칭입니다.");
      return;
    }

    const btn = document.createElement("button");
    btn.className = "tag-btn";
    btn.innerHTML = value + "<span class='delete-icon' onclick='deleteAlias(event, this)'>×</span>";
    btn.addEventListener("click", () => fillAddressByAlias(value));
    aliasList.appendChild(btn);
    input.value = "";
  }

  // 📌 placeholder 관련
  function clearPlaceholder(el) {
    el.dataset.placeholder = el.placeholder;
    el.placeholder = '';
  }

  function restorePlaceholder(el) {
    if (el.value === '') {
      el.placeholder = el.dataset.placeholder;
    }
  }

  // 📌 페이지 로드 시 처리
  window.addEventListener("DOMContentLoaded", () => {
	  <%if(addrList != null){%>
		addrReset();
		<%}%>
    // 라디오 버튼 UI 전환
    document.querySelectorAll('input[name="delivery"]').forEach(radio => {
      radio.addEventListener("change", e => {
        toggleDeliveryUI(e.target.value === "different");
      });
    });

    <%if(addrList != null){%>
    // 정적 별칭 클릭 → 주소 채우기
    document.getElementById("alias-list").addEventListener("click", function (e) {
      const btn = e.target.closest(".tag-btn");
      if (btn && !e.target.classList.contains("delete-icon")) {
        const alias = btn.textContent.trim().replace("×", "").trim();
        fillAddressByAlias(alias);
      }
    });
    <%}%>

    // 정적 삭제 버튼에도 이벤트 연결
    document.querySelectorAll(".tag-btn .delete-icon").forEach(icon => {
      icon.addEventListener("click", function (e) {
        deleteAlias(e, this);
      });
    });
  });
</script>

</body>
</html>
