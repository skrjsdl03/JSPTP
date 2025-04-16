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
			<div class="qty-wrapper">
			  <label>수량 :</label>
			  <div class="qty-text-control">
			    <span class="qty-action" onclick="changeQty(-1)">-</span>
			    <span class="qty-number" id="qty-display">1</span>
			    <span class="qty-action" onclick="changeQty(1)">+</span>
			  </div>
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
	    <input type="text" value="정시영" readonly>
	
	    <label>주소 *</label>
	    <div class="address-group">
	      <input type="text" value="47340" readonly>
	    </div>
	    <div class="address-sub">
	      <input type="text" value="부산광역시 부산진구 엄광로 176" readonly>
	      <input type="text" value="동의대학교" readonly>
	    </div>

        <label>휴대전화 *</label>
		<div class="phone-group">
		  <input type="text" value="010" readonly>
		  <span class="phone-divider">-</span>
		  <input type="text" value="1234" readonly>
		  <span class="phone-divider">-</span>
		  <input type="text" value="5678" readonly>
		</div>

        <label>이메일 *</label>
        <input type="email" value="dongeui123@naver.com" readonly>
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
	  <button class="tag-btn">회사<span class="delete-icon">×</span></button>
	  <button class="tag-btn">학교<span class="delete-icon">×</span></button>
	  <button class="tag-btn">우리집<span class="delete-icon">×</span></button>
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
		  <input type="text" class="alias" placeholder="배송지 별칭 입력" onfocus="clearPlaceholder(this)" onblur="restorePlaceholder(this)">
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
	    <input type="text" value="0" readonly>
	    <button type="button" class="gray-btn">최대 사용</button>
	  </div>
	  <p class="point-hint">보유 적립금: <strong>5,000</strong> 원</p> <!-- 추가 -->
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
  </div>
  
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://stdpay.inicis.com/stdjs/INIStdPay.js"></script>

<script>
  // 📌 배송지 별칭 → 주소 자동입력
  const addressMap = {
    "회사": ["06234", "서울 강남구 테헤란로 231", "OO타워 10층"],
    "학교": ["47340", "부산 부산진구 엄광로 176", "동의대학교"],
    "우리집": ["12345", "서울 마포구 월드컵북로 396", "XX아파트 101동 202호"]
  };

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
    } else {
      copyOrdererAddress();
      aliasList.style.display = 'none';
      aliasInputRow.style.display = 'none';
      addrInputs.forEach(el => el.readOnly = true);
      document.querySelector(".alias").value = "";
    }
  }

  // 📌 주문자 정보 복사
  function copyOrdererAddress() {
    document.getElementById("zipcode").value = "47340";
    document.getElementById("address1").value = "부산광역시 부산진구 엄광로 176";
    document.getElementById("address2").value = "동의대학교";
    document.getElementById("address2").readOnly = true;
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
    copyOrdererAddress(); // 기본 주소 세팅

    // 라디오 버튼 UI 전환
    document.querySelectorAll('input[name="delivery"]').forEach(radio => {
      radio.addEventListener("change", e => {
        toggleDeliveryUI(e.target.value === "different");
      });
    });

    // 정적 별칭 클릭 → 주소 채우기
    document.getElementById("alias-list").addEventListener("click", function (e) {
      const btn = e.target.closest(".tag-btn");
      if (btn && !e.target.classList.contains("delete-icon")) {
        const alias = btn.textContent.trim().replace("×", "").trim();
        fillAddressByAlias(alias);
      }
    });

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
