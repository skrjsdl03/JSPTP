<%@page import="DTO.InquiryReplyDTO"%>
<%@page import="DTO.InquiryDTO"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<jsp:useBean id="qDao" class="DAO.QnaDAO"/>
<%
		String user_id = (String)session.getAttribute("id");
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
		
		String onclickWrite = "onclick=\"location.href='qnaFormForCommon.jsp'\"";
		if(user_id == null){
			// 현재 페이지 경로를 얻기 위한 코드
			String fullUrl = request.getRequestURI();
			String queryString = request.getQueryString();
			if (queryString != null) {
				fullUrl += "?" + queryString;
			}
			onclickWrite = "onclick=\"location.href='login.jsp?redirect=" + java.net.URLEncoder.encode(fullUrl, "UTF-8") + "'\"";
		}
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
					<tr style="border-bottom: 2px solid #BBBBBB;">
						<td class="title">제목</td>
						<td>답변 현황</td>
						<td class="date">작성 일시</td>
						<td class="type">작성자</td>
					</tr>
				<%for(int i = start;i<end;i++){ 
						InquiryDTO qna = qlist.get(i);
						InquiryReplyDTO qnaReply = qDao.showOneQnaReply(qna.getI_id());
						
					    String onclick = "";
					    String onclickReply = "";
					    if (qna.getUser_id().equals(user_id)) {
					        onclick = "goDetail('" + qna.getI_id() + "')";
					        onclickReply = "goDetailReply('" + qna.getI_id() + "')";
					    }
						
						if(qna.getI_isPrivate().equals("Y")){			/* 비밀글이라면 */
				%>
					<tr>
						<td class="title"><a href="javascript:<%=onclick%>"><%=qlist.size() - i%>. <%=qna.getI_title()%> &#128274;</a></td>
						<td style="<%= qna.getI_status().equals("답변완료") ? "color: green; font-weight: bold;" : "" %>">
						  <%=qna.getI_status()%>
						</td>
						<td class="date"><%=qna.getCreated_at()%></td>
						<td class="type"><%=qna.getUser_id()%></td>
					</tr>
				<%if(qnaReply != null){ %>		<!-- 댓글이 있다면 -->
					<tr style="background-color: #F0F0F0;" <%=onclickReply%>>
						<td class="title"><strong>&nbsp;&nbsp; <a href="javascript:<%=onclickReply%>">└[답변] <%=qna.getI_title()%> &#128274;</a></strong></td>
						<td> </td>
						<td class="date"> </td>
						<td class="type"> </td>
					</tr>
					<%} %>
				<%} else{ %>			<!-- 비밀글이 아니라면 -->
					<tr>
						<td class="title"><a href="javascript:goDetail('<%=qna.getI_id()%>')"><%=qlist.size() - i%>. <%=qna.getI_title()%></a></td>
						<td style="<%= qna.getI_status().equals("답변완료") ? "color: green; font-weight: bold;" : "" %>">
						  <%=qna.getI_status()%>
						</td>
						<td class="date"><%=qna.getCreated_at()%></td>
						<td class="type"><%=qna.getUser_id()%></td>
					</tr>
				<%if(qnaReply != null){ %>		<!-- 댓글이 있다면 -->
					<tr style="background-color: #F0F0F0;">
						<td class="title" ><strong>&nbsp;&nbsp; <a href="javascript:goDetailReply('<%=qna.getI_id()%>')">└[답변] <%=qna.getI_title()%></a></strong></td>
						<td> </td>
						<td class="date"> </td>
						<td class="type"> </td>
					</tr>
				<%	
						}
					} 
				}	
				%>
				</tbody>
			</table>

			<div class="write-btn-wrapper">
				<button class="write-btn" <%=onclickWrite%>>작성하기</button>
			</div>
			
			<form action="qnaDetail.jsp" method="post" id="detailForm">
				<input type="hidden" id="hidden_i_id" name="i_id">
			</form>
			
			<form action="qnaDetail.jsp" method="post" id="detailForm2">
				<input type="hidden" id="hidden_i_id2" name="i_id">
				<input type="hidden" id="reply" name="reply" value="Y">
			</form>

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
	function goDetail(i_id){
		document.getElementById("hidden_i_id").value = i_id;
		document.getElementById("detailForm").submit();
	}
	
	function goDetailReply(i_id){
		document.getElementById("hidden_i_id2").value = i_id;
		document.getElementById("detailForm2").submit();
	}
</script>

</body>