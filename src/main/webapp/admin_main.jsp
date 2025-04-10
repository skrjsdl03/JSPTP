<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="DAO.UserDAO, DTO.UserDTO, DTO.OrdersDTO"%>
<%@ page import="java.util.List"%>
<%
UserDAO dao = new UserDAO();
List<OrdersDTO> orderList = null;
int newUser = dao.getTodayNewUserCount();
int orderCount = dao.getTodayOrderCount();
int withdrawalUser = dao.getWithdrawalUserCount();
int totalUser = dao.getTotalUserCount();
String type = request.getParameter("type");
String reason = request.getParameter("reason");
if (type == null)
	type = "order";
int pageSize = 10;
int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
int totalCount = 0;
int totalPage = 0;
List<UserDTO> list = null;
if ("order".equals(type)) {
	totalCount = dao.getTodayOrderCount();
	orderList = dao.getTodayOrderList(currentPage, pageSize);
} else if ("withdrawal".equals(type)) {
	if (reason == null)
		reason = "";
	if (!reason.trim().isEmpty()) {
		list = dao.getWithdrawalUserList(currentPage, pageSize, reason);
		totalCount = list.size();
	} else {
		list = dao.getWithdrawalUserList(currentPage, pageSize);
		totalCount = dao.getWithdrawalUserCount();
	}
} else if ("total".equals(type)) {
	totalCount = dao.getTotalUserCount();
	list = dao.getTotalUserList(currentPage, pageSize);
} else {
	totalCount = dao.getTodayNewUserCount();
	list = dao.getTodayNewUserList(currentPage, pageSize);
}
totalPage = (int) Math.ceil((double) totalCount / pageSize);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 메인 대시보드</title>
<link rel="stylesheet" type="text/css" href="css/admin_main.css">
<script>
	function openPopup(id) {
		const url = "withdrawalDetail.jsp?user_id=" + id;
		window.open(url, "탈퇴회원상세", "width=500,height=500,left=200,top=200");
	}

	function openCRM(id, type) {
		const url = "crm/userCRM.jsp?user_id=" + id + "&user_type=" + type;
		window.open(url, "CRM상세",
				"width=1000,height=700,left=150,top=100,scrollbars=yes");
	}

	window.onload = function() {
		document.getElementById("mainTable").classList.add("show");
	};
</script>
</head>
<body>
	<h2>관리자 메인 대시보드</h2>
	<div class="box">
		<div class="card">
			<h3>신규주문</h3>
			<p class="clickable">
				<a href="admin_main.jsp?type=order&page=1"><%=orderCount%>건</a>
			</p>
		</div>
		<div class="card">
			<h3>신규회원</h3>
			<p class="clickable">
				<a href="admin_main.jsp?type=new&page=1"><%=newUser%>명</a>
			</p>
		</div>
		<div class="card">
			<h3>탈퇴회원</h3>
			<p class="clickable">
				<a href="admin_main.jsp?type=withdrawal&page=1"><%=withdrawalUser%>명</a>
			</p>
		</div>
		<div class="card">
			<h3>총 회원</h3>
			<p class="clickable">
				<a href="admin_main.jsp?type=total&page=1"><%=totalUser%>명</a>
			</p>
		</div>
	</div>

	<table id="mainTable" class="user-table">
		<thead>
			<%
			if ("order".equals(type)) {
			%>
			<tr>
				<th colspan="7" style="text-align: left;">※ 오늘 주문된 주문 목록입니다.</th>
			</tr>
			<tr>
				<th>No.</th>
				<th>주문번호</th>
				<th>주문자</th>
				<th>전화번호</th>
				<th>회원여부</th>
				<th>주문일시</th>
				<th>금액</th>
			</tr>
			<%
			} else if ("withdrawal".equals(type)) {
			%>
			<tr>
				<th colspan="7">
					<div
						style="display: flex; justify-content: space-between; align-items: center;">
						<span>※ 탈퇴회원 목록입니다.</span>
						<form method="get" action="admin_main.jsp" style="margin: 0;">
							<input type="hidden" name="type" value="withdrawal" /> <select
								name="reason" onchange="this.form.submit()">
								<option value="" <%=reason.equals("") ? "selected" : ""%>>전체
									사유</option>
								<option value="쇼핑몰 이용이 불편함"
									<%=reason.equals("쇼핑몰 이용이 불편함") ? "selected" : ""%>>쇼핑몰
									이용이 불편함</option>
								<option value="원하는 상품 부족"
									<%=reason.equals("원하는 상품 부족") ? "selected" : ""%>>원하는
									상품 부족</option>
								<option value="개인정보 보안 우려"
									<%=reason.equals("개인정보 보안 우려") ? "selected" : ""%>>개인정보
									보안 우려</option>
								<option value="마케팅 메시지 과다 수신"
									<%=reason.equals("마케팅 메시지 과다 수신") ? "selected" : ""%>>마케팅
									메시지 과다 수신</option>
								<option value="단순 변심 / 더 이상 이용하지 않음"
									<%=reason.equals("단순 변심 / 더 이상 이용하지 않음") ? "selected" : ""%>>단순
									변심</option>
								<option value="기타" <%=reason.equals("기타") ? "selected" : ""%>>기타</option>
							</select>
						</form>
					</div>
				</th>
			</tr>
			<tr>
				<th>No.</th>
				<th>회원 ID</th>
				<th>이름</th>
				<th>등급</th>
				<th>탈퇴일</th>
				<th>탈퇴 사유</th>
				<th>상세 사유</th>
			</tr>
			<%
			} else if ("total".equals(type)) {
			%>
			<tr>
				<th colspan="9" style="text-align: left;">※ 전체 회원 목록입니다.</th>
			</tr>
			<tr>
				<th>No.</th>
				<th>회원ID</th>
				<th>유형</th>
				<th>이름</th>
				<th>등급</th>
				<th>가입일</th>
				<th>상태</th>
				<th>포인트</th>
				<th>마케팅 수신</th>
			</tr>
			<%
			} else {
			%>
			<tr>
				<th colspan="7" style="text-align: left;">※ 오늘 가입한 신규회원 목록입니다.</th>
			</tr>
			<tr>
				<th>No.</th>
				<th>회원ID</th>
				<th>유형</th>
				<th>이름</th>
				<th>성별</th>
				<th>가입일</th>
				<th>마케팅 수신</th>
			</tr>
			<%
			}
			%>
		</thead>
		<tbody>
			<%
			int no = (currentPage - 1) * pageSize + 1;
			if ("order".equals(type) && orderList != null && !orderList.isEmpty()) {
				for (OrdersDTO order : orderList) {
			%>
			<tr>
				<td><%=no++%></td>
				<td><%=order.getO_num()%></td>
				<td><%=order.getO_name()%></td>
				<td><%=order.getO_phone()%></td>
				<td><%=order.getO_isMember()%></td>
				<td><%=order.getCreated_at()%></td>
				<td><%=order.getO_total_amount()%>원</td>
			</tr>
			<%
			}
			} else if ("withdrawal".equals(type) && list != null && !list.isEmpty()) {
			for (UserDTO user : list) {
			%>
			<tr onclick="openPopup('<%=user.getUser_id()%>')"
				style="cursor: pointer;">
				<td><%=no++%></td>
				<td><%=user.getUser_id()%></td>
				<td><%=user.getUser_name()%></td>
				<td><%=user.getUser_rank()%></td>
				<td><%=user.getUser_wd_date()%></td>
				<td><%=user.getUser_wd_reason() == null ? "-" : user.getUser_wd_reason()%></td>
				<td>
					<%
					String detail = user.getUser_wd_detail_reason();
					out.print(detail == null || detail.trim().isEmpty() ? "-"
							: (detail.length() > 20 ? detail.substring(0, 20) + "..." : detail));
					%>
				</td>
			</tr>
			<%
			}
			} else if ("total".equals(type) && list != null && !list.isEmpty()) {
			for (UserDTO user : list) {
			%>
			<tr
				onclick="openCRM('<%=user.getUser_id()%>', '<%=user.getUser_type()%>')"
				style="cursor: pointer;">
				<td><%=no++%></td>
				<td><%=user.getUser_id()%></td>
				<td><%=user.getUser_type()%></td>
				<td><%=user.getUser_name()%></td>
				<td><%=user.getUser_rank()%></td>
				<td><%=user.getCreated_at()%></td>
				<td><%=user.getUser_account_state()%></td>
				<td><%=user.getUser_point()%>P</td>
				<td><%=user.getUser_marketing_state()%></td>
			</tr>
			<%
			}
			}
			// 			신규회원 목록 출력
			else if (list != null && !list.isEmpty()) {
			for (UserDTO user : list) {
			%>
			<tr
				onclick="openCRM('<%=user.getUser_id()%>', '<%=user.getUser_type()%>')"
				style="cursor: pointer;">
				<td><%=no++%></td>
				<td><%=user.getUser_id()%></td>
				<td><%=user.getUser_type()%></td>
				<td><%=user.getUser_name()%></td>
				<td><%=user.getUser_gender()%></td>
				<td><%=user.getCreated_at()%></td>
				<td><%=user.getUser_marketing_state()%></td>
			</tr>
			<%
			}
			} else {
			%>
			<tr>
				<td colspan="10" style="text-align: center;">표시할 데이터가 없습니다.</td>
			</tr>
			<%
			}
			%>
		</tbody>
	</table>

	<div style="text-align: center; margin-top: 20px;">
		<%
		for (int i = 1; i <= totalPage; i++) {
		%>
		<%=(i == currentPage) ? ("<strong>" + i + "</strong>")
		: ("<a href='admin_main.jsp?type=" + type + "&page=" + i + "'>" + i + "</a>")%>&nbsp;
		<%
		}
		%>
	</div>
</body>
</html>
