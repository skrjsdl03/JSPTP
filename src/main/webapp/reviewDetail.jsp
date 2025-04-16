<%@page import="DTO.ProductImgDTO"%>
<%@page import="DTO.ProductDTO"%>
<%@page import="DTO.ReviewImgDTO"%>
<%@page import="java.util.List"%>
<%@page import="DTO.ReviewDTO"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<jsp:useBean id="reDao" class="DAO.ReviewDAO"/>
<jsp:useBean id="pDao" class="DAO.ProductDAO"/>
<%
		String userId = (String)session.getAttribute("id");
		String userType = (String)session.getAttribute("userType");
		if(userId == null || userId == ""){
			// 현재 페이지 경로를 얻기 위한 코드
			String fullUrl = request.getRequestURI();
			String queryString = request.getQueryString();
			if (queryString != null) {
				fullUrl += "?" + queryString;
			}
		
			response.sendRedirect("login.jsp?redirect=" + java.net.URLEncoder.encode(fullUrl, "UTF-8"));
			return;
		}
		
		int r_id = Integer.parseInt(request.getParameter("r_id"));
		if(r_id == 0){
		}
		ReviewDTO rDto = reDao.getReviewById(r_id);
		List<ReviewImgDTO> rilist = reDao.getReviewImages(r_id);
		
		ProductDTO pDto = pDao.getProductByReview(r_id);
		String size = pDao.getProductByReviewSize(r_id);
		
		String rating = "";
		for(int j = 0; j<rDto.getR_rating(); j++){
			rating += "★";
			if(j == rDto.getR_rating() -1){
				for(int k = 0; k< (5-rDto.getR_rating()); k++)
					rating += "☆";
			}
		}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>에브리웨어 | everyWEAR</title>
<link rel="icon" type="image/png" href="images/fav-icon.png">
<link rel="stylesheet" type="text/css" href="css/Q&A.css?v=578">
</head>
<body>

	<%@ include file="includes/header.jsp"%>

	<section class="content2">
	<h3>REVIEW</h3>
	</section>

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

			<div class="form-container">
				<form action="submitQna.jsp" method="post"
					enctype="multipart/form-data">
					
				<table class="notice-table">
					<tr>
						<td class="pdInfo">
							<div class="product-box">
								<img src="images/review1.jpg" alt="ARCH LOGO VARSITY JACKET"
									class="product-img">
								<div class="product-info">
									<strong><%=pDto.getP_name()%></strong><br> <%=pDto.getP_color()%><br>
								</div>
							</div>
						</td>
						<td class="date"><%=rDto.getCreated_at()%><br><%=rating%>
						</td>
					</tr>
				</table>
					
					
					<div class="star-rating" id="starRating">
					<%for(int i = 1; i<=rDto.getR_rating(); i++){ %>
						<span class="star" data-value="<%=i%>">★</span>
					<%} %>
					<%for(int i = rDto.getR_rating(); i<5;i++){ %>
						<span class="star" data-value="<%=i+1%>">☆</span>
					<%} %>
					</div>
					<!-- <div class="rating-text">별점을 입력해주세요.</div> -->

<script>
  const stars = document.querySelectorAll('.star');
  let currentRating = 0;

  stars.forEach((star) => {
    star.addEventListener('click', () => {
      currentRating = parseInt(star.getAttribute('data-value'));
      updateStars();
    });

    star.addEventListener('mouseover', () => {
      const hoverValue = parseInt(star.getAttribute('data-value'));
      updateStars(hoverValue);
    });

    star.addEventListener('mouseleave', () => {
      updateStars();
    });
  });

  function updateStars(tempRating = currentRating) {
    stars.forEach((star) => {
      const value = parseInt(star.getAttribute('data-value'));
      star.textContent = value <= tempRating ? '★' : '☆';
    });
  }
</script>

				<label for="content">내용 *</label>
				<textarea name="content" id="content" rows="6" placeholder="내용을 입력해주세요." required><%=rDto.getR_content()%></textarea>
				
				<label>사진 첨부</label>
				
				<!-- 클릭용 박스 -->
				<div class="preview-wrapper" id="preview-wrapper" 
				     style="display: grid; grid-template-columns: repeat(5, 100px); gap: 10px; margin-top: 10px;">
				<% for(ReviewImgDTO imgDto : rilist) { %>
				    <div style="position: relative; width: 100px; height: 100px;">
				        <img src="review_images/<%= imgDto.getRi_url()%>" alt="리뷰 이미지" 
				             style="width: 100%; height: 100%; object-fit: cover; border-radius: 6px;">
				    </div>
				<% } %>
				</div>
				
				<div class="write-btn-wrapper2">
					<button class="write-btn2">작성하기</button>
				</div>
		
				</form>
			</div>

			<div class="footer-bottom">
				<p>2025&copy;everyWEAR</p>
			</div>

		</section>
	</div>

</body>