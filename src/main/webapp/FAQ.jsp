<%@page import="DTO.FaqDTO"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<jsp:useBean id="faqDao" class="DAO.FaqDAO"/>
<%
		Vector<FaqDTO> flist = faqDao.showFaq();
		int totalData = flist.size();        // 총 데이터 수 = 20
		int itemsPerPage = 7;                // 한 페이지당 8개
		int totalPage = (int)Math.ceil((double)totalData / itemsPerPage);
		
		int currentPage = 1;
		if (request.getParameter("page") != null) {
		    currentPage = Integer.parseInt(request.getParameter("page"));
		}
		
		int start = (currentPage - 1) * itemsPerPage;
		int end = start + itemsPerPage;
		if (end > totalData) end = totalData;
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>에브리웨어 | everyWEAR</title>
<link rel="icon" type="image/png" href="images/fav-icon.png">
<link rel="stylesheet" type="text/css" href="css/FAQ.css?v=234564">

</head>
<body>

	<%@ include file="includes/boardHeader.jsp"%>
	
	<section2 class="content2">
		<h3>FAQ</h3>
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
      <% for (int i = start; i < end; i++) {
        FaqDTO faq = flist.get(i);
      %>
        <div class="faq-item">
          <span><%=faq.getFaq_title()%></span>
          <span class="arrow">▼</span>
        </div>
        <div class="faq-content" style="display: none;">
          <%=faq.getFaq_content()%>
        </div>
      <% } %>
    
       <!-- 🔻 페이징 처리 -->
   <div class="pagination" id="pagination">
     <% if (currentPage > 1) { %>
       <a href="FAQ.jsp?page=<%= currentPage - 1 %>">Prev</a>
     <% } %>

     <% for (int i = 1; i <= totalPage; i++) { %>
       <a href="FAQ.jsp?page=<%= i %>" class="<%= (i == currentPage ? "active" : "") %>">
         <%= i %>
       </a>
     <% } %>

     <% if (currentPage < totalPage) { %>
       <a href="FAQ.jsp?page=<%= currentPage + 1 %>">Next</a>
     <% } %>
   </div>
    
<!-- 			<div class="pagination" id="pagination">
				<span>Prev</span>
				<span class="active">1</span>
				<span>2</span>
				<span>3</span>
				<span>4</span>
				<span>5</span>
				<span>Next</span>
			</div> -->

			<div class="footer-bottom">
				<p>2025&copy;everyWEAR</p>
			</div>
		</section>
	</div>

	<script>
  document.addEventListener("DOMContentLoaded", function () {
    const rowsPerPage = 10;
    const table = document.getElementById("notice-table");
    const rows = table.querySelectorAll("tbody tr");
    const totalPages = Math.ceil(rows.length / rowsPerPage);
    const pagination = document.getElementById("pagination");

    let currentPage = 1;

    function showPage(page) {
      const start = (page - 1) * rowsPerPage;
      const end = start + rowsPerPage;

      rows.forEach((row, index) => {
        row.style.display = index >= start && index < end ? "" : "none";
      });

      updatePagination(page);
    }

    function updatePagination(activePage) {
      pagination.innerHTML = "";

      // Prev 버튼
      const prev = document.createElement("span");
      prev.textContent = "Prev";
      prev.onclick = () => {
        if (currentPage > 1) showPage(--currentPage);
      };
      pagination.appendChild(prev);

      // 페이지 번호
      for (let i = 1; i <= totalPages; i++) {
        const span = document.createElement("span");
        span.textContent = i;
        if (i === activePage) span.classList.add("active");
        span.onclick = () => {
          currentPage = i;
          showPage(currentPage);
        };
        pagination.appendChild(span);
      }

      // Next 버튼
      const next = document.createElement("span");
      next.textContent = "Next";
      next.onclick = () => {
        if (currentPage < totalPages) showPage(++currentPage);
      };
      pagination.appendChild(next);
    }

    // 초기 페이지 로드
    showPage(currentPage);
  });
  
  
  /* 새로운 부분 */
  window.onload = function() {
      const items = document.querySelectorAll('.faq-item');

      items.forEach(item => {
          item.addEventListener('click', function() {
              const content = this.nextElementSibling;

              // 이미 열려있으면 닫기
              if (this.classList.contains('active')) {
                  this.classList.remove('active');
                  content.style.display = 'none';
              } else {
                  // 다른 항목 닫기
                  items.forEach(i => i.classList.remove('active'));
                  document.querySelectorAll('.faq-content').forEach(c => c.style.display = 'none');

                  // 현재 항목 열기
                  this.classList.add('active');
                  content.style.display = 'block';
              }
          });
      });
  }
</script>

</body>