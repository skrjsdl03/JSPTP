<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="DTO.NoticeDTO, DAO.NoticeDAO, DAO.AdminDAO" %>
<%
    // 공지사항 ID 가져오기
    int noticeId = 0;
    try {
        noticeId = Integer.parseInt(request.getParameter("id"));
    } catch (Exception e) {
        response.sendRedirect("admin_notice.jsp");
        return;
    }
    
    // 공지사항 상세 정보 가져오기 (관리자용)
    NoticeDAO noticeDAO = new NoticeDAO();
    NoticeDTO notice = noticeDAO.getNoticeForAdmin(noticeId);
    
    if (notice == null) {
        response.sendRedirect("admin_notice.jsp");
        return;
    }
    
    // 작성자 이름 가져오기
    AdminDAO adminDAO = new AdminDAO();
    String adminId = notice.getAdmin_id();
    String adminName = adminDAO.getAdminName(adminId);
    
    // 공지사항 정보 설정
    String title = notice.getNoti_title();
    String content = notice.getContent();
    String isPinned = notice.getNoti_isPinned();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>공지사항 수정 | everyWEAR</title>
<link rel="icon" type="image/png" href="images/fav-icon.png">
<link rel="stylesheet" type="text/css" href="css/admin_notice.css">
<style>
    .form-container {
        max-width: 800px;
        margin: 0 auto;
        padding: 20px;
    }
    
    .form-group {
        margin-bottom: 20px;
    }
    
    .form-group label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
    }
    
    .form-group input[type="text"] {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
    }
    
    .form-group textarea {
        width: 100%;
        height: 300px;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        resize: vertical;
        white-space: pre-wrap;
        font-family: Arial, sans-serif;
        font-size: 14px;
        line-height: 1.5;
    }
    
    .radio-group {
        display: flex;
        gap: 20px;
    }
    
    .button-group {
        display: flex;
        justify-content: center;
        gap: 15px;
        margin-top: 30px;
    }
</style>
</head>
<body>

    <header>
        <div class="header-container">
            <h1>관리자 페이지</h1>
            <nav>
                <ul>
                    <li><a href="admin_main.jsp">대시보드</a></li>
                    <li><a href="admin_notice.jsp" class="active">공지사항 관리</a></li>
                    <li><a href="#">회원 관리</a></li>
                    <li><a href="#">상품 관리</a></li>
                    <li><a href="#">주문 관리</a></li>
                    <li><a href="#">문의 관리</a></li>
                    <li><a href="logout.jsp">로그아웃</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <main>
        <div class="container">
            <h2>공지사항 수정</h2>
            
            <div class="form-container">
                <form action="NoticeServlet" method="post">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="noticeId" value="<%= noticeId %>">
                    
                    <div class="form-group">
                        <label for="noticeTitle">제목</label>
                        <input type="text" id="noticeTitle" name="noticeTitle" value="<%= title %>" required>
                    </div>
                    
                    <div class="form-group">
                        <label>작성자</label>
                        <div style="padding: 10px; background-color: #f5f5f5; border-radius: 4px;">
                            <%= adminName %> (<%= adminId %>)
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="noticeContent">내용</label>
                        <textarea id="noticeContent" name="noticeContent" required><%= content.replace("<", "&lt;").replace(">", "&gt;") %></textarea>
                    </div>
                    
                    <div class="form-group">
                        <label>공지 상태</label>
                        <div class="radio-group">
                            <label>
                                <input type="radio" name="noticeStatus" value="N" <%= "N".equals(isPinned) ? "checked" : "" %>> 일반
                            </label>
                            <label>
                                <input type="radio" name="noticeStatus" value="Y" <%= "Y".equals(isPinned) ? "checked" : "" %>> 중요
                            </label>
                        </div>
                    </div>
                    
                    <div class="button-group">
                        <button type="button" class="btn" onclick="location.href='admin_notice_view.jsp?id=<%= noticeId %>'">취소</button>
                        <button type="submit" class="btn btn-primary">저장</button>
                    </div>
                </form>
            </div>
        </div>
    </main>
</body>
</html> 