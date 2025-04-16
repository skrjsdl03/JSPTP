<!-- updateUserInfo.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DAO.UserDAO, DTO.UserDTO"%>
<%
request.setCharacterEncoding("UTF-8");

String id = request.getParameter("user_id");
String name = request.getParameter("user_name");
String phone = "010-" + request.getParameter("phone1") + "-" + request.getParameter("phone2");
String email = request.getParameter("user_email");
String gender = request.getParameter("user_gender");
String birth = request.getParameter("birth_y") + "-" + request.getParameter("birth_m") + "-"
        + request.getParameter("birth_d");
String accountState = request.getParameter("user_account_state");
String lockState = request.getParameter("user_lock_state");
String marketingState = request.getParameter("user_marketing_state");
String userRank = request.getParameter("user_rank");

int height = Integer.parseInt(request.getParameter("user_height"));
int weight = Integer.parseInt(request.getParameter("user_weight"));

UserDTO user = new UserDTO();
user.setUser_id(id);
user.setUser_name(name);
user.setUser_phone(phone);
user.setUser_email(email);
user.setUser_gender(gender);
user.setUser_birth(birth);
user.setUser_height(height);
user.setUser_weight(weight);
user.setUser_account_state(accountState);
user.setUser_marketing_state(marketingState);
user.setUser_rank(userRank);

if ("탈퇴".equals(accountState)) {
    user.setUser_lock_state("Y");
    user.setUser_wd_date(new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date()));
    user.setUser_wd_reason("관리자 처리");
    user.setUser_wd_detail_reason("CRM에서 직접 탈퇴 처리됨");
} else {
    user.setUser_lock_state(lockState); // 탈퇴가 아닐 때만 적용
}

// 업데이트 실행
UserDAO dao = new UserDAO();
String type = request.getParameter("user_type");
dao.updateUser(user, id, type);

// 저장 후 메시지 출력 또는 페이지 이동
out.println("<script>");
out.println("alert('회원 정보가 수정되었습니다.');");
out.println("window.location.href = 'userCRM.jsp?user_id=" + id + "&user_type=" + request.getParameter("user_type") + "';");
out.println("</script>");
%>
