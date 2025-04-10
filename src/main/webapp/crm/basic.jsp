<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="DAO.UserDAO, DTO.CRMUserInfoDTO, DTO.UserDTO, DTO.UserAddrDTO"%>
<%
String user_id = request.getParameter("user_id");
String user_type = request.getParameter("user_type");

UserDAO dao = new UserDAO();
CRMUserInfoDTO crm = dao.getCRMUserInfo(user_id, user_type);

UserDTO user = crm.getUser();
UserAddrDTO addr = crm.getAddr();
%>

<div class="crm-section">
	<h3>👤 기본 정보 요약</h3>
	<table>
		<tr>
			<th>아이디</th>
			<td><%=user.getUser_id()%></td>
			<th>이름</th>
			<td><%=user.getUser_name()%></td>
		</tr>
		<tr>
			<th>성별</th>
			<td><%=user.getUser_gender()%></td>
			<th>생년월일</th>
			<td><%=user.getUser_birth()%></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><%=user.getUser_email() == null ? "-" : user.getUser_email()%></td>
			<th>이메일 인증 여부</th>
			<td><%=crm.isEmailVerified() ? "✅ 인증됨" : "❌ 미인증"%></td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td><%=user.getUser_phone()%></td>
			<th>가입일</th>
			<td><%=user.getCreated_at()%></td>
		</tr>
		<tr>
			<th>회원등급</th>
			<td><%=user.getUser_rank()%></td>
			<th>계정상태</th>
			<td><%=user.getUser_account_state()%></td>
		</tr>
		<tr>
			<th>잠금여부</th>
			<td><%=user.getUser_lock_state()%></td>
			<th>마케팅 수신</th>
			<td><%=user.getUser_marketing_state()%></td>
		</tr>
		<tr>
			<th>키 / 몸무게</th>
			<td colspan="3"><%=user.getUser_height()%>cm / <%=user.getUser_weight()%>kg</td>
		</tr>
		<tr>
			<th>기본 주소</th>
			<td colspan="3"><%=addr != null ? addr.getAddr_road() + " " + addr.getAddr_detail() : "-"%></td>
		</tr>
		<tr>
			<th>총 결제 금액</th>
			<td><%=crm.getTotalOrderAmount()%>원</td>
			<th>최근 로그인</th>
			<td><%=crm.getLastLoginDate() != null ? crm.getLastLoginDate() : "-"%></td>
		</tr>
	</table>
</div>