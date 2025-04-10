<%@page import="DTO.InquiryDTO"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<jsp:useBean id="qDao" class="DAO.QnaDAO"/>
<%
		Vector<InquiryDTO> qlist = qDao.showAllQna();
		int totalData = qlist.size();      // 일반 공지의 수
		int itemsPerPage = 7;                // 한 페이지당 7개
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
<link rel="stylesheet" type="text/css" href="css/Q&A.css?v=354">
</head>
<body>

	<%@ include file="includes/header.jsp"%>

	<section class="content2">
	<h3>Q&A</h3>
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
			<table class="notice-table" id="notice-table">
				<tbody>
<<<<<<< HEAD
					<tr style="border-bottom: 2px solid #BBBBBB;">
						<td class="title">제목</td>
						<td>답변 현황</td>
						<td class="date">작성 일시</td>
						<td class="type">작성자</td>
=======
					<tr>
						<td class="title"><a href="qnaAnswerEx1.jsp">&#128274; 배송관련 문의입니다.</a></td>
						<td>답변 예정</td>
						<td class="date">2025-03-30</td>
						<td class="type">배송 문의</td>
>>>>>>> branch 'main' of https://github.com/skrjsdl03/JSPTP.git
					</tr>
				<%for(int i = start;i<end;i++){ 
						InquiryDTO qna = qlist.get(i);
						
						if(qna.getI_isPrivate().equals("Y")){
				%>
					<tr>
						<td class="title">&#128274; <%=qna.getI_title()%></td>
						<td><%=qna.getI_status()%></td>
						<td class="date"><%=qna.getCreated_at()%></td>
						<td class="type"><%=qna.getUser_id()%></td>
					</tr>
				<%} else{ %>
					<tr>
						<td class="title"><%=qna.getI_title()%></td>
						<td><%=qna.getI_status()%></td>
						<td class="date"><%=qna.getCreated_at()%></td>
						<td class="type"><%=qna.getUser_id()%></td>
					</tr>
				<%		} 
						}	
				%>
				</tbody>
			</table>

			<div class="write-btn-wrapper">
				<button class="write-btn" onclick="location.href='qnaFormForCommon.jsp'">작성하기</button>
			</div>


		       <!-- 🔻 페이징 처리 -->
		<div class="pagination" id="pagination">
		  <% if (currentPage > 1) { %>
		    <a href="Q&A.jsp?page=<%= currentPage - 1 %>">Prev</a>
		  <% } else { %>
		    <span class="invisible-button">Prev</span>
		  <% } %>
		
		  <% for (int i = 1; i <= totalPage; i++) { %>
		    <a href="Q&A.jsp?page=<%= i %>" class="<%= (i == currentPage ? "active" : "") %>">
		      <%= i %>
		    </a>
		  <% } %>
		
		  <% if (currentPage < totalPage) { %>
		    <a href="Q&A.jsp?page=<%= currentPage + 1 %>">Next</a>
		  <% } else { %>
		    <span class="invisible-button">Next</span>
		  <% } %>
		</div>

			<div class="footer-bottom">
				<p>2025&copy;everyWEAR</p>
			</div>
		</section>
	</div>

	<script>

</script>

</body>