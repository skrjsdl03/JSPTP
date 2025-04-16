<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>에브리웨어 | everyWEAR</title>
<link rel="stylesheet" type="text/css" href="css/splitTest2.css">
<link rel="icon" type="image/png" href="images/fav-icon.png">
</head>
<body>

	<%@ include file="includes/header.jsp"%>

	<!-- 하위 네비 -->
	<nav class="sub-nav">
		<ul>
			<li><a href="pdListAll.jsp" class="active">ALL</a></li>
			<li><a href="#">OUTER</a></li>
			<li><a href="#">TOP</a></li>
			<li><a href="#">BOTTOM</a></li>
			<li><a href="#">ACC</a></li>
		</ul>
	</nav>

	<div class="container">
		<div class="product-list" id="productList">
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth1.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth1.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth1.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth1.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth1.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth1.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth1.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth1.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth1.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
		</div>

		<div class="resizer" id="resizer"></div>

		<div class="detail-panel" id="detailPanel">
			<span class="close-btn" id="closeBtn" onclick="closeDetail()">×</span>
			<span class="expand-btn" id="expandBtn" onclick="toggleFullView()">🔳</span>

			<div class="left-panel">
				<div class="product-detail-wrapper">
					<img src="images/main-cloth1.png" alt="SLASH ZIPPER JACKET"
						class="product-image" />
					<h2 class="product-name">SLASH ZIPPER JACKET - WASHED GRAY</h2>
					<div class="price">KRW 199,500</div>

					<div class="section">
						<label class="section-title">COLOR</label>
						<div class="color-options">
							<div class="color-circle" style="background-color: #61584F;"></div>
							<div class="color-circle" style="background-color: #2A2B32;"></div>
						</div>
					</div>

					<div class="section">
						<label class="section-title">SIZE</label>
						<div class="size-options">
							<button class="size-btn disabled">S [재입고 알림]</button>
							<button class="size-btn">M</button>
							<button class="size-btn">L</button>
						</div>
					</div>

					<div class="selection-preview">
						SLASH ZIPPER JACKET - WASHED GRAY 옵션: S <span class="remove">X</span>
					</div>

					<div class="notify-btn">
						<button>🔔 재입고 알림</button>
					</div>

					<div class="total-price">TOTAL: KRW 0 (0개)</div>

					<div class="buy-buttons">
						<button class="btn outline">ADD TO BAG</button>
						<button class="btn filled">BUY NOW</button>
					</div>

					<div class="section">
						<h4 class="guide-title">SIZE(cm) / GUIDE</h4>
						<p>
							S - Length 58.5 / Shoulder 47 / Chest 57 / Arm 62<br> M -
							Length 61 / Shoulder 49 / Chest 59.5 / Arm 63<br> L - Length
							63.5 / Shoulder 51 / Chest 62 / Arm 64
						</p>
						<p>
							MODEL<br>MAN : 181CM(L SIZE)
						</p>
						<p>
							COTTON 65%<br>NYLON 35%
						</p>
						<p>
							WAIST SNAP<br>2WAY ZIPPER (YKK社)
						</p>
					</div>

					<div class="info-note">
						* 워싱 제품 특성상 개체 차이가 존재 합니다.<br> * Object differences exist due
						to the nature of the washed product.<br> <br> * 두꼬운 포리벡
						특성상 옷에 슬립제가 무다나올 수 있습니다.<br> * 어두운 색 계열의 상품 구매 시 보이는 슬립제는 불량의
						사유가 아니라는 것을 알려드립니다.<br> * The slip agent on dark clothes is
						not defective.
					</div>
					<div class="inner-panel right-panel" style="display: none;" id="abc">
						<!-- 텍스트 설명, 옵션, 버튼 등 -->
						<img src="images/main-cloth1.png"> <img
							src="images/main-cloth1.png"> <img
							src="images/main-cloth1.png">
					</div>
				</div>
			</div>
			<div class="inner-panel right-panel">
				<!-- 텍스트 설명, 옵션, 버튼 등 -->
				<img src="images/main-cloth1.png"> <img
					src="images/main-cloth1.png"> <img
					src="images/main-cloth1.png">
			</div>
		</div>

	</div>

	<script>
  	const resizer = document.getElementById('resizer');
  	const detailPanel = document.getElementById('detailPanel');
  	const productList = document.getElementById('productList');
  	const container = document.querySelector('.container');

  	let isResizing = false;

  	resizer.addEventListener('mousedown', (e) => {
    	isResizing = true;
    	document.body.style.userSelect = 'none'; // ✅ 드래그 시 텍스트 선택 방지
    	document.addEventListener('mousemove', resize);
    	document.addEventListener('mouseup', stopResize);
  	});

  	function resize(e) {
    	if (isResizing) {
      	const newWidth = window.innerWidth - e.clientX;
      	if (newWidth > 500 && newWidth < window.innerWidth * 1) {
        	detailPanel.style.width = newWidth + 'px';
        	
         	// ✅ 너비 기준으로 column-layout 클래스 추가/제거
          if (newWidth < 600) {
          	detailPanel.classList.add('column-layout');
          	document.getElementById("abc").style.display = "block";
          } else {
            detailPanel.classList.remove('column-layout');
            document.getElementById("abc").style.display = "none";
          }
     		}
    	}
  	}

  	function stopResize() {
    	isResizing = false;
    	document.body.style.userSelect = ''; // ✅ 드래그 종료 시 원복
    	document.removeEventListener('mousemove', resize);
    	document.removeEventListener('mouseup', stopResize);
  	}

  	function openDetail() {
  	  container.classList.add('detail-open');

  	  // 현재 너비를 기억해서 유지 (또는 최소값 보장)
  	  const currentWidth = detailPanel.style.width;

  	  if (!currentWidth || parseInt(currentWidth) < 300) {
  	    detailPanel.style.width = '2000px'; // ✅ 최소 너비 적용
  	  } else {
  	    detailPanel.style.width = currentWidth; // ✅ 현재 너비 유지
  	  }
  	}

  	function closeDetail() {
    	container.classList.remove('detail-open');      // ✅ 클래스 제거로 상세창 숨김
  	}
  	
  	let isFullView = false;

  	function toggleFullView() {
  	  const expandBtn = document.getElementById('expandBtn');

  	  if (!isFullView) {
  	    container.classList.add('fullscreen-mode');
  	    expandBtn.textContent = '↩';       // ✅ 버튼 아이콘 바꾸기
  	    isFullView = true;
  	  } else {
  	    container.classList.remove('fullscreen-mode');
  	    expandBtn.textContent = '🔳';       // ✅ 원래 아이콘으로 복귀
  	    isFullView = false;
  	  }
  	}

	</script>

</body>
</html>