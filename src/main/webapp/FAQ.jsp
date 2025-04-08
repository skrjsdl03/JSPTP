<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>에브리웨어 | everyWEAR</title>
<link rel="icon" type="image/png" href="images/fav-icon.png">
<link rel="stylesheet" type="text/css" href="css/FAQ.css?v=234564">
</head>
<body>

	<%@ include file="includes/boardHeader.jsp"%>
	
	<section2 class="content2">
		<h3>FAQ</h3>
	</section2>

	<div class="container">
		<aside class="sidebar2">
			<ul>
				<li><a href="board.jsp">BOARD</a></li>
				<li><a href="FAQ.jsp">FAQ</a></li>
				<li><a href="Q&A.jsp">Q&A</a></li>
				<li><a href="review.jsp">REVIEW</a></li>
			</ul>
		</aside>

		<section class="content">
			<table class="notice-table" id="notice-table">
				<tbody>
					<tr>
						<td class="title">상품/상품 박스가 파손되어 배송됐어요.</td>
						<td class="date">2025-03-30</td>
						<td class="views">조회수: 56</td>
					</tr>
					<tr>
						<td class="title">교환/반품 비용은 무료인가요?</td>
						<td class="date">2025-03-30</td>
						<td class="views">조회수: 56</td>
					</tr>
					<tr>
						<td class="title">반품접수는 어떻게 하나요?</td>
						<td class="date">2025-03-30</td>
						<td class="views">조회수: 56</td>
					</tr>
					<tr>
						<td class="title">배송조회는 어떻게 하나요?</td>
						<td class="date">2025-03-30</td>
						<td class="views">조회수: 56</td>
					</tr>
					<tr>
						<td class="title">언제 환불되나요?</td>
						<td class="date">2025-03-30</td>
						<td class="views">조회수: 56</td>
					</tr>
					<tr>
						<td class="title">상품/상품 박스가 파손되어 배송됐어요.</td>
						<td class="date">2025-03-30</td>
						<td class="views">조회수: 56</td>
					</tr>
					<tr>
						<td class="title">교환/반품 비용은 무료인가요?</td>
						<td class="date">2025-03-30</td>
						<td class="views">조회수: 56</td>
					</tr>
					<tr>
						<td class="title">반품접수는 어떻게 하나요?</td>
						<td class="date">2025-03-30</td>
						<td class="views">조회수: 56</td>
					</tr>
					<tr>
						<td class="title">배송조회는 어떻게 하나요?</td>
						<td class="date">2025-03-30</td>
						<td class="views">조회수: 56</td>
					</tr>
					<tr>
						<td class="title">언제 환불되나요?</td>
						<td class="date">2025-03-30</td>
						<td class="views">조회수: 56</td>
					</tr>
					<tr>
						<td class="title">상품/상품 박스가 파손되어 배송됐어요.</td>
						<td class="date">2025-03-30</td>
						<td class="views">조회수: 56</td>
					</tr>
					<tr>
						<td class="title">교환/반품 비용은 무료인가요?</td>
						<td class="date">2025-03-30</td>
						<td class="views">조회수: 56</td>
					</tr>
					<tr>
						<td class="title">반품접수는 어떻게 하나요?</td>
						<td class="date">2025-03-30</td>
						<td class="views">조회수: 56</td>
					</tr>
					<tr>
						<td class="title">배송조회는 어떻게 하나요?</td>
						<td class="date">2025-03-30</td>
						<td class="views">조회수: 56</td>
					</tr>
					<tr>
						<td class="title">언제 환불되나요?</td>
						<td class="date">2025-03-30</td>
						<td class="views">조회수: 56</td>
					</tr>
					<tr>
						<td class="title">상품/상품 박스가 파손되어 배송됐어요.</td>
						<td class="date">2025-03-30</td>
						<td class="views">조회수: 56</td>
					</tr>
					<tr>
						<td class="title">교환/반품 비용은 무료인가요?</td>
						<td class="date">2025-03-30</td>
						<td class="views">조회수: 56</td>
					</tr>
					<tr>
						<td class="title">반품접수는 어떻게 하나요?</td>
						<td class="date">2025-03-30</td>
						<td class="views">조회수: 56</td>
					</tr>
					<tr>
						<td class="title">배송조회는 어떻게 하나요?</td>
						<td class="date">2025-03-30</td>
						<td class="views">조회수: 56</td>
					</tr>
					<tr>
						<td class="title">언제 환불되나요?</td>
						<td class="date">2025-03-30</td>
						<td class="views">조회수: 56</td>
					</tr>
				</tbody>
			</table>
		
			<div class="pagination" id="pagination">
				<span>Prev</span>
				<span class="active">1</span>
				<span>2</span>
				<span>3</span>
				<span>4</span>
				<span>5</span>
				<span>Next</span>
			</div>

			<div class="footer-bottom">
				<p>2025&copy;everyWEAR</p>
			</div>
		</section>
	</div>

	<script>
  document.addEventListener("DOMContentLoaded", function () {
    const rowsPerPage = 10;
    const table = document.getElementById("notice-table");
    const rows = table.querySelectorAll("tbody tr");
    const totalPages = Math.ceil(rows.length / rowsPerPage);
    const pagination = document.getElementById("pagination");

    let currentPage = 1;

    function showPage(page) {
      const start = (page - 1) * rowsPerPage;
      const end = start + rowsPerPage;

      rows.forEach((row, index) => {
        row.style.display = index >= start && index < end ? "" : "none";
      });

      updatePagination(page);
    }

    function updatePagination(activePage) {
      pagination.innerHTML = "";

      // Prev 버튼
      const prev = document.createElement("span");
      prev.textContent = "Prev";
      prev.onclick = () => {
        if (currentPage > 1) showPage(--currentPage);
      };
      pagination.appendChild(prev);

      // 페이지 번호
      for (let i = 1; i <= totalPages; i++) {
        const span = document.createElement("span");
        span.textContent = i;
        if (i === activePage) span.classList.add("active");
        span.onclick = () => {
          currentPage = i;
          showPage(currentPage);
        };
        pagination.appendChild(span);
      }

      // Next 버튼
      const next = document.createElement("span");
      next.textContent = "Next";
      next.onclick = () => {
        if (currentPage < totalPages) showPage(++currentPage);
      };
      pagination.appendChild(next);
    }

    // 초기 페이지 로드
    showPage(currentPage);
  });
</script>

</body>