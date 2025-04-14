<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%@ page contentType="application/json; charset=UTF-8" %>
<jsp:useBean id="uDao" class="DAO.UserDAO"/>
<%
  String userCode = request.getParameter("code");
  String sessionCode = (String)session.getAttribute("authCode");
  
  String id = (String)session.getAttribute("id");
  String type = (String)session.getAttribute("userType");
  String phone = request.getParameter("phone");
  
  String p = phone.substring(0, 3) + "-" + phone.substring(3, 7) + "-" + phone.substring(7);

  if (userCode != null && userCode.equals(sessionCode)) {
	  if(uDao.updatePhone(id, p, type))
    		out.print("{\"result\":\"success\"}");
	  else
		  out.print("{\"result\":\"cant\"}");
  } else {
    out.print("{\"result\":\"fail\"}");
  }
%>
