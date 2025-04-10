<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>회원 관리 | everyWEAR</title>
  <link rel="icon" type="image/png" href="images/fav-icon.png">
  <link rel="stylesheet" href="css/admin_main.css">
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
  <h2 style="margin: 0;">회원 관리</h2>
  <div class="filter-group">
    <select class="custom-select" id="grade-filter">
      <option value="전체">전체 등급</option>
      <option value="그린">그린</option>
      <option value="오렌지">오렌지</option>
      <option value="퍼플">퍼플</option>
      <option value="에메랄드">에메랄드</option>
      <option value="블랙">블랙</option>
    </select>

    <select class="custom-select" id="status-filter">
      <option value="전체">전체 상태</option>
      <option value="정지 회원">정지 회원</option>
      <option value="휴면 회원">휴면 회원</option>
      <option value="차단 회원">차단 회원</option>
    </select>
  </div>
</div>

    <table class="order-table">
      <thead>
        <tr>
          <th><input type="checkbox" id="check-all"></th>
          <th>No.</th>
          <th>이름</th>
          <th>ID/이메일</th>
          <th>등급</th>
          <th>상태</th>
          <th>가입일</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><input type="checkbox" class="check-item"></td>
          <td>1</td>
          <td>홍길동</td>
          <td>hong@example.com</td>
          <td>
            <select class="grade-select">
              <option>그린</option>
              <option>오렌지</option>
              <option>퍼플</option>
              <option>에메랄드</option>
              <option>블랙</option>
            </select>
          </td>
          <td>
            <select class="state-select">
              <option>---</option>
              <option>정지 회원</option>
              <option>휴면 회원</option>
              <option style="color: red;">차단 회원</option>
            </select>
          </td>
          <td>2024-11-15</td>
        </tr>
      </tbody>
    </table>
    
    <div class="order-footer">
	  <button class="delete-button" onclick="confirmDelete()">삭제</button>
	  <button class="save-button">저장</button>
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
// 전체 체크박스 선택
document.getElementById("check-all").addEventListener("change", function () {
  const isChecked = this.checked;
  document.querySelectorAll(".check-item").forEach(cb => cb.checked = isChecked);
});

// 삭제 기능
function confirmDelete() {
  const selected = document.querySelectorAll(".check-item:checked");
  if (selected.length === 0) {
    alert("삭제할 회원을 선택해주세요.");
    return;
  }

  if (confirm("선택한 회원을 삭제하시겠습니까?")) {
    selected.forEach(cb => {
      const row = cb.closest("tr");
      if (row) row.remove();
    });
    alert("선택한 회원이 삭제되었습니다.");
  }
}

// 필터링 기능
document.getElementById("grade-filter").addEventListener("change", filterTable);
document.getElementById("status-filter").addEventListener("change", filterTable);

function filterTable() {
  const selectedGrade = document.getElementById("grade-filter").value;
  const selectedStatus = document.getElementById("status-filter").value;

  const rows = document.querySelectorAll(".order-table tbody tr");

  rows.forEach(row => {
    const gradeSelect = row.querySelector(".grade-select");
    const statusSelect = row.querySelector(".state-select");

    const gradeValue = gradeSelect ? gradeSelect.value : "";
    const statusValue = statusSelect ? statusSelect.value : "";

    const matchGrade = (selectedGrade === "전체" || gradeValue === selectedGrade);
    const matchStatus = (selectedStatus === "전체" || statusValue === selectedStatus);

    row.style.display = (matchGrade && matchStatus) ? "" : "none";
  });
}
</script>

</body>


</html>
