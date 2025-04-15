<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="DAO.UserDAO" %>
<%
request.setCharacterEncoding("UTF-8");

String addr_idStr = request.getParameter("addr_id");
String user_id = request.getParameter("user_id");
String user_type = request.getParameter("user_type");

if (addr_idStr != null && user_id != null && user_type != null) {
    int addr_id = Integer.parseInt(addr_idStr);

    UserDAO dao = new UserDAO();
    boolean result = dao.deleteAddr(addr_id);

    if (result) {
%>
<script>
  alert("배송지가 삭제되었습니다.");
  location.href = "userCRM.jsp?user_id=<%=user_id%>&user_type=<%=user_type%>&tab=delivery";
</script>
<%
    } else {
%>
<script>
  alert("기본 배송지는 삭제할 수 없습니다.");
  location.href = "userCRM.jsp?user_id=<%=user_id%>&user_type=<%=user_type%>&tab=delivery";
</script>
<%
    }
} else {
%>
<script>
  alert("잘못된 접근입니다.");
  location.href = "userCRM.jsp?user_id=<%=user_id%>&user_type=<%=user_type%>&tab=delivery";
</script>
<%
}
%>
