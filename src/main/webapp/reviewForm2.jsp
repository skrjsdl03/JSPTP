<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
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
		ReviewDTO rDto = reDao.getReviewById(r_id);
		
		ProductDTO pDto = pDao.getProductByReview(r_id);
		String size = pDao.getProductByReviewSize(r_id);
		Vector<String> pilist = pDao.getProductByReviewImg(r_id);
		
        DecimalFormat formatter = new DecimalFormat("#,###");

        String price = formatter.format(pDto.getP_price()) + "원";
        
        SimpleDateFormat SDF_DATE = new SimpleDateFormat("yyyy-MM-dd");
        String now = SDF_DATE.format(new Date());
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

	<section2 class="content2">
	<h3>REVIEW</h3>
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

			<div class="form-container">
				<form action="submitQna.jsp" method="post"
					enctype="multipart/form-data" id="writeReviewForm">
					
				<table class="notice-table">
					<tr>
						<td class="pdInfo">
							<div class="product-box">
								<img src="<%=pilist.get(0)%>" alt="<%=pDto.getP_name()%>" class="product-img">
								<div class="product-info">
									<strong><%=pDto.getP_name()%></strong><br> <%=pDto.getP_color()%><br><%=size%>
								</div>
							</div>
						</td>
						<td class="date"><%=now%><br><%=price%>
						</td>
					</tr>
				</table>
					
					<div class="star-rating" id="starRating">
						<span class="star" data-value="1">☆</span>
						<span class="star" data-value="2">☆</span>
						<span class="star" data-value="3">☆</span>
						<span class="star" data-value="4">☆</span>
						<span class="star" data-value="5">☆</span>
					</div> 
					
					<div class="rating-text">
						별점을 입력해주세요.
					</div>
					<input type="hidden" name="rating" id="ratingInput" />
					

<script>
  const stars = document.querySelectorAll('.star');
  const ratingInput = document.getElementById('ratingInput');
  let currentRating = 0;

  stars.forEach((star) => {
    star.addEventListener('click', () => {
      currentRating = parseInt(star.getAttribute('data-value'));
      updateStars();
      ratingInput.value = currentRating;
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
<textarea name="content" id="content" name="content" rows="6" placeholder="내용을 입력해주세요." required></textarea>

<label>사진 첨부</label>

<!-- 클릭용 박스 -->
<%-- <% for(ReviewImgDTO imgDto : rilist) { %>
    <div style="position: relative; width: 100px; height: 100px;">
        <img src="review_images/<%= imgDto.getRi_url()%>" alt="리뷰 이미지" 
             style="width: 100%; height: 100%; object-fit: cover; border-radius: 6px;">
             <button style="position: absolute; top: -5px; right: -5px; background: red; color: #fff; border: none; border-radius: 50%; width: 20px; height: 20px; cursor: pointer;">✕</button>
    </div>
<% } %> --%>
<label for="file-upload" class="photo-box" id="photo-box">＋</label>
<input type="file" id="file-upload" name="files" accept="image/*" multiple style="display: none;">

<!-- 파일명 표시 -->
<!-- <div id="file-names" style="font-size: 14px; margin-top: 8px; color: #444;"></div> -->

<!-- 미리보기 + 삭제버튼 -->
<!-- <div class="preview-wrapper" id="preview-wrapper" style="display: flex; flex-wrap: wrap; gap: 10px; margin-top: 10px;"></div> -->


<div class="preview-wrapper" id="preview-wrapper" 
     style="display: grid; grid-template-columns: repeat(5, 100px); gap: 10px; margin-top: 10px;">
</div>




<script>
	const fileInput = document.getElementById('file-upload');
	const previewWrapper = document.getElementById('preview-wrapper');
	const photoBox = document.getElementById('photo-box');
	const MAX_FILES = 5;
/* 	const fileNames = document.getElementById('file-names'); */

	fileInput.addEventListener('change', function () {
		const files = Array.from(this.files);
		
		// 개수 제한
		if (files.length > MAX_FILES) {
			alert("최대 5장까지만 업로드할 수 있어요.");
			// input 초기화
			fileInput.value = '';
			return;
		}
		
		previewWrapper.innerHTML = '';
/* 		fileNames.innerHTML = ''; */

		if (files.length > 0) {
			photoBox.style.display = 'none';

			files.forEach((file, index) => {
/* 				// 파일 이름 출력
				const fileNameElem = document.createElement('p');
				fileNameElem.innerText = file.name;
				fileNames.appendChild(fileNameElem); */

				// 이미지 미리보기
				const reader = new FileReader();
				reader.onload = function (e) {
					const previewBox = document.createElement('div');
					previewBox.style.position = 'relative';
					previewBox.style.width = '100px';
					previewBox.style.height = '100px';

					const img = document.createElement('img');
					img.src = e.target.result;
					img.style.width = '100%';
					img.style.height = '100%';
					img.style.objectFit = 'cover';
					img.style.borderRadius = '6px';

					const deleteBtn = document.createElement('button');
					deleteBtn.innerText = '✕';
					deleteBtn.style.position = 'absolute';
					deleteBtn.style.top = '-5px';
					deleteBtn.style.right = '-5px';
					deleteBtn.style.background = 'red';
					deleteBtn.style.color = '#fff';
					deleteBtn.style.border = 'none';
					deleteBtn.style.borderRadius = '50%';
					deleteBtn.style.width = '20px';
					deleteBtn.style.height = '20px';
					deleteBtn.style.cursor = 'pointer';
					deleteBtn.setAttribute('data-index', index);

					deleteBtn.addEventListener('click', () => {
						files.splice(index, 1);
						// 재할당해서 다시 트리거
						const dataTransfer = new DataTransfer();
						files.forEach(f => dataTransfer.items.add(f));
						fileInput.files = dataTransfer.files;
						fileInput.dispatchEvent(new Event('change'));
					});

					previewBox.appendChild(img);
					previewBox.appendChild(deleteBtn);
					previewWrapper.appendChild(previewBox);
				};
				reader.readAsDataURL(file);
			});
		} else {
			photoBox.style.display = 'flex';
		}
	});
</script>
						
						
<!-- 					<label>사진 첨부</label>

					클릭용 박스
					<label for="file-upload" class="photo-box" id="photo-box">＋</label>
					<input type="file" id="file-upload" name="file" accept="image/*" style="display: none;">

					파일명 표시
					<p id="file-name" style="font-size: 14px; margin-top: 8px; color: #444;"></p>

					미리보기 + 삭제버튼
					<div class="preview-wrapper" id="preview-wrapper" style="display: none;">
						<img id="preview-image" />
						<button type="button" class="delete-btn" id="delete-btn">✕</button>
					</div>

					<script>
						const fileInput = document
								.getElementById('file-upload');
						const previewImage = document
								.getElementById('preview-image');
						const previewWrapper = document
								.getElementById('preview-wrapper');
						const photoBox = document.getElementById('photo-box');
						const deleteBtn = document.getElementById('delete-btn');
						const fileNameText = document
								.getElementById('file-name');

						fileInput.addEventListener('change', function() {
							const file = this.files[0];
							if (file) {
								// 파일명 표시
								fileNameText.innerText = file.name;

								// 미리보기 표시
								const reader = new FileReader();
								reader.onload = function(e) {
									previewImage.src = e.target.result;
									previewWrapper.style.display = 'block';
									photoBox.style.display = 'none';
								};
								reader.readAsDataURL(file);
							}
						});

						deleteBtn.addEventListener('click', function() {
							fileInput.value = '';
							fileNameText.innerText = '';
							previewWrapper.style.display = 'none';
							photoBox.style.display = 'flex';
						});
					</script> -->
					<input type="hidden" name="r_id" value="<%=r_id%>">
					<input type="hidden" name="r_id" value="<%=r_id%>">
					
				</form>
			</div>
			<div class="write-btn-wrapperBtn">
				<button type="button" class="write-btn" onclick="insertReview()">작성하기</button>
			</div>

			<div class="footer-bottom">
				<p>2025&copy;everyWEAR</p>
			</div>

		</section>
	</div>
	

	
	<script>
		function insertReview(){
			const rating = document.getElementById("ratingInput");
			const content = document.getElementById("content");
			
			if(!rating.value){
				alert("별점을 매개주십시오.");
				return;
			}
			if(!content.value){
				alert("리뷰 글을 작성하십시오.");
				return;
			}
			document.getElementById("writeReviewForm").submit();
		}
	</script>

</body>