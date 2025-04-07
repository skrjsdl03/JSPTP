<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>에브리웨어 | everyWEAR</title>
<link rel="icon" type="image/png" href="images/fav-icon.png">
<link rel="stylesheet" type="text/css" href="css/Q&A.css?v=123">
</head>
<body>

	<%@ include file="includes/boardHeader.jsp"%>

	<section2 class="content2">
	<h3>Q&A</h3>
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
			<table class="notice-table">
				<tr>
					<td>&#128274; 배송관련 문의입니다.</td>
					<td>답변 예정</td>
					<td>2025-03-30</td>
					<td>배송 문의</td>
				</tr>
				<tr>
					<td>&#128274; 제품 상세 문의입니다.</td>
					<td>답변 완료</td>
					<td>2025-03-30</td>
					<td>제품 상세 문의</td>
				</tr>
				<tr>
					<td>&#128274; 제품 상세 문의입니다.</td>
					<td>답변 완료</td>
					<td>2025-03-30</td>
					<td>제품 상세 문의</td>
				</tr>
			</table>

			<div class="write-btn-wrapper">
				<button class="write-btn" onclick="location.href='writeForm.jsp'">작성하기</button>
			</div>


			<div class="pagination">
				<span>Prev</span> <span class="active">1</span> <span>2</span> <span>3</span>
				<span>4</span> <span>5</span> <span>Next</span>
			</div>

			<div class="footer-bottom">
				<p>2025&copy;everyWEAR</p>
			</div>
		</section>
	</div>

</body>