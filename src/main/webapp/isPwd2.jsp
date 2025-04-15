<%@page import="DAO.UserDAO"%>
<%@ page contentType="application/json; charset=UTF-8" %>
<%
		UserDAO user = new UserDAO();
		
		String password = request.getParameter("password");
		String newPassword = request.getParameter("newPassword");
		
		String userId = (String)session.getAttribute("id");
		
		if(user.isPwd(userId, password)) {
			if(user.updatePwd(userId, newPassword)){
				out.print("{\"result\":\"success\"}");	//변경 성공	
				return;
			}
			out.print("{\"result\":\"cant\"}");	//변경 실패
		} else{
			out.print("{\"result\":\"fail\"}");	//잘못된 기존 아이디
		}
%>
