<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="DAO.UserDAO" %>

<%
    UserDAO dao = new UserDAO();
    int newUser = dao.getTodayNewUserCount();
    int visitUser = dao.getTodayVisitUserCount();
    int withdrawalUser = dao.getWithdrawalUserCount();
    int totalUser = dao.getTotalUserCount();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 메인</title>
    <link rel="stylesheet" type="text/css" href="css/admin_main.css">
</head>
<body>

    <h2>관리자 메인 대시보드</h2>

    <div class="box">
        <div class="card">
            <h3>신규회원</h3>
            <p><%= newUser %>명</p>
        </div>
        <div class="card">
            <h3>방문회원</h3>
            <p><%= visitUser %>명</p>
        </div>
        <div class="card">
            <h3>탈퇴회원</h3>
            <p><%= withdrawalUser %>명</p>
        </div>
        <div class="card">
            <h3>총 회원</h3>
            <p><%= totalUser %>명</p>
        </div>
    </div>

</body>
</html>
