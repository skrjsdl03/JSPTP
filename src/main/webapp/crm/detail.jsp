<!-- detail.jsp -->
<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="DAO.UserDAO, DTO.CRMUserInfoDTO, DTO.UserDTO, DTO.UserAddrDTO"%>
<%
String user_id = request.getParameter("user_id");
String user_type = request.getParameter("user_type");
UserDAO dao = new UserDAO();
CRMUserInfoDTO crm = dao.getCRMUserInfo(user_id, user_type);
UserDTO user = crm.getUser();
UserAddrDTO addr = crm.getAddr();

String[] birthParts = user.getUser_birth() != null ? user.getUser_birth().split("-") : new String[] { "", "", "" };
String birthY = birthParts.length > 0 ? birthParts[0] : "";
String birthM = birthParts.length > 1 ? birthParts[1] : "";
String birthD = birthParts.length > 2 ? birthParts[2] : "";
%>
<div class = "crm-section">
  <h2>👤 회원 정보 수정</h2>
<div class="detail-scroll-area">
  <form action="updateUserInfo.jsp" method="post">
    <input type="hidden" name="user_id" value="<%=user_id%>">
    <input type="hidden" name="user_type" value="<%=user_type%>">

    <table>
      <tr>
        <th>아이디</th>
        <td><input type="text" name="user_id_display" value="<%=user.getUser_id()%>" readonly></td>
        <th>회원등급</th>
        <td>
          <select name="user_rank">
            <option value="그린" <%=user.getUser_rank().equals("그린") ? "selected" : ""%>>그린</option>
            <option value="오렌지" <%=user.getUser_rank().equals("오렌지") ? "selected" : ""%>>오렌지</option>
            <option value="퍼플" <%=user.getUser_rank().equals("퍼플") ? "selected" : ""%>>퍼플</option>
            <option value="에메랄드" <%=user.getUser_rank().equals("에메랄드") ? "selected" : ""%>>에메랄드</option>
            <option value="블랙" <%=user.getUser_rank().equals("블랙") ? "selected" : ""%>>블랙</option>
          </select>
        </td>
      </tr>
      <tr>
        <th>비밀번호</th>
        <td><input type="password" id="password" name="user_pwd"></td>
        <th>계정상태</th>
        <td>
          <select name="user_account_state" id="accountState">
            <option <%=user.getUser_account_state().equals("정상") ? "selected" : ""%>>정상</option>
            <option <%=user.getUser_account_state().equals("휴먼") ? "selected" : ""%>>휴먼</option>
            <option <%=user.getUser_account_state().equals("이용 정지") ? "selected" : ""%>>이용 정지</option>
            <option <%=user.getUser_account_state().equals("탈퇴") ? "selected" : ""%>>탈퇴</option>
            <option <%=user.getUser_account_state().equals("로그인 연속 실패로 인한 잠금") ? "selected" : ""%>>로그인 연속 실패로 인한 잠금</option>
          </select>
        </td>
      </tr>
      <tr>
        <th>비밀번호 확인</th>
        <td>
          <input type="password" id="confirmPassword" name="user_pwd_check">
          <div id="pwCheckMsg" style="font-size: 0.9em; margin-top: 4px;"></div>
        </td>
        <th>잠금여부</th>
        <td>
          <select name="user_lock_state" id="lockState">
            <option value="N" <%=user.getUser_lock_state().equals("N") ? "selected" : ""%>>N</option>
            <option value="Y" <%=user.getUser_lock_state().equals("Y") ? "selected" : ""%>>Y</option>
          </select>
        </td>
      </tr>
      <tr>
        <th>이름</th>
        <td><input type="text" name="user_name" value="<%=user.getUser_name()%>"></td>
        <th>마케팅 수신 동의</th>
        <td>
          <select name="user_marketing_state">
            <option value="N" <%=user.getUser_marketing_state().equals("N") ? "selected" : ""%>>N</option>
            <option value="Y" <%=user.getUser_marketing_state().equals("Y") ? "selected" : ""%>>Y</option>
          </select>
        </td>
      </tr>
      <tr>
        <th>기본 배송지</th>
        <td colspan="3">
          <input type="text" name="addr_road" value="<%=addr != null ? addr.getAddr_road() : ""%>" readonly>
          <input type="text" name="addr_detail" value="<%=addr != null ? addr.getAddr_detail() : ""%>" readonly>
          <button type="button" onclick="loadTab('delivery')">수정</button>
        </td>
      </tr>
      <tr>
        <th>생년월일</th>
        <td colspan="3">
          <div class="birth-container">
            <input type="text" id="birth_y" name="birth_y" maxlength="4" size="4" value="<%=birthY%>" oninput="this.value=this.value.replace(/[^0-9]/g,'')" class="input-short"> -
            <input type="text" id="birth_m" name="birth_m" maxlength="2" size="2" value="<%=birthM%>" oninput="this.value=this.value.replace(/[^0-9]/g,'')" class="input-mini"> -
            <input type="text" id="birth_d" name="birth_d" maxlength="2" size="2" value="<%=birthD%>" oninput="this.value=this.value.replace(/[^0-9]/g,'')" class="input-mini">
          </div>
          <div id="birthError" style="color: red; font-size: 0.9em; margin-top: 4px;"></div>
        </td>
      </tr>
      <tr>
        <th>이메일</th>
        <td colspan="3"><input type="text" name="user_email" value="<%=user.getUser_email()%>"></td>
      </tr>
      <tr>
        <th>전화번호</th>
        <td colspan="3">
          <div>
            010 <span>-</span>
            <input type="text" id="phone1" name="phone1" maxlength="4" value="<%=user.getUser_phone().split("-")[1]%>" oninput="this.value=this.value.replace(/[^0-9]/g,'')" class="input-short">
            <span>-</span>
            <input type="text" id="phone2" name="phone2" maxlength="4" value="<%=user.getUser_phone().split("-")[2]%>" oninput="this.value=this.value.replace(/[^0-9]/g,'')" class="input-short">
          </div>
        </td>
      </tr>
      <tr>
        <th>성별</th>
        <td colspan="3">
          <input type="radio" name="user_gender" value="남자" <%= "남자".equals(user.getUser_gender()) ? "checked" : "" %>> 남자
          <input type="radio" name="user_gender" value="여자" <%= "여자".equals(user.getUser_gender()) ? "checked" : "" %>> 여자
        </td>
      </tr>
      <tr>
        <th>키 / 몸무게</th>
        <td colspan="3">
          <input type="text" id="user_height" name="user_height" maxlength="3" value="<%=user.getUser_height()%>" oninput="this.value=this.value.replace(/[^0-9]/g,'')" class="input-3digit"> cm /
          <input type="text" id="user_weight" name="user_weight" maxlength="3" value="<%=user.getUser_weight()%>" oninput="this.value=this.value.replace(/[^0-9]/g,'')" class="input-3digit"> kg
          <div id="bodyError" style="color: red; font-size: 0.9em; margin-top: 4px;"></div>
        </td>
      </tr>
    </table>

    <div class="btn-submit-wrapper">
  <button type="submit" class="btn-submit">저장</button>
</div>

  </form>
</div>
</div>

