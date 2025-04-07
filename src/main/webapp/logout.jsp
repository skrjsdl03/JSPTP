<%@ page  contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="user" class="DAO.UserDAO"/>
<%
		String id = (String)session.getAttribute("id");
		user.insertLog(id, "로그아웃");
		session.invalidate();
%>
<script>
	location.href = "main.jsp";
</script>