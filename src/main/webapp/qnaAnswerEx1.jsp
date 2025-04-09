<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>에브리웨어 | everyWEAR</title>
<link rel="icon" type="image/png" href="images/fav-icon.png">
<link rel="stylesheet" type="text/css" href="css/board.css?v=45354">
</head>
<body>

	<%@ include file="includes/boardHeader.jsp"%>

	<section2 class="content2">
	<h3>BOARD</h3>
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
				<tr class="important">
					<td class="title">배송관련 문의입니다.</td>
					<td class="date">2025-03-30</td>
					<td class="views">배송 문의</td>
				</tr>

				<!-- 본문 내용을 별도 tr로 처리 -->
				<tr>
					<td colspan="3" class="notice-content">
						<div class="notice-body">
							<p><strong>답변: 배송 안됩니다</strong></p><br>
							<p>배송 언제 오나요</p>
						</div>
					</td>
				</tr>
			</table>

			<div class="list-btn-wrapper">
				<button class="list-btn" onclick="window.history.back()">목록</button>
			</div>

			<!-- <div class="pagination">
				<span>Prev</span> <span class="active">1</span> <span>2</span> <span>3</span>
				<span>4</span> <span>5</span> <span>Next</span>
			</div> -->

			<div class="footer-bottom">
				<p>2025&copy;everyWEAR</p>
			</div>
		</section>
	</div>

</body>