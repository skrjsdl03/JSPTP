<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시물 관리 | everyWEAR</title>
<link rel="stylesheet" href="css/postManagement.css">
<link rel="icon" type="image/png" href="images/logo-white.png">
</head>
<body>

	<%@ include file="includes/boardHeader.jsp"%>

	<div class="user-box">
		<div class="username">정시영 님</div>
		<div class="user-info">
			<span class="label">적립금</span>
			<span class="value">25,000 ₩</span>
			<span class="label">쿠폰</span>
			<span class="value">2 개</span>
		</div>
	</div>
	<aside class="sidebar2">
		<ul>
			<li><a href="board.jsp?reload=true">회원정보 수정</a></li>
			<li><a href="FAQ.jsp">주문 내역</a></li>
			<li><a href="Q&A.jsp">장바구니</a></li>
			<li><a href="review.jsp">찜 상품</a></li>
			<li><a href="review.jsp">게시물 관리</a></li>
		</ul>
	</aside>

	<!-- 게시물 관리 본문 -->
	<div class="post-content">
		<div class="tab-wrap">
			<button class="tab-btn active" onclick="showTab('review')">리뷰</button>
			<button class="tab-btn" onclick="showTab('qna')">Q&A</button>
		</div>

		<!-- 리뷰 탭 -->
		<div class="tab-content active" id="review">
			<div class="post-item">
				<img src="images/fav-icon.png" class="post-img" alt="상품 이미지">
				<div class="post-info">
					<p class="post-title">Onitsuka Tiger Tokuten Gray</p>
					<p class="post-option">220 구매</p>
					<p class="post-text">생각보다 작아서 반치수 업하는게 좋을 듯 합니다. 착화감은 말랑하고
						이쁘네요.</p>
				</div>
				<div class="post-meta">
					<p class="post-stars">★★★★☆</p>
					<p class="post-date">2025-03-30</p>
					<div class="action-group">
						<a href="#" class="btn-edit">수정</a> <a href="#" class="btn-delete">삭제</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Q&A 탭 -->
	<div class="tab-content" id="qna">
		<div class="post-item">
			<img src="images/fav-icon.png" class="post-img" alt="상품 이미지">
			<div class="post-info">
				<p class="post-title">Arc'teryx Konseal 15 Backpack Black</p>
				<p class="post-option">one size</p>
				<p class="post-text">재입고 문의</p>
			</div>
			<div class="post-meta">
				<p class="post-status">답변 완료</p>
				<p class="post-date">2025-03-30</p>
				<div class="action-group">
					<a class="btn-delete">삭제</a>
				</div>
			</div>
		</div>
	</div>

	</div>

	<footer>
		<p>© 2025 everyWEAR</p>
	</footer>

	<script>
	function showTab(tabId) {
	  document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
	  document.querySelectorAll('.tab-content').forEach(tab => tab.classList.remove('active'));
	
	  document.querySelector(`.tab-btn[onclick*="${tabId}"]`).classList.add('active');
	  document.getElementById(tabId).classList.add('active');
	}
</script>
</body>
</html>
