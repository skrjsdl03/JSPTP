<%@ page  contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="user" class="DAO.UserDAO"/>
<%
		String redirect = request.getParameter("redirect");
		if (redirect == null || redirect.equals("")) {
		    redirect = "main2.jsp"; // 기본 리디렉션
		}
		
		String id = (String)session.getAttribute("id");
		String type = (String)session.getAttribute("userType");
		user.insertLog(id, type, "로그아웃");
		session.invalidate();
%>
<script>
	location.href = "<%=redirect%>";
</script>