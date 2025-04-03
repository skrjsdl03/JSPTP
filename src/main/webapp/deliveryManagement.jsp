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
    <p class="username">정시영 님</p>
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

  <!-- 배송지 폼을 위로 올리기 위한 래퍼 추가 -->
  <div class="delivery-content">
    <div class="delivery-title-wrap">
      <h2 class="delivery-title">배송지 관리</h2>
    </div>

<!-- 기본 배송지-->
<div class="delivery-box">
  <div class="delivery-top">
    <label><input type="radio" name="selected" checked> 기본 배송지</label>
  </div>
  <div class="delivery-inputs">
    <input type="text" id="alias" class="input-tag" value="회사" readonly>
    <input type="text" id="zipcode" class="input-zipcode" value="47340" readonly>
    <button id="searchAddressBtn" class="btn-search" disabled>주소 검색</button>
  </div>
  <div class="delivery-inputs">
    <input type="text" id="address1" class="input-full" value="부산광역시 부산진구 엄광로 176" readonly>
    <input type="text" id="address2" class="input-full" value="동의대학교 중앙도서관" readonly>
    <a href="#" class="btn-edit" onclick="enableBasicEdit()">수정</a>
  </div>
</div>

<hr style="margin: 30px 0; border: none; border-top: 1px solid #eee;">

<!-- 다른 배송지 1 -->
<div class="delivery-box">
  <div class="delivery-top">
    <label><input type="radio" name="selected" onclick="promoteToDefault(this)"> 다른 배송지</label>
  </div>
  <div class="delivery-inputs">
    <input type="text" class="input-tag" value="학교" readonly>
    <input type="text" class="input-zipcode" value="12345" readonly>
    <button class="btn-search" disabled>주소 검색</button>
  </div>
  <div class="delivery-inputs">
    <input type="text" class="input-full" value="부산광역시 부산진구 양정로 99" readonly>
    <input type="text" class="input-full" value="컴퓨터공학관 202호" readonly>
    <div class="action-group">
      <a href="#" class="btn-edit" onclick="enableEdit(this)">수정</a>
      <a href="#" class="btn-delete" onclick="deleteAddress(this)">삭제</a>
    </div>
  </div>
</div>

<!-- 다른 배송지 2 -->
<div class="delivery-box">
  <div class="delivery-top">
    <label><input type="radio" name="selected" onclick="promoteToDefault(this)"> 다른 배송지</label>
  </div>
  <div class="delivery-inputs">
    <input type="text" class="input-tag" value="집" readonly>
    <input type="text" class="input-zipcode" value="67890" readonly>
    <button class="btn-search" disabled>주소 검색</button>
  </div>
  <div class="delivery-inputs">
    <input type="text" class="input-full" value="서울특별시 강남구 테헤란로 100" readonly>
    <input type="text" class="input-full" value="101동 202호" readonly>
    <div class="action-group">
      <a href="#" class="btn-edit" onclick="enableEdit(this)">수정</a>
      <a href="#" class="btn-delete" onclick="deleteAddress(this)">삭제</a>
    </div>
  </div>
</div>

<!-- 다른 배송지 3 -->
<div class="delivery-box">
  <div class="delivery-top">
    <label><input type="radio" name="selected" onclick="promoteToDefault(this)"> 다른 배송지</label>
  </div>
  <div class="delivery-inputs">
    <input type="text" class="input-tag" value="친구집" readonly>
    <input type="text" class="input-zipcode" value="54321" readonly>
    <button class="btn-search" disabled>주소 검색</button>
  </div>
  <div class="delivery-inputs">
    <input type="text" class="input-full" value="대구광역시 수성구 동대구로 120" readonly>
    <input type="text" class="input-full" value="아파트 3단지 305호" readonly>
    <div class="action-group">
      <a href="#" class="btn-edit" onclick="enableEdit(this)">수정</a>
      <a href="#" class="btn-delete" onclick="deleteAddress(this)">삭제</a>
    </div>
  </div>
</div>



    </div>
  </div>

  <footer>2025©everyWEAR</footer>
  
  <!-- 다음 주소 API -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
  // 기본 배송지 전용 수정
  function enableBasicEdit() {
    document.getElementById('alias').removeAttribute('readonly');
    document.getElementById('zipcode').removeAttribute('readonly');
    document.getElementById('address1').removeAttribute('readonly');
    document.getElementById('address2').removeAttribute('readonly');
    document.getElementById('searchAddressBtn').disabled = false;
  }

  // 다른 배송지용 수정
  function enableEdit(btn) {
    const box = btn.closest('.delivery-box');
    const inputs = box.querySelectorAll('input');
    const searchBtn = box.querySelector('.btn-search');

    inputs.forEach(input => input.removeAttribute('readonly'));
    if (searchBtn) searchBtn.disabled = false;
  }

  // 주소 검색 기능 (다음 API)
  function openPostcode(zipcodeInput, address1Input, address2Input) {
    new daum.Postcode({
      oncomplete: function(data) {
        zipcodeInput.value = data.zonecode;
        address1Input.value = data.roadAddress;
        address2Input.focus();
      }
    }).open();
  }

  // 삭제 버튼 기능
  function deleteAddress(btn) {
    const box = btn.closest('.delivery-box');
    if (confirm("정말 삭제하시겠습니까?")) {
      box.remove();
    }
  }

  // 라디오 버튼 클릭 시 기본 배송지 승격 기능
  function promoteToDefault(radio) {
    const selectedBox = radio.closest(".delivery-box");
    const defaultContainer = document.getElementById("default-address-container");
    const otherContainer = document.getElementById("other-addresses-container");

    const currentDefault = defaultContainer.querySelector(".delivery-box");

    // 기존 기본 배송지를 다른 배송지로 이동
    if (currentDefault && currentDefault !== selectedBox) {
      const radioInput = currentDefault.querySelector('input[type="radio"]');
      radioInput.checked = false;
      radioInput.setAttribute("onclick", "promoteToDefault(this)");

      // 라벨 수정
      currentDefault.querySelector(".delivery-top label").innerHTML = `
        <input type="radio" name="selected" onclick="promoteToDefault(this)"> 다른 배송지
      `;

      // 삭제 버튼이 없다면 추가
      const btnGroup = currentDefault.querySelector('.btn-group');
      if (!btnGroup.querySelector('.btn-delete')) {
        const deleteBtn = document.createElement('a');
        deleteBtn.href = "#";
        deleteBtn.className = "btn-delete";
        deleteBtn.textContent = "삭제";
        deleteBtn.setAttribute("onclick", "deleteAddress(this)");
        btnGroup.appendChild(deleteBtn);
      }

      otherContainer.appendChild(currentDefault);
    }

    // 선택한 박스를 기본 배송지로 승격
    radio.checked = true;
    selectedBox.querySelector(".delivery-top label").innerHTML = `
      <input type="radio" name="selected" checked> 기본 배송지
    `;

    // 삭제 버튼 제거
    const deleteBtn = selectedBox.querySelector(".btn-delete");
    if (deleteBtn) deleteBtn.remove();

    defaultContainer.appendChild(selectedBox);
  }

  // DOMContentLoaded 후 이벤트 등록
  window.addEventListener('DOMContentLoaded', () => {
    // 모든 주소 검색 버튼에 이벤트 등록
    document.querySelectorAll('.btn-search').forEach(btn => {
      btn.addEventListener('click', function () {
        const box = btn.closest('.delivery-box');
        const zipcode = box.querySelector('.input-zipcode');
        const address1 = box.querySelectorAll('.input-full')[0];
        const address2 = box.querySelectorAll('.input-full')[1];

        openPostcode(zipcode, address1, address2);
      });
    });
  });
</script>


</body>
</html>
