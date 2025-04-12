<!-- admin_order_list.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>주문 내역 조회 | everyWEAR</title>
  <link rel="icon" type="image/png" href="images/fav-icon.png">
  <link rel="stylesheet" href="css/admin_order.css">
</head>
<body>
<jsp:include page="includes/admin_header.jsp" />
<main>
  <div class="container">
<div class="order-header">
  <h2>주문 내역 조회</h2>
  <div class="filter-group">
<input type="text" id="search-input" placeholder="주문번호/ID/상품명 입력" class="search-input">
    <button class="search-button" onclick="applyFilters()">검색</button>
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
	      <th>주문번호</th>
	      <th>주문회원ID</th>
	      <th>상품명</th>
	      <th>날짜</th>
	    </tr>
	  </thead>
	  <tbody>
	    <c:forEach var="i" begin="1" end="9">
	      <tr>
	        <td><input type="checkbox" class="check-item"></td>
	        <td>${i}</td>
	        <td>ORD20250411${i}</td>
	        <td>user${i}</td>
	        <td>예시 상품명 ${i}</td>
	        <td>2025-04-11</td>
	      </tr>
	    </c:forEach>
	  </tbody>
	</table>
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
    const rows = Array.from(document.querySelectorAll(".order-table tbody tr"));

    // 검색 필터
    rows.forEach(row => {
      const userId = row.children[3].textContent.toLowerCase();
      const product = row.children[4].textContent.toLowerCase();
      const match = userId.includes(keyword) || product.includes(keyword);
      row.style.display = match ? "" : "none";
    });

    // 정렬 처리
    const visibleRows = rows.filter(row => row.style.display !== "none");
    visibleRows.sort((a, b) => {
      const dateA = new Date(a.children[5].textContent);
      const dateB = new Date(b.children[5].textContent);
      return sortOption === "latest" ? dateB - dateA : dateA - dateB;
    });

    const tbody = document.querySelector(".order-table tbody");
    visibleRows.forEach(row => tbody.appendChild(row)); // 정렬된 순서로 재배치
  }
  const searchInput = document.getElementById("search-input");
  const defaultPlaceholder = "주문번호/ID/상품명 입력";

  searchInput.addEventListener("focus", function () {
    this.setAttribute("placeholder", "");
  });

  searchInput.addEventListener("blur", function () {
    if (this.value.trim() === "") {
      this.setAttribute("placeholder", defaultPlaceholder);
    }
  });
</script>

</body>
</html>
