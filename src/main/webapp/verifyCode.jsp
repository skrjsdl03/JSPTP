<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%@ page contentType="application/json; charset=UTF-8" %>
<%
  String userCode = request.getParameter("code");
  String sessionCode = (String)session.getAttribute("authCode");
  

  if (userCode != null && userCode.equals(sessionCode)) {
    out.print("{\"result\":\"success\"}");
  } else {
    out.print("{\"result\":\"fail\"}");
  }
%>
