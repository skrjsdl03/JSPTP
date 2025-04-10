<%@ page contentType="application/json; charset=UTF-8" %>
<jsp:useBean id="qDao" class="DAO.QnaDAO"/>
<%
		String id = (String)session.getAttribute("id");
		qDao.insertQna(id, request);
		out.print("{\"result\":\"success\"");
%>