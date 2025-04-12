<%@page import="DAO.UserDAO"%>
<%@ page contentType="application/json; charset=UTF-8" %>
<%
		UserDAO user = new UserDAO();
		
		String password = request.getParameter("password");
		
		String userId = (String)session.getAttribute("id");
		
		if(user.isPwd(userId, password)) {
			out.print("{\"result\":\"success\"}");
		} else{
			out.print("{\"result\":\"fail\"}");
		}
%>
