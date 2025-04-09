<%@ page import="DAO.PhoneSMS" %>
<%@ page contentType="application/json; charset=UTF-8" %>
<jsp:useBean id="user" class="DAO.UserDAO"/>
<%
	String name = request.getParameter("name");
	String id = request.getParameter("id");
    String phone = request.getParameter("phone");
    
    String p1 = phone.substring(0, 3);
    String p2 = phone.substring(3, 7);
    String p3 = phone.substring(7);
    
    String p_total = p1 + "-" + p2 + "-" + p3;
    
    System.out.println(name);
    System.out.println(id);
    System.out.println(p_total);
    String code = "000000";
    		
    if(user.findPwdByPhone(id, name, p_total)){
        code = PhoneSMS.sendSMS(phone);
        // 세션에 인증번호 저장 가능
        session.setAttribute("authCode", code);
        // 응답
        out.print("{\"result\":\"success\", \"code\":\"" + code + "\"}");
    } else{
        // 응답
    	out.print("{\"result\":\"fail\", \"code\":\"" + code + "\"}");
    }
%>
