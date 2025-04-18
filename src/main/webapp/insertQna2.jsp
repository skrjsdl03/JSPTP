<%@ page contentType="application/json; charset=UTF-8" %>
<jsp:useBean id="qDao" class="DAO.QnaDAO"/>
<%
		String id = (String)session.getAttribute("id");
		String type = (String)session.getAttribute("userType");
		qDao.insertQna2(id, type, request);
		out.print("{\"result\":\"success\"");
%>