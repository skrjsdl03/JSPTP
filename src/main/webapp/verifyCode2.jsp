<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%@ page contentType="application/json; charset=UTF-8" %>
<jsp:useBean id="uDao" class="DAO.UserDAO"/>
<%
  String userCode = request.getParameter("code");
  String sessionCode = (String)session.getAttribute("authCode");
  
  String id = request.getParameter("id");
  String birth = request.getParameter("birth");
  String phone = request.getParameter("phone");

  if (userCode != null && userCode.equals(sessionCode)) {
	  if(uDao.isLockUser(id, birth, phone))
    		out.print("{\"result\":\"success\"}");
	  else
		  out.print("{\"result\":\"none\"}");
  } else {
    out.print("{\"result\":\"fail\"}");
  }
%>
