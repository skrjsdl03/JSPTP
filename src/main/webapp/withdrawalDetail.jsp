<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="DAO.UserDAO, DTO.UserDTO"%>

<%
request.setCharacterEncoding("UTF-8");

String user_id = request.getParameter("user_id");
String action = request.getParameter("action");
UserDTO user = null;

if (user_id != null && !user_id.trim().isEmpty()) {
	UserDAO dao = new UserDAO();

	// 복구 처리 로직
	if ("restore".equals(action)) {
		dao.restoreWithdrawnUser(user_id);
		out.println("<script>");
		out.println("alert('정상회원으로 복구되었습니다.');");
		out.println("window.opener.location.reload();"); // 부모창 새로고침
		out.println("window.close();"); // 현재창 닫기
		out.println("</script>");
		return;
	}

	user = dao.getWithdrawalDetail(user_id);
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
		<li><strong>회원 ID:</strong> <%=user.getUser_id()%></li>
		<li><strong>이름:</strong> <%=user.getUser_name()%></li>
		<li><strong>등급:</strong> <%=user.getUser_rank()%></li>
		<li><strong>가입일:</strong> <%=user.getCreated_at()%></li>
		<li><strong>탈퇴일:</strong> <%=user.getUser_wd_date()%></li>
		<li><strong>탈퇴 사유:</strong> <%=user.getUser_wd_reason()%></li>
		<li><strong>상세 사유:</strong> <%=user.getUser_wd_detail_reason()%></li>
	</ul>
	<form method="post" onsubmit="return confirm('정상회원으로 복구시키겠습니까?');">
		<input type="hidden" name="action" value="restore">
		<button type="submit"
			style="padding: 10px 20px; background-color: #1abc9c; color: white; border: none; border-radius: 5px; cursor: pointer;">
			정상회원으로 전환</button>
	</form>

	<%
	}
	%>
</body>
</html>
