<!-- findIdResult.jsp -->

<%@page import="DTO.UserDTO"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<jsp:useBean id="userDao" class="DAO.UserDAO"/>
<%
		
		String type = request.getParameter("authType");
		
		Vector<UserDTO> ulist = new Vector<UserDTO>();
		String name = null;
		
		if(type.equals("phone")) {
			name = request.getParameter("name");
			String phone1 = request.getParameter("phone1");
			String phone2 = request.getParameter("phone2");
			String phone3 = request.getParameter("phone3");
			String phone = phone1 + "-" + phone2 + "-" + phone3;
			ulist = userDao.findIdByPhone(name, phone);
		} else if(type.equals("email")) {
			
		}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>검색 결과 | everyWEAR</title>
  <link rel="stylesheet" type="text/css" href="css/find.css">
  <link rel="stylesheet" type="text/css" href="css/findResult.css">
  <link rel="icon" type="image/png" href="images/fav-icon.png">
</head>
<body>

<%@ include file="includes/loginHeader.jsp" %>

<div class="result-container">
  <h1>아이디 찾기 결과</h1>
<br>
<%if(ulist.size() != 0){ %>
  <div class="description">
    아이디 찾기가 완료되었습니다.<br>
    가입된 아이디가 총 <strong><%=ulist.size()%>개</strong> 있습니다.
  </div>
	<br>
	<p align="center"><strong><%=name%></strong>님의 아이디 목록</p>
<div class="result-box">
	<%for(int i = 0; i<ulist.size(); i++){ 
			UserDTO user = ulist.get(i);
	%>
		  <label for="user<%=i+1%>"><strong><%=user.getUser_id()%></strong> (<%=user.getUser_rank()%>, <%=user.getCreated_at()%> 가입)</label>
	<%} %>
	</div>

<br>
<br>
  <div class="btn-group">
    <a href="login.jsp" class="btn black">로그인</a>
    <a href="findPwd.jsp" class="btn white">비밀번호 찾기</a>
  </div>
  <%} else{ //회원이 없는 경우	
  %>
  			  <div class="description">
    			입력하신 정보와 일치하는 회원을 찾을 수 없습니다.
  			</div>
  			  <div class="btn-group">
    		<a href="signup.jsp" class="btn black">회원가입</a>
  			</div>
  <%} %>
</div>

<footer>2025©everyWEAR</footer>

</body>
</html>