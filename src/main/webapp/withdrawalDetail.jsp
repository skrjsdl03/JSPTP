<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DAO.UserDAO, DTO.UserDTO" %>

<%
request.setCharacterEncoding("UTF-8");
String user_id = request.getParameter("user_id");
UserDTO user = null;

if (user_id != null && !user_id.trim().isEmpty()) {
    UserDAO dao = new UserDAO();
    user = dao.getWithdrawalDetail(user_id); // ← DAO 메서드 필수 구현
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>탈퇴회원 상세정보</title>
<style>
	body {
		font-family: '맑은 고딕', sans-serif;
		padding: 20px;
	}
	h3 {
		color: #333;
		margin-bottom: 20px;
	}
	ul {
		list-style: none;
		padding: 0;
	}
	li {
		margin-bottom: 10px;
	}
	.error {
		color: red;
		font-weight: bold;
	}
</style>
</head>
<body>
	<h3>탈퇴회원 상세정보</h3>

	<%
	if (user == null) {
	%>
		<p class="error">❗ 해당 탈퇴회원 정보를 찾을 수 없습니다.</p>
	<%
	} else {
	%>
		<ul>
			<li><strong>회원 ID:</strong> <%= user.getUser_id() %></li>
			<li><strong>이름:</strong> <%= user.getUser_name() %></li>
			<li><strong>등급:</strong> <%= user.getUser_rank() %></li>
			<li><strong>가입일:</strong> <%= user.getCreated_at() %></li>
			<li><strong>탈퇴일:</strong> <%= user.getUser_wd_date() %></li>
			<li><strong>탈퇴 사유:</strong> <%= user.getUser_wd_reason() %></li>
			<li><strong>상세 사유:</strong> <%= user.getUser_wd_detail_reason() %></li>
		</ul>
	<%
	}
	%>
</body>
</html>
