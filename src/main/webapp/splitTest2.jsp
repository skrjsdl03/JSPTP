<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%
// 카테고리 파라미터 처리
String category = request.getParameter("cat");
if (category == null) {
	category = "all";
}

String subCategory = request.getParameter("subCat");
if (subCategory == null) {
	subCategory = "all";
}

// 임시 상품 데이터
class Product {
	String id;
	String name;
	int price;
	String image;
	String category;

	Product(String id, String name, int price, String image, String category) {
		this.id = id;
		this.name = name;
		this.price = price;
		this.image = image;
		this.category = category;
	}
}

List<Product> allProducts = new ArrayList<>();
allProducts.add(new Product("101", "후리스 자켓", 59000, "images/main-cloth1.png", "outer"));
allProducts.add(new Product("102", "셔츠 블라우스", 49000, "images/main-cloth2.png", "top"));
allProducts.add(new Product("103", "데님 팬츠", 69000, "images/main-cloth3.png", "bottom"));
allProducts.add(new Product("104", "롱코트", 129000, "images/main-cloth4.png", "acc"));
allProducts.add(new Product("105", "기본 티셔츠", 19000, "images/main-cloth5.png", "outer"));
allProducts.add(new Product("106", "후리스 자켓", 59000, "images/main-cloth1.png", "outer"));
allProducts.add(new Product("107", "셔츠 블라우스", 49000, "images/main-cloth2.png", "top"));
allProducts.add(new Product("108", "데님 팬츠", 69000, "images/main-cloth3.png", "bottom"));
allProducts.add(new Product("109", "롱코트", 129000, "images/main-cloth4.png", "acc"));
allProducts.add(new Product("110", "기본 티셔츠", 19000, "images/main-cloth5.png", "outer"));
allProducts.add(new Product("111", "후리스 자켓", 59000, "images/main-cloth1.png", "outer"));
allProducts.add(new Product("112", "셔츠 블라우스", 49000, "images/main-cloth2.png", "top"));
allProducts.add(new Product("113", "데님 팬츠", 69000, "images/main-cloth3.png", "bottom"));
allProducts.add(new Product("114", "롱코트", 129000, "images/main-cloth4.png", "acc"));
allProducts.add(new Product("115", "기본 티셔츠", 19000, "images/main-cloth5.png", "outer"));

// 필터링
List<Product> filteredProducts = new ArrayList<>();
for (Product p : allProducts) {
	if (category.equals("all") || p.category.equals(category)) {
		filteredProducts.add(p);
	}
}
%>
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

	<!-- 대분류 카테고리 -->
	<nav class="sub-nav">
		<ul>
			<li><a href="splitTest2.jsp?cat=all"
				class="<%=category.equals("all") ? "active" : ""%>">ALL</a></li>
			<li><a href="splitTest2.jsp?cat=outer"
				class="<%=category.equals("outer") ? "active" : ""%>">OUTER</a></li>
			<li><a href="splitTest2.jsp?cat=top"
				class="<%=category.equals("top") ? "active" : ""%>">TOP</a></li>
			<li><a href="splitTest2.jsp?cat=bottom"
				class="<%=category.equals("bottom") ? "active" : ""%>">BOTTOM</a></li>
			<li><a href="splitTest2.jsp?cat=acc"
				class="<%=category.equals("acc") ? "active" : ""%>">ACC</a></li>
			<li><a href="splitTest2.jsp?cat=etc"
				class="<%=category.equals("etc") ? "active" : ""%>">ETC</a></li>
		</ul>
	</nav>

	<!-- 중분류 카테고리 -->
	<nav class="sub-nav2" id="subCategoryNav"
		style="<%=category.equals("all") ? "display:none;" : "display:block;"%>">
		<ul id="subCategoryList"></ul>
	</nav>

	<!-- <nav class="items">
		<ul>
			<li><a>ITEMS()</a></li>
		</ul>
	</nav> -->

	<!-- 정렬 옵션 -->
	<div class="sort-options">
		<label for="sort-select" class="label-bold">ITEMS() </label>
		<select id="sort-select">
			<option value="" disabled selected hidden>SORT BY</option>
			<option value="new">NEW</option>
			<option value="popular">POPULAR</option>
			<option value="low">LOW PRICE</option>
			<option value="high">HIGH PRICE</option>
		</select>
	</div>

	<div class="container">
		<div class="product-list" id="productList">
			<%
			if (category != null && category.equals("all")) {
			%>
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
			<%
			}
			%>
			<%
			if (category != null && category.equals("outer")) {
			%>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth2.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth2.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth2.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth2.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth2.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth2.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth2.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth2.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<%
			}
			%>
			<%
			if (category != null && category.equals("top")) {
			%>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth3.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth3.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth3.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth3.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth3.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth3.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth3.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth3.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<%
			}
			%>
			<%
			if (category != null && category.equals("bottom")) {
			%>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth4.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth4.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth4.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth4.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth4.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth4.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth4.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth4.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<%
			}
			%>
			<%
			if (category != null && category.equals("acc")) {
			%>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth5.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth5.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth5.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth5.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth5.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth5.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth5.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/main-cloth5.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<%
			}
			%>
			<%
			if (category != null && category.equals("etc")) {
			%>
			<div class="product" onclick="openDetail()">
				<img src="images/ex1.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/ex1.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/ex1.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/ex1.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/ex1.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/ex1.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/ex1.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<div class="product" onclick="openDetail()">
				<img src="images/ex1.png">
				<p class="product-name">I ♥ JDJ</p>
				<p class="product-price">KRW 88,000</p>
			</div>
			<%
			}
			%>
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
					<div class="inner-panel right-panel" style="display: none;"
						id="abc">
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
          	document.getElementById("abc").style.display = "";
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
  	
  	function toggleFullView() {
  		window.location.href = 'pdDetail.jsp';
  	}

	</script>

	<script>
  	document.querySelectorAll('.sub-nav ul li a').forEach(item => {
    	item.addEventListener('click', function (e) {
/*     		e.preventDefault(); */
    		
      	const selectedText = this.textContent.trim().toLowerCase();
      	const subNav = document.getElementById('subCategoryNav');

      	if (selectedText === 'all') {
        	subNav.style.display = 'none';
      	} else {
        	subNav.style.display = 'block';
      	}

      	// 액티브 클래스 토글
      	document.querySelectorAll('.sub-nav ul li a').forEach(a => a.classList.remove('active'));
      	this.classList.add('active');
    	});
  	});
	</script>

	<script>
  	const subCategories = {
	    outer: ["HEAVY OUTER", "HOODED ZIP-UP", "JACKET", "JUMPER", "VEST", "WIND BREAKER"],
	    top: ["HOODIE", "KNIT/CARDIGAN", "LONG SLEEVE", "SHIRT", "SLEEVESS", "SWEAT SHIRT", "T-SHIRT"],
	    bottom: ["DENIM", "PANTS", "SHORTS", "TRAINING PANTS"],
	    acc: ["BAG", "ETC", "HEADGEAR", "KEYRING", "MUFFLER"],
	    etc: ["BELT/NECKLACE", "GLOVES/SOCKS", "OTHERS"]
	  };

	  // 파라미터 읽는 함수
	  function getParameterByName(name) {
	    const url = window.location.href;
	    name = name.replace(/[\\[\\]]/g, '\\$&');
	    const regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
	      results = regex.exec(url);
	    if (!results) return null;
	    if (!results[2]) return '';
	    return decodeURIComponent(results[2].replace(/\+/g, ' '));
  	}

	  function renderSubCategories(category) {
	    const subNav = document.getElementById('subCategoryNav');
	    const subList = document.getElementById('subCategoryList');
	
	    if (!category || category === 'all') {
	      subNav.style.display = 'none';
	      subList.innerHTML = '';
	      return;
	    }

	    const subs = subCategories[category];
	    if (subs && subs.length > 0) {
	      subList.innerHTML = '';
	      subs.forEach(sub => {
	        const li = document.createElement('li');
	        const a = document.createElement('a');
	        a.href = "#";
	        a.textContent = sub;
	
	        a.addEventListener('click', function (e) {
	          e.preventDefault();
	          document.querySelectorAll('#subCategoryList a').forEach(a => a.classList.remove('active'));
	          this.classList.add('active');
	        });
	
	        li.appendChild(a);
	        subList.appendChild(li);
	      });
	      subNav.style.display = 'block';
	    } else {
	      subList.innerHTML = '';
	      subNav.style.display = 'none';
	    }
	  }
	
	  // 페이지 로드되자마자 실행
	  document.addEventListener("DOMContentLoaded", function () {
	    const currentCategory = getParameterByName('cat'); // ex. outer
	    renderSubCategories(currentCategory);
	  });
	</script>

</body>
</html>