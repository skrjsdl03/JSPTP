<!-- admin_order_delivery.css --> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>주문 취소/환불 | everyWEAR</title> 
  <link rel="icon" type="image/png" href="images/fav-icon.png">
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
</header>
<main>
  <div class="container">
<div class="order-header">
  <h2>주문 취소/환불</h2> 
<div class="filter-group">
  <input type="text" id="search-input" placeholder="회원ID 입력" class="search-input">
  <button class="search-button" onclick="applyFilters()">검색</button>

  <!-- 환불 상태 필터 -->
  <select class="custom-select" id="status-filter" onchange="applyFilters()">
    <option value="all">전체</option>
    <option value="request">환불 요청</option>
    <option value="completed">환불 완료</option>
  </select>

  <!-- 정렬 드롭다운 -->
  <select class="custom-select" id="sort-select" onchange="applyFilters()">
    <option value="latest">최신순</option>
    <option value="oldest">오래된 순</option>
  </select>
</div>
</div>
	<table class="order-table">
  <thead>
    <tr>
      <th><input type="checkbox" id="check-all"></th>
      <th>No.</th>
      <th>회원ID</th>
      <th>환불금액</th>
      <th>환불 수량</th>
      <th>환불상태</th>
      <th>환불일시</th>
      <th>환불사유</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><input type="checkbox" class="check-item"></td>
      <td>1</td>
      <td>user01</td>
      <td>25,000원</td>
      <td>2</td>
      <td>
	    <select class="status-select">
	      <option value="request" selected>환불 요청</option>
	      <option value="completed">환불 완료</option>
	    </select>
 	 </td>        <td>2025-04-10 14:32</td>
      <td>상품 불량</td>
    </tr>
    <tr>
      <td><input type="checkbox" class="check-item"></td>
      <td>2</td>
      <td>user02</td>
      <td>15,000원</td>
      <td>1</td>
      <td>
	    <select class="status-select">
	      <option value="request">환불 요청</option>
	      <option value="completed" selected>환불 완료</option>
	    </select>
 	 </td>        <td>2025-04-09 09:10</td>
      <td>단순 변심</td>
    </tr>
    <tr>
      <td><input type="checkbox" class="check-item"></td>
      <td>3</td>
      <td>user03</td>
      <td>30,000원</td>
      <td>3</td>
      <td>
	    <select class="status-select">
	      <option value="request" selected>환불 요청</option>
	      <option value="completed">환불 완료</option>
	    </select>
 	 </td>     
      <td>2025-04-08 17:20</td>
      <td>사이즈 불만족</td>
    </tr>
  </tbody>
</table>

<div class="order-footer">
  <button class="cancel-button" onclick="cancelSelectedOrders()">주문 취소</button>
  <button class="save-button" onclick="saveRefundStatusChanges()">저장</button>
</div>

<div class="pagination-container">
  <ul class="pagination">
    <li><a href="#">Prev</a></li>
    <li class="active"><a href="#">1</a></li>
    <li><a href="#">2</a></li>
    <li><a href="#">3</a></li>
    <li><a href="#">4</a></li>
    <li><a href="#">5</a></li>
    <li><a href="#">Next</a></li>
  </ul>
</div>

  </div>
</main>

<script>
  // 상단 체크박스를 클릭하면 모든 하위 체크박스 토글
  document.getElementById("check-all").addEventListener("change", function () {
    const isChecked = this.checked;
    const checkboxes = document.querySelectorAll(".check-item");
    checkboxes.forEach(cb => cb.checked = isChecked);
  });
  // 상단 전체 선택 기능
   document.getElementById("check-all").addEventListener("change", function () {
    const isChecked = this.checked;
    document.querySelectorAll(".check-item").forEach(cb => cb.checked = isChecked);
  });

   function applyFilters() {
	   const keyword = document.getElementById("search-input").value.trim().toLowerCase();
	   const sortOption = document.getElementById("sort-select").value;
	   const statusOption = document.getElementById("status-filter").value;

	   const rows = Array.from(document.querySelectorAll(".order-table tbody tr"));

	   rows.forEach(row => {
	     const userId = row.children[2].textContent.toLowerCase();
	     const statusSelect = row.querySelector(".status-select");
	     const selectedStatus = statusSelect ? statusSelect.value : "";

	     const matchKeyword = keyword === "" || userId.includes(keyword);
	     const matchStatus =
	       statusOption === "all" ||
	       (statusOption === "request" && selectedStatus === "request") ||
	       (statusOption === "completed" && selectedStatus === "completed");

	     row.style.display = (matchKeyword && matchStatus) ? "" : "none";
	   });

	   const visibleRows = rows.filter(row => row.style.display !== "none");
	   visibleRows.sort((a, b) => {
	     const dateA = new Date(a.children[6].textContent);
	     const dateB = new Date(b.children[6].textContent);
	     return sortOption === "latest" ? dateB - dateA : dateA - dateB;
	   });

	   const tbody = document.querySelector(".order-table tbody");
	   visibleRows.forEach(row => tbody.appendChild(row));
	 }
  
  const searchInput = document.getElementById("search-input");
  const defaultPlaceholder = "회원ID 입력";

  searchInput.addEventListener("focus", function () {
    this.setAttribute("placeholder", "");
  });

  searchInput.addEventListener("blur", function () {
    if (this.value.trim() === "") {
      this.setAttribute("placeholder", defaultPlaceholder);
    }
  });
  
  const statusOption = document.getElementById("status-filter").value;
  const refundStatus = row.children[5].textContent.trim(); // 환불 상태 텍스트

  const matchStatus = statusOption === "all" ||
    (statusOption === "request" && refundStatus === "환불 요청") ||
    (statusOption === "completed" && refundStatus === "환불 완료");

  function cancelSelectedOrders() {
	  const selected = document.querySelectorAll('.check-item:checked');

	  if (selected.length === 0) {
	    alert("주문을 선택해주세요.");
	    return;
	  }

	  if (!confirm("선택한 주문을 취소하시겠습니까?")) return;

	  selected.forEach(cb => {
	    const row = cb.closest("tr");
	    if (row) {
	      row.style.backgroundColor = "#ffe6e6"; // 시각 효과
	      row.style.textDecoration = "line-through";
	      cb.disabled = true;
	    }
	  });

	  alert("주문이 취소되었습니다.");
	}
  
  function saveRefundStatusChanges() {
	  const rows = document.querySelectorAll(".order-table tbody tr");
	  const changedData = [];

	  rows.forEach(row => {
	    const checkbox = row.querySelector(".check-item");
	    if (checkbox.checked) {
	      const userId = row.children[2].textContent;
	      const refundStatus = row.querySelector(".status-select").value;

	      changedData.push({ userId, refundStatus });
	    }
	  });

	  if (changedData.length === 0) {
	    alert("변경할 주문을 선택해주세요.");
	    return;
	  }

	  console.log("변경 내용:", changedData);
	  alert("변경된 환불 상태가 저장되었습니다.");
	  // 실제 저장 로직은 Ajax로 백엔드 서블릿 또는 JSP에 전달 필요
	}

</script>

</body>
</html>