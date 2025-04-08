<%@page import="DAO.GmailSend"%>
<%@page import="java.util.Random"%>
<%@ page contentType="application/json; charset=UTF-8" %>
<jsp:useBean id="user" class="DAO.UserDAO"/>
<%
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String id = request.getParameter("id");
		
		System.out.println(name);
		System.out.println(email);
		System.out.println(id);
		
		if(user.findPwdByEmail(id, name, email)){
			String authNum = (new Random().nextInt(900000) + 100000) + "";
			session.setAttribute("authCode", authNum);
			
			String title = "[everyWEAR] 이메일 인증번호입니다.";
			String content = "<h3>안녕하세요, " + name + "님</h3>" +
			                 "<p>인증번호는 <strong>" + authNum + "</strong>입니다.</p>";
        		try {
       		    GmailSend.send(title, content, email);
       		 	out.print("{\"result\":\"success\"}");
       		} catch (Exception e) {
       			out.print("{\"result\":\"fail\"}");
       		}  
		} else{
			System.out.println("이거?");
			out.print("{\"result\":\"none\"}");
		}
%>