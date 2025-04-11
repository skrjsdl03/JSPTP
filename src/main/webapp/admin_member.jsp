<!-- admin_member.jsp -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>회원 목록 조회 | everyWEAR</title>
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
  <h2 style="margin: 0;">회원 목록 조회</h2>
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
	      <th>회원등급</th>
	      <th>계정상태</th>
	      <th>추천인</th>
	      <th>포인트</th>
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
		  	<span class="grade-label ${member.grade}">${member.gradeName}</span>
		  </td>		  
		  <td><span class="status-label default">---</span></td>
		  <td>3</td>
		  <td>1,000</td>
		  <td>2024-11-15</td>
		</tr>
		<tr>
		  <td><input type="checkbox" class="check-item"></td>
		  <td>2</td>
		  <td>김영희</td>
		  <td>young@example.com</td>
		  <td>
		  	<span class="grade-label ${member.grade}">${member.gradeName}</span>
		  </td>
		  <td><span class="status-label dormant">휴면 회원</span></td>
		  <td>0</td>
		  <td>2,500</td>
		  <td>2024-10-20</td>
		</tr>
		<tr>
		  <td><input type="checkbox" class="check-item"></td>
		  <td>3</td>
		  <td>박철수</td>
		  <td>cheol@example.com</td>
		  <td>
		  	<span class="grade-label ${member.grade}">${member.gradeName}</span>
		  </td>
		  <td><span class="status-label suspended">정지 회원</span></td>
		  <td>1</td>
		  <td>900</td>
		  <td>2024-08-10</td>
		</tr>
		<tr>
		  <td><input type="checkbox" class="check-item"></td>
		  <td>4</td>
		  <td>이수진</td>
		  <td>sujin@example.com</td>
		  <td>
		  	<span class="grade-label ${member.grade}">${member.gradeName}</span>
		  </td>
		  <td><span class="status-label banned">차단 회원</span></td>
		  <td>2</td>
		  <td>3,000</td>
		  <td>2023-12-01</td>
		</tr>
	</tbody>
        <!-- 이후 회원 반복 출력 -->
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
  document.getElementById("check-all").addEventListener("change", function() {
    const isChecked = this.checked;
    const checkboxes = document.querySelectorAll(".check-item");
    checkboxes.forEach(function(cb) {
      cb.checked = isChecked;
    });
  });
  
  document.getElementById("check-all").addEventListener("change", function() {
	    const isChecked = this.checked;
	    const checkboxes = document.querySelectorAll(".check-item");
	    checkboxes.forEach(cb => cb.checked = isChecked);
	  });

  const gradeSelect = document.getElementById("grade-filter");
  const statusSelect = document.getElementById("status-filter");

  function applyFilters() {
    const selectedGrade = gradeSelect.value;
    const selectedStatus = statusSelect.value;

    const rows = document.querySelectorAll(".order-table tbody tr");

    rows.forEach(row => {
      const gradeText = row.querySelector("td:nth-child(5) span")?.textContent.trim();
      const statusText = row.querySelector("td:nth-child(6) span")?.textContent.trim();

      const matchGrade = selectedGrade === "전체" || gradeText === selectedGrade;
      const matchStatus = selectedStatus === "전체" || statusText === selectedStatus;

      if (matchGrade && matchStatus) {
        row.style.display = "";
      } else {
        row.style.display = "none";
      }
    });
  }

  gradeSelect.addEventListener("change", applyFilters);
  statusSelect.addEventListener("change", applyFilters);
  
</script>

</body>
</html>
