<%@ page contentType="text/html; charset=UTF-8" %>
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
    <section class="product-section">
      <p class="section-title">주문상품</p>
      <div class="product-box">
        <img src="images/fav-icon.png" alt="상품 이미지" class="product-img">
        <div class="product-detail">
          <p class="product-name">Onitsuka Tiger Tokuten Gray</p>
          <p class="product-option">220</p>
          <div class="quantity-control">
            <label>수량 :</label>
            <button type="button">-</button>
            <input type="text" value="1" readonly>
            <button type="button">+</button>
          </div>
        </div>
        <div class="product-price-box">
          <a href="#" class="option-change">옵션 변경</a>
          <p class="product-price">199,000 원</p>
        </div>
      </div>
    </section>

	<!-- 주문자 정보 -->
	<section class="info-section">
	  <p class="section-title">주문자 정보</p>
	  <form class="order-form">
	    <label>이름 *</label>
	    <input type="text" value="정시영">
	
	    <label>주소 *</label>
	    <div class="address-group">
	      <input type="text" value="47340">
	    </div>
	    <div class="address-sub">
	      <input type="text" value="부산광역시 부산진구 엄광로 176">
	      <input type="text" value="동의대학교">
	    </div>

        <label>휴대전화 *</label>
        <div class="phone-group">
          <select disabled>
            <option selected>010</option>
          </select>
          <input type="text" value="1234">
          <input type="text" value="5678">
        </div>

        <label>이메일 *</label>
        <input type="email" value="dongeui123@naver.com">
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
  <div id="delivery-extra" style="display: none;">
    <!-- 배송지 유형 버튼 -->
	<div class="delivery-types" id="alias-list">
	<button class="tag-btn" onclick="fillAddress('회사')">
    	회사
   	  <span class="delete-icon" onclick="deleteAlias(event, this)">×</span>
    </button>	  
	<button class="tag-btn" onclick="fillAddress('학교')">
    	학교
   	  <span class="delete-icon" onclick="deleteAlias(event, this)">×</span>
    </button>	  
	<button class="tag-btn" onclick="fillAddress('우리집')">
    	우리집
   	  <span class="delete-icon" onclick="deleteAlias(event, this)">×</span>
    </button>	  
    </div>

<!-- 주소 -->
<label>주소 *</label>

<!-- 우편번호 + 주소 검색 버튼 -->
	<div class="address-combined">
 	 <input type="text" id="zipcode" class="zipcode" placeholder="우편번호"
         onfocus="clearPlaceholderOnFocus(this)" onblur="restorePlaceholderOnBlur(this)">
 	 <button type="button" class="addr-btn" onclick="execDaumPostcode()">주소 검색</button>
	
  		<input type="text" class="alias" placeholder="별칭"
         onfocus="clearPlaceholderOnFocus(this)" onblur="restorePlaceholderOnBlur(this)">
	<button type="button" class="addr-btn" id="alias-save-btn" onclick="addAlias()" disabled>저장</button>
	</div>

<!-- 기본주소 + 상세주소 -->
<div class="address-sub">
  <input type="text" id="address1" class="wide" placeholder="기본주소"
         onfocus="clearPlaceholderOnFocus(this)" onblur="restorePlaceholderOnBlur(this)">
  <input type="text" id="address2" placeholder="상세주소"
         onfocus="clearPlaceholderOnFocus(this)" onblur="restorePlaceholderOnBlur(this)">
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
	    <input type="text" value="0" readonly>
	    <button type="button" class="gray-btn">최대 사용</button>
	  </div>
	</section>
	
	<!-- 결제 정보 -->
	<section class="info-section payment-section">
	  <p class="section-title">결제 정보</p>
	  <div class="payment-info">
	    <div><span>주문상품</span><span>199,000 원</span></div>
	    <div><span>배송비</span><span>+3,000 원</span></div>
	    <div><span>할인/부가결제</span><span>-0 원</span></div>
	  </div>
	
	  <p class="section-title" style="margin-top: 30px;">적립</p>
	  <div class="payment-info">
	    <div><span>회원 적립금</span><span>3,990 원</span></div>
	    <div><span>상품 적립금</span><span>1,990 원</span></div>
	  </div>
	
	  <div class="final-price">
	    <span>최종 결제 금액</span>
	    <span>202,000 원</span>
	  </div>
	
	<button type="button" class="pay-btn" onclick="fnPay()">결제하기</button>
	</section>
	
	<form id="payForm" method="post">
  <input type="hidden" name="P_INI_PAYMENT" value="CARD"> <!-- 결제수단 -->
  <input type="hidden" name="P_MID" value="INIpayTest">    <!-- 테스트 상점 ID -->
  <input type="hidden" name="P_OID" value="ORDER123456">   <!-- 주문번호 -->
  <input type="hidden" name="P_AMT" value="202000">        <!-- 결제금액 -->
  <input type="hidden" name="P_GOODS" value="주문 상품명"> <!-- 상품명 -->
  <input type="hidden" name="P_UNAME" value="정시영">      <!-- 주문자 이름 -->
  <input type="hidden" name="P_CHARSET" value="utf8">
  <input type="hidden" name="P_NEXT_URL" value="http://localhost:8080/paySuccess.jsp"> <!-- 결제 후 이동 주소 -->
</form>
		
	<!-- 푸터 -->
	<footer class="footer"> 2025©everyWEAR</footer>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://stdpay.inicis.com/stdjs/INIStdPay.js"></script>

<script>
  function execDaumPostcode() {
    new daum.Postcode({
      oncomplete: function(data) {
        document.getElementById('zipcode').value = data.zonecode;
        document.getElementById('address1').value = data.roadAddress;
        document.getElementById('address2').focus();
      }
    }).open();
  }

  function toggleDeliveryAddress(show) {
    const btn = document.getElementById('delivery-search-btn');
    btn.style.display = show ? 'inline-block' : 'none';
  }
  
  function toggleDeliveryUI(show) {
	    document.getElementById("delivery-extra").style.display = show ? "block" : "none";
	  }
  
  function clearPlaceholderOnFocus(el) {
	    el.dataset.placeholder = el.placeholder;
	    el.placeholder = '';
	  }
  
  function restorePlaceholderOnBlur(el) {
	    if (el.value === '') {
	      el.placeholder = el.dataset.placeholder;
	    }
	  }
  
  function addAlias() {
	  const input = document.querySelector(".address-combined input.alias");
	  const value = input.value.trim();
	  const aliasList = document.getElementById("alias-list");

	  if (value === "") {
	    alert("별칭을 입력해주세요.");
	    return;
	  }

	  const exists = Array.from(aliasList.children).some(btn => btn.textContent === value);
	  if (exists) {
	    alert("이미 추가된 별칭입니다.");
	    return;
	  }

	    const btn = document.createElement("button");
	    btn.className = "tag-btn";
	    btn.type = "button";
	    btn.innerHTML = `
	      ${value}
	      <span class="delete-icon" onclick="deleteAlias(event, this)">×</span>
	    `;
	    btn.addEventListener("click", () => fillAddress(value));

	    aliasList.appendChild(btn);
	    input.value = "";
	  }

	function checkAddressFilled() {
	  const address1 = document.getElementById("address1").value.trim();
	  const address2 = document.getElementById("address2").value.trim();
	  const saveBtn = document.getElementById("alias-save-btn");

	  saveBtn.disabled = !(address1 !== "" && address2 !== "");
	}

	window.addEventListener("DOMContentLoaded", () => {
	  document.getElementById("address1").addEventListener("input", checkAddressFilled);
	  document.getElementById("address2").addEventListener("input", checkAddressFilled);
	});
	
	function fillAddress(type) {
		  const zipcodeField = document.getElementById("zipcode");
		  const address1Field = document.getElementById("address1");
		  const address2Field = document.getElementById("address2");
		  const aliasInput = document.querySelector(".address-combined input.alias"); // 별칭 입력칸

		  if (type === "회사") {
		    zipcodeField.value = "06234";
		    address1Field.value = "서울 강남구 테헤란로 231";
		    address2Field.value = "OO타워 10층";
		    aliasInput.value = "회사";
		  } else if (type === "학교") {
		    zipcodeField.value = "47340";
		    address1Field.value = "부산 부산진구 엄광로 176";
		    address2Field.value = "동의대학교";
		    aliasInput.value = "학교";
		  } else if (type === "우리집") {
		    zipcodeField.value = "12345";
		    address1Field.value = "서울 마포구 월드컵북로 396";
		    address2Field.value = "XX아파트 101동 202호";
		    aliasInput.value = "우리집";
		    } else {
		        aliasInput.value = type;
		      }

		  checkAddressFilled();
		}
	
	  function deleteAlias(event, el) {
		    event.stopPropagation();
		    if (confirm("정말 이 배송지를 삭제하시겠습니까?")) {
		      const btn = el.closest(".tag-btn");
		      if (btn) btn.remove();
		    }
		  }
	  
	  function fnPay() {
		    INIStdPay.pay('payForm');
		  }

</script>
		
  </div>
</body>
</html>
