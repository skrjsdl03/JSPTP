<%@ page import="DAO.PhoneSMS" %>
<%@ page contentType="application/json; charset=UTF-8" %>

<%
    String phone = request.getParameter("phone");
    String code = PhoneSMS.sendSMS(phone);

    // 세션에 인증번호 저장 가능
    session.setAttribute("authCode", code);

    // 응답
    out.print("{\"result\":\"success\", \"code\":\"" + code + "\"}");
%>
