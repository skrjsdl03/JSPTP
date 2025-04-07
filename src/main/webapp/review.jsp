<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>에브리웨어 | everyWEAR</title>
<link rel="icon" type="image/png" href="images/fav-icon.png">
<link rel="stylesheet" type="text/css" href="css/review.css?v=123">
</head>
<body>

	<%@ include file="includes/boardHeader.jsp"%>

	<section2 class="content2">
	<h3>리뷰</h3>
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
					<td>
						<div class="product-box">
							<img src="images/review1.jpg" alt="ARCH LOGO VARSITY JACKET"
								class="product-img">
							<div class="product-info">
								<strong>ARCH LOGO VARSITY JACKET</strong><br> NAVY<br>
								마음에 들어요
							</div>
						</div>
					</td>
					<td>★★★★☆</td>
					<td>2025-03-30</td>
				</tr>
				<tr>
					<td>
						<div class="product-box">
							<img src="images/review1.jpg" alt="ARCH LOGO VARSITY JACKET"
								class="product-img">
							<div class="product-info">
								<strong>ARCH LOGO VARSITY JACKET</strong><br> NAVY<br>
								마음에 들어요
							</div>
						</div>
					</td>
					<td>★★★★☆</td>
					<td>2025-03-30</td>
				</tr>
				<tr>
					<td>
						<div class="product-box">
							<img src="images/review1.jpg" alt="ARCH LOGO VARSITY JACKET"
								class="product-img">
							<div class="product-info">
								<strong>ARCH LOGO VARSITY JACKET</strong><br> NAVY<br>
								마음에 들어요
							</div>
						</div>
					</td>
					<td>★★★★☆</td>
					<td>2025-03-30</td>
				</tr>
			</table>


			<div class="write-btn-wrapper">
				<button class="write-btn" onclick="location.href='writeForm.jsp'">작성하기</button>
			</div>

			<div class="pagination" id="pagination">
				<span class="page-nav">Prev</span>
  			<span class="page-num active">1</span>
 				<span class="page-num">2</span>
  			<span class="page-num">3</span>
  			<span class="page-num">4</span>
  			<span class="page-num">5</span>
  			<span class="page-nav">Next</span>
			</div>

			<script>
  			// 페이지 숫자 클릭 시 active 클래스 토글
  			const pageNums = document.querySelectorAll(".page-num");

  			pageNums.forEach((el) => {
    		el.addEventListener("click", function () {
      	document.querySelector(".page-num.active")?.classList.remove("active");
      	el.classList.add("active");
    		});
  			});
			</script>

			<div class="footer-bottom">
				<p>2025&copy;everyWEAR</p>
			</div>
		</section>
	</div>

</body>