<%@page import="DAO.GmailSend"%>
<%@page import="java.util.Random"%>
<%@ page  contentType="text/html; charset=UTF-8"%>
<%
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String authNum = (new Random().nextInt(900000) + 100000) + "";
		session.setAttribute("authCode", authNum);
		
		String title = "[everyWEAR] 이메일 인증번호입니다.";
		String content = "<h3>안녕하세요, " + name + "님</h3>" +
		                 "<p>인증번호는 <strong>" + authNum + "</strong>입니다.</p>";
		
		try {
		    GmailSend.send(title, content, email);
		    out.print("success");
		} catch (Exception e) {
		    e.printStackTrace();
		    out.print("fail");
		}
%>