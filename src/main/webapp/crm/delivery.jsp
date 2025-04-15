<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="DAO.UserDAO, DTO.UserAddrDTO"%>
<%@ page import="java.util.Vector"%>
<%
String user_id = request.getParameter("user_id");
String user_type = request.getParameter("user_type");

UserDAO dao = new UserDAO();
UserAddrDTO defaultAddr = dao.showOneAddr(user_id, user_type);
Vector<UserAddrDTO> addrList = dao.showRestAddr(user_id, user_type);
%>

<div class="crm-section">
  <h2>📦 배송지 정보</h2>
  <div class="delivery-scroll-area">

    <% if (defaultAddr != null) { %>
    <div class="delivery-box">
      <div class="delivery-top" style="display: flex; justify-content: space-between; align-items: center;">
        <div>
          <strong><%=defaultAddr.getAddr_label()%></strong>
          <span style="color: white; background: #2ecc71; font-size: 12px; padding: 2px 6px; border-radius: 4px; margin-left: 8px;">기본배송지</span>
        </div>
        <div class="action-group">
          <button class="btn-edit"
            onclick="openModifyPopup(<%=defaultAddr.getAddr_id()%>)">수정</button>
          <button class="btn-delete"
            onclick="deleteAddr(<%=defaultAddr.getAddr_id()%>)">삭제</button>
        </div>
      </div>
      <div class="delivery-inputs">
        <input class="input-zipcode" type="text" value="<%=defaultAddr.getAddr_zipcode()%>" readonly>
        <input class="input-full" type="text" value="<%=defaultAddr.getAddr_road()%> <%=defaultAddr.getAddr_detail()%>" readonly>
      </div>
    </div>
    <% } %>

    <hr style="border: none; border-top: 1px solid #ccc; margin: 20px 0;">

    <% for (UserAddrDTO addr : addrList) { %>
    <div class="delivery-box">
      <div class="delivery-top" style="display: flex; justify-content: space-between; align-items: center;">
        <strong><%=addr.getAddr_label()%></strong>
        <div class="action-group">
          <button class="btn-edit"
            onclick="openModifyPopup(<%=addr.getAddr_id()%>)">수정</button>
          <button class="btn-delete"
            onclick="deleteAddr(<%=addr.getAddr_id()%>)">삭제</button>
        </div>
      </div>
      <div class="delivery-inputs">
        <input class="input-zipcode" type="text" value="<%=addr.getAddr_zipcode()%>" readonly>
        <input class="input-full" type="text" value="<%=addr.getAddr_road()%> <%=addr.getAddr_detail()%>" readonly>
      </div>
    </div>
    <% } %>

  </div>
   <div class="btn-add-wrapper">
  <button type="button" class="btn-edit" onclick="openAddPopup()">+ 배송지 추가하기</button>
</div>


</div>
