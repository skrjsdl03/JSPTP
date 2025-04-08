<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>에브리웨어 | everyWEAR</title>
<link rel="icon" type="image/png" href="images/fav-icon.png">
<link rel="stylesheet" type="text/css" href="css/Q&A.css?v=578">
</head>
<body>

	<%@ include file="includes/boardHeader.jsp"%>

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
					enctype="multipart/form-data">
					
					<div class="star-rating" id="starRating">
  					<span class="star" data-value="1">☆</span>
  					<span class="star" data-value="2">☆</span>
  					<span class="star" data-value="3">☆</span>
  					<span class="star" data-value="4">☆</span>
  					<span class="star" data-value="5">☆</span>
					</div>
					<div class="rating-text">별점을 입력해주세요.</div>

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
					<textarea name="content" id="content" rows="6"
						placeholder="내용을 입력해주세요." required></textarea>

					<label>사진 첨부</label>

					<!-- 클릭용 박스 -->
					<label for="file-upload" class="photo-box" id="photo-box">＋</label>
					<input type="file" id="file-upload" name="file" accept="image/*"
						style="display: none;">

					<!-- 파일명 표시 -->
					<p id="file-name"
						style="font-size: 14px; margin-top: 8px; color: #444;"></p>

					<!-- 미리보기 + 삭제버튼 -->
					<div class="preview-wrapper" id="preview-wrapper"
						style="display: none;">
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
					</script>
					
				</form>
			</div>

			<div class="write-btn-wrapper">
				<button class="write-btn">작성하기</button>
			</div>

			<div class="footer-bottom">
				<p>2025&copy;everyWEAR</p>
			</div>

		</section>
	</div>

</body>