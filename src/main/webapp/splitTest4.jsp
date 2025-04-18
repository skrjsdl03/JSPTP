<%@page import="DTO.ProductDetailDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Vector"%>
<%@page import="DTO.ProductDTO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html;charset=UTF-8" language="java"%>
<jsp:useBean id="pDao" class="DAO.ProductDAO"/>
<%
// 카테고리 파라미터 처리

DecimalFormat formatter = new DecimalFormat("#,###");


Vector<ProductDTO> plist = new Vector<ProductDTO>();
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




	<!-- <nav class="items">
		<ul>
			<li><a>ITEMS()</a></li>
		</ul>
	</nav> -->

	<!-- 정렬 옵션 -->
	<div class="sort-options">
		<label for="sort-select" class="label-bold" id="itemCnt">BEST<br>ITEMS() </label> 
		<!-- <select id="sort-select">
			<option value="" disabled selected hidden>SORT BY</option>
			<option value="new">NEW</option>
			<option value="popular">POPULAR</option>
			<option value="low">LOW PRICE</option>
			<option value="high">HIGH PRICE</option>
		</select> -->
	</div>

	<div class="container">
		<div class="product-list" id="productList">
			<%
				plist = pDao.getOUTERPd();
				Vector<String> ilist = null;
				for(int i = 0; i<plist.size(); i++){
					ProductDTO pDto = plist.get(i);
					ilist = pDao.getPdImg(pDto.getP_id());
			%>
			<div class="product" onclick="openDetail('<%=pDto.getP_id()%>')">
				<img src="<%=ilist.get(0)%>">
				<p class="product-name"><%=pDto.getP_name()%></p>
				<p class="product-price">KRW <%=formatter.format(pDto.getP_price())%></p>
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
					<img src="" alt="SLASH ZIPPER JACKET"
						class="product-image" />
					<h2 class="product-name"></h2>
					<div class="price"></div>

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
							<button class="size-btn disabled"></button>
							<button class="size-btn"></button>
							<button class="size-btn"></button>
						</div>
					</div>

					<div class="selection-preview">
						
					</div>

					<div class="notify-btn">
						<button></button>
					</div>

					<div class="total-price"></div>

					<div class="buy-buttons">
						<button class="btn outline"></button>
						<button class="btn filled"></button>
						<button class="btn wishlist-btn" id="wishlistBtn">🤍</button>
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
						
						<img src="images/main-cloth1.png"> <img
							src="images/main-cloth1.png"> <img
							src="images/main-cloth1.png">
					</div>
				</div>
			</div>
			<div class="inner-panel right-panel">
				
				
			</div>
		</div>

	</div>
	
	<form action="pay.jsp" method="post" id="goPayForm">
		<input type="hidden" id="hidden_pd_id" name="pd_id">
		<input type="hidden" name="quantity" value="1">
	</form>
	
	<form action="pdDetail.jsp" method="get" id="goPdDetail">
		<input type="hidden" id="hiddenPID" name="p_id">
	</form>

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

  	
  	function openDetail(p_id) {
  	  // 주소창만 바꾸기 (새로고침 안 함)
  	  const currentUrl = new URL(window.location);
  	  currentUrl.searchParams.set("p_id", p_id);
  	  history.pushState({}, '', currentUrl); // 새로고침 안 일어남

  	  // 패널 열기
  	  const container = document.querySelector('.container');
  	  const detailPanel = document.getElementById('detailPanel');
  	  container.classList.add('detail-open');

  	  // Ajax로 상세정보 받아오기
  	  fetch("/JSPTP/getProductDetail.jsp?p_id=" + p_id)
  	    .then(res => res.text())
  	    .then(html => {
  	      detailPanel.innerHTML = html;
  	    });
  	}



  	function closeDetail() {
    	container.classList.remove('detail-open');      // ✅ 클래스 제거로 상세창 숨김
  	}
  	
  	let isFullView = false;

/*   	function toggleFullView() {
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
  	} */
  	
  	function toggleFullView(p_id) {
  		document.getElementById("hiddenPID").value = p_id;
  		document.getElementById("goPdDetail").submit();
  	}

	</script>



	<script>
  // ✅ 카테고리별 중분류 정의

  // ✅ 페이지 로드시 렌더링 실행
  document.addEventListener("DOMContentLoaded", function () {
    document.getElementById("itemCnt").innerHTML = "BEST<BR>ITEMS(" + <%=plist.size()%> + ")";
  });
</script>


	<script>
/*  		document.addEventListener("DOMContentLoaded", () => {
    	const wishlistBtn = document.getElementById("wishlistBtn");

    	wishlistBtn.addEventListener("click", () => {
      	wishlistBtn.classList.toggle("active");
      	wishlistBtn.textContent = wishlistBtn.classList.contains("active") ? "❤" : "🤍";
    	});
  	}); */
	</script>
				<script>
				 let selectedSize = null;
				function addToBag(p_id){
					<%
					String user_id = (String)session.getAttribute("id");
					if(user_id == null || user_id.equals("") ){
					%>
					alert("회원만 장바구니에 담을 수 있습니다.");
					return;
					<%}%>
				    if (!selectedSize) {
				        alert("사이즈를 선택해주세요.");
				        return false;
				      }
				    
				     fetch("addCart.jsp?p_id=" + encodeURIComponent(p_id) + "&size=" + encodeURIComponent(selectedSize))
				     .then(res => res.json())
				     .then(data => {
				       if (data.result === "success") {
				    	   alert("장바구니에 추가되었습니다!");
				       } else {
				 		alert("장바구니에 넣을 수 없습니다.");
				       }
				     });				
				}
				
				function buyNow(p_id){
				    if (!selectedSize) {
				        alert("사이즈를 선택해주세요.");
				        return false;
				      }
				    
				    fetch('getPdId.jsp', {
				        method: 'POST',
				        headers: {
				          'Content-Type': 'application/x-www-form-urlencoded'
				        },
				        body: "p_id=" + encodeURIComponent(p_id) + "&size=" + encodeURIComponent(selectedSize)
				      })
				      .then(response => response.json())
				      .then(data => {
				        const pd_id = data.pd_id;

				        // 👉 여기서 페이지에 반영하거나, 다른 함수로 넘기기
				        document.getElementById("hidden_pd_id").value = pd_id;
				        document.getElementById("goPayForm").submit();
				      })
				      .catch(error => console.error('에러 발생:', error));
				}
				
				function sizeCheck(name, size){
					selectedSize = size;
					document.getElementById("selectedSize").innerHTML = name + " 옵션 : " + size + "<span class='remove' onclick='deleteSelect()'> X</span>";
					const price = document.getElementById("price").textContent;
					document.getElementById("tprice").textContent = price;

				}
				
				function deleteSelect(){
					selectedSize = null;
					document.getElementById("selectedSize").innerHTML = "";
					document.getElementById("tprice").textContent = "KRW 0";
				}
				
				function addToWish(p_id){
					<%
					String u_id = (String)session.getAttribute("id");
					if(u_id == null || u_id.equals("") ){
					%>
					alert("회원만 찜할 수 있습니다.");
					return;
					<%}%>
				    if (!selectedSize) {
				        alert("사이즈를 선택해주세요.");
				        return false;
				      }
				    
				     fetch("addWish.jsp?p_id=" + encodeURIComponent(p_id) + "&size=" + encodeURIComponent(selectedSize))
				     .then(res => res.json())
				     .then(data => {
				       if (data.result === "success") {
				    	   alert("해당 상품이 찜되었습니다!");
				    		const wishlistBtn = document.getElementById("wishlistBtn");
				          	wishlistBtn.classList.toggle("active");
				          	wishlistBtn.textContent = wishlistBtn.classList.contains("active") ? "❤" : "🤍";
				       } else {
				 		alert("찜할 수 없습니다.");
				       }
				     });	
				}
			</script>

</body>
</html>