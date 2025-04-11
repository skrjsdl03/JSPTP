<!-- admin_order_delivery.jsp --> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>배송 상태 변경 | everyWEAR</title> 
  <link rel="icon" type="image/png" href="images/fav-icon.png">
  <link rel="stylesheet" href="css/admin_order.css">
</head>
<body>
<jsp:include page="includes/admin_header.jsp" />
<main>
  <div class="container">
<div class="order-header">
  <h2>배송 상태 변경</h2> 
<div class="filter-group">
  <input type="text" id="search-input" placeholder="송장번호 입력" class="search-input">
  <button class="search-button" onclick="applyFilters()">검색</button>

  <!-- 배송 상태 필터 -->
	<select class="custom-select" id="status-filter" onchange="applyFilters()">
	  <option value="all">전체</option>
	  <option value="ready">배송준비중</option>
	  <option value="shipping">배송중</option>
	  <option value="delivered">배송완료</option>
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
	    <th>배송지명</th>
	    <th>송장번호</th>
	    <th>택배사명</th>
	    <th>배송상태</th>
	    <th>배송시작일</th>
	    <th>배송완료일</th>
	    <th>배송메모</th>
	  </tr>
	</thead>

<tbody>
  <tr>
	  <td><input type="checkbox" class="check-item"></td>
	  <td>1</td>
	  <td>서울 강남구 논현로 123</td>
	  <td>1234567890</td>
	  <td>CJ대한통운</td>
	  <td>
		  <select class="status-select">
		    <option value="ready" selected>배송준비중</option>
		    <option value="shipping">배송중</option>
		    <option value="delivered">배송완료</option>
		  </select>
		</td>

	  <td>2025-04-11</td>
	  <td>2025-04-13</td>
	  <td>부재 시 경비실</td>
	</tr>

</tbody>

</table>

<div class="order-footer">
  <button class="save-button" onclick="saveStatusChanges()">저장</button>
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
	     const keywordText = row.children[3].textContent.toLowerCase(); // 송장번호 또는 기타 기준
	     const statusSelect = row.querySelector(".status-select");
	     const selectedStatus = statusSelect ? statusSelect.value : "";

	     const matchKeyword = keyword === "" || keywordText.includes(keyword);
	     const matchStatus = statusOption === "all" || selectedStatus === statusOption;

	     row.style.display = (matchKeyword && matchStatus) ? "" : "none";
	   });

	   // 정렬 처리
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
  const defaultPlaceholder = "송장번호 입력";

  searchInput.addEventListener("focus", function () {
    this.setAttribute("placeholder", "");
  });

  searchInput.addEventListener("blur", function () {
    if (this.value.trim() === "") {
      this.setAttribute("placeholder", defaultPlaceholder);
    }
  });
  
  const statusOption = document.getElementById("status-filter").value;
  const refundStatus = row.children[5].textContent.trim(); // 배송 상태 텍스트

  const matchStatus =
	  statusOption === "all" ||
	  (statusOption === "ready" && selectedStatus === "ready") ||
	  (statusOption === "shipping" && selectedStatus === "shipping") ||
	  (statusOption === "delivered" && selectedStatus === "delivered");

  function saveStatusChanges() {
	  alert("변경된 배송 상태가 저장되었습니다.");
	  // 실제 저장 로직은 Ajax 또는 폼 제출로 구현 가능
	}

</script>

</body>
</html>