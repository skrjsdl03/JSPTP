<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>주문서 작성</title>
  <link rel="stylesheet" href="css/pay.css">
</head>
<body>
  <!-- signup 상단과 동일한 구성 -->
  <div class="back-btn-wrap">
    <button class="menu-icon">&#9776;</button>
  </div>

  <div class="logo-wrap">
    <img src="images/logo-black.png" alt="everyWEAR 로고" class="logo-img">
  </div>

  <div class="nav-links">
    <a href="#">LOGOUT</a>
    <a href="#">CART</a>
  </div>

  <!-- 본문 시작 -->
  <div class="order-container">
    <h2 class="order-title">주문서 작성</h2>

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
    <div class="delivery-types">
      <button type="button" class="tag-btn">회사</button>
      <button type="button" class="tag-btn">학교</button>
      <button type="button" class="tag-btn">우리집</button>
      <button type="button" class="tag-btn">...</button>
    </div>

<!-- 주소 -->
<label>주소 *</label>

<!-- 우편번호 + 주소 검색 버튼 -->
<div class="address-combined">
  <input type="text" class="zipcode" placeholder="우편번호"
         onfocus="clearPlaceholderOnFocus(this)" onblur="restorePlaceholderOnBlur(this)">
  <button type="button" class="addr-btn" onclick="execDaumPostcode()">주소 검색</button>

  <input type="text" class="alias" placeholder="별칭"
         onfocus="clearPlaceholderOnFocus(this)" onblur="restorePlaceholderOnBlur(this)">
  <button type="button" class="addr-btn">저장</button>
</div>

<!-- 기본주소 + 상세주소 -->
<div class="address-sub">
  <input type="text" class="wide" placeholder="기본주소"
         onfocus="clearPlaceholderOnFocus(this)" onblur="restorePlaceholderOnBlur(this)">
  <input type="text" placeholder="상세주소"
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
	
	  <button type="submit" class="pay-btn">결제하기</button>
	</section>
	
	<!-- 푸터 -->
	<footer class="footer"> 2025©everyWEAR</footer>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
</script>

		
  </div>
</body>
</html>
