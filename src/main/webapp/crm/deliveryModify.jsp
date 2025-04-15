<!-- deliveryModify.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DAO.UserDAO, DTO.UserAddrDTO" %>
<%
request.setCharacterEncoding("UTF-8");
UserDAO dao = new UserDAO();

if ("POST".equals(request.getMethod())) {
    int addr_id = Integer.parseInt(request.getParameter("addr_id"));
    String user_id = request.getParameter("user_id");
    String user_type = request.getParameter("user_type");
    String addr_label = request.getParameter("addr_label");
    String zipcode = request.getParameter("zipcode");
    String address1 = request.getParameter("address1");
    String address2 = request.getParameter("address2");
    String addr_isDefault = request.getParameter("addr_isDefault") != null ? "Y" : "N";

    if ("Y".equals(addr_isDefault)) {
        dao.isDefaultAddr(user_id, user_type); // 기존 기본 배송지 초기화
    }

    UserAddrDTO dto = new UserAddrDTO();
    dto.setAddr_id(addr_id);
    dto.setAddr_label(addr_label);
    dto.setAddr_zipcode(zipcode);
    dto.setAddr_road(address1);
    dto.setAddr_detail(address2);
    dto.setAddr_isDefault(addr_isDefault);

    dao.updateAddr(user_id, user_type, addr_id, dto);
%>
<script>
  alert("배송지 수정이 완료되었습니다.");
  if (window.opener && !window.opener.closed) {
    window.opener.loadTab('delivery');  // 💡 탭을 delivery로 강제 전환
  }
  window.close();
</script>
<%
    return;
} else {
    int addr_id = Integer.parseInt(request.getParameter("addr_id"));
    String user_id = request.getParameter("user_id");
    String user_type = request.getParameter("user_type");

    UserAddrDTO addr = dao.getAddrById(addr_id);
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>배송지 수정</title>
  <link rel="stylesheet" href="CRM.css/deliveryAddMod.css">
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script>
    function execDaumPostcode() {
      new daum.Postcode({
        oncomplete: function(data) {
          document.getElementById("zipcode").value = data.zonecode;
          document.getElementById("address1").value = data.roadAddress;
          document.getElementById("address2").value = "";
          document.getElementById("address2").focus();
        }
      }).open();
    }

    function confirmSubmit() {
      return confirm("저장하시겠습니까?");
    }
  </script>
</head>
<body>

<h3>📦 배송지 정보 수정</h3>

<form method="post" action="deliveryModify.jsp" onsubmit="return confirmSubmit();">
  <input type="hidden" name="addr_id" value="<%=addr.getAddr_id()%>">
  <input type="hidden" name="user_id" value="<%=user_id%>">
  <input type="hidden" name="user_type" value="<%=user_type%>">

  <!-- 배송지 라벨 -->
  <label for="addr_label">배송지 라벨</label>
  <input type="text" id="addr_label" name="addr_label" value="<%=addr.getAddr_label()%>" required>

  <!-- 주소 -->
  <label for="address">주소 <span style="color: red;">*</span></label>
  <div class="address-group">
    <input type="text" id="zipcode" name="zipcode" placeholder="우편번호" value="<%=addr.getAddr_zipcode()%>" readonly>
    <button type="button" id="addrSearch" class="search-btn" onclick="execDaumPostcode()">주소 검색</button>
  </div>
  <input type="text" style="margin-top: 10px" id="address1" name="address1" placeholder="기본 주소" value="<%=addr.getAddr_road()%>" required readonly>
  <input type="text" id="address2" name="address2" placeholder="나머지 주소" value="<%=addr.getAddr_detail()%>">

  <% if (!"Y".equals(addr.getAddr_isDefault())) { %>
    <label style="margin-top: 10px;">
      <input type="checkbox" name="addr_isDefault" value="Y"
        <%= "Y".equals(addr.getAddr_isDefault()) ? "checked" : "" %>>
      기본 배송지로 설정
    </label>
  <% } else { %>
    <input type="hidden" name="addr_isDefault" value="Y">
  <% } %>

  <div class="btn-box">
    <button type="submit">저장</button>
  </div>
</form>

</body>
</html>
<% } %>
