<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="DAO.NoticeDAO" %>
<%@ page import="DTO.NoticeDTO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>공지사항 상세 | everyWEAR</title>
<link rel="icon" type="image/png" href="images/fav-icon.png">
<link rel="stylesheet" type="text/css" href="css/admin_notice.css">
<style>
    .notice-view {
        margin-top: 20px;
    }
    
    .notice-view .notice-header {
        border-bottom: 1px solid #ddd;
        padding-bottom: 15px;
        margin-bottom: 20px;
    }
    
    .notice-view .notice-title {
        font-size: 20px;
        font-weight: bold;
        margin-bottom: 10px;
    }
    
    .notice-view .notice-info {
        color: #777;
        font-size: 14px;
    }
    
    .notice-view .notice-info span {
        margin-right: 15px;
    }
    
    .notice-view .notice-content {
        min-height: 300px;
        line-height: 1.6;
        margin-bottom: 30px;
        white-space: pre-line;  /* 줄바꿈 유지 */
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
<%
    // 공지사항 ID 가져오기
    String noticeIdStr = request.getParameter("id");
    int noticeId = 0;
    NoticeDTO notice = null;
    
    try {
        noticeId = Integer.parseInt(noticeIdStr);
        
        // 공지사항 데이터 가져오기
        NoticeDAO noticeDAO = new NoticeDAO();
        notice = noticeDAO.getNotice(noticeId);
        
    } catch (Exception e) {
        e.printStackTrace();
    }
    
    // 공지사항이 없는 경우 목록으로 이동
    if (notice == null) {
        response.sendRedirect("admin_notice.jsp");
        return;
    }
    
    // 날짜 포맷 설정
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String formattedDate = "";
    try {
        formattedDate = sdf.format(sdf.parse(notice.getCreated_at()));
    } catch (Exception e) {
        formattedDate = notice.getCreated_at();
    }
    
    boolean isPinned = "Y".equals(notice.getNoti_isPinned());
%>

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
            <h2>공지사항 상세</h2>
            
            <div class="notice-view">
                <div class="notice-header">
                    <div class="notice-title">
                        <% if (isPinned) { %>
                        <span class="badge important">중요</span>
                        <% } %>
                        <%= notice.getNoti_title() %>
                    </div>
                    <div class="notice-info">
                        <span>등록일: <%= formattedDate %></span>
                        <span>조회수: <%= notice.getNoti_views() %></span>
                        <span>작성자: 관리자(<%= notice.getAdmin_id() %>)</span>
                    </div>
                </div>
                
                <div class="notice-content">
                    <%= notice.getContent() %>
                </div>
            </div>
            
            <div class="button-group">
                <button class="btn btn-primary" onclick="location.href='admin_notice.jsp'">목록</button>
                <button class="btn" onclick="editNotice(<%= notice.getNoti_id() %>)">수정</button>
                <button class="btn btn-danger" onclick="deleteNotice(<%= notice.getNoti_id() %>)">삭제</button>
            </div>
        </div>
    </main>

    <!-- 삭제 확인 모달 -->
    <div id="deleteModal" class="modal">
        <div class="modal-content confirm-modal">
            <div class="modal-header">
                <h3>삭제 확인</h3>
                <span class="close">&times;</span>
            </div>
            <div class="modal-body">
                <p>이 공지사항을 삭제하시겠습니까?</p>
                <form id="deleteForm" action="NoticeServlet" method="post">
                    <input type="hidden" id="deleteId" name="deleteIds" value="<%= notice.getNoti_id() %>">
                    <input type="hidden" name="action" value="delete">
                    <div class="form-actions">
                        <button type="button" id="cancelDeleteBtn" class="btn">취소</button>
                        <button type="submit" class="btn btn-danger">삭제</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
    document.addEventListener("DOMContentLoaded", function() {
        const deleteModal = document.getElementById("deleteModal");
        const closeBtn = document.querySelector(".close");
        const cancelDeleteBtn = document.getElementById("cancelDeleteBtn");
        
        // 삭제 모달 닫기
        function closeModal() {
            deleteModal.style.display = "none";
        }
        
        closeBtn.addEventListener("click", closeModal);
        cancelDeleteBtn.addEventListener("click", closeModal);
        
        // 모달 외부 클릭 시 닫기
        window.addEventListener("click", function(event) {
            if (event.target === deleteModal) {
                closeModal();
            }
        });
    });
    
    // 공지사항 수정 페이지로 이동
    function editNotice(noticeId) {
        // 수정을 위한 폼 전송
        const form = document.createElement("form");
        form.method = "GET";
        form.action = "admin_notice.jsp";
        
        const actionInput = document.createElement("input");
        actionInput.type = "hidden";
        actionInput.name = "edit";
        actionInput.value = "true";
        
        const idInput = document.createElement("input");
        idInput.type = "hidden";
        idInput.name = "id";
        idInput.value = noticeId;
        
        form.appendChild(actionInput);
        form.appendChild(idInput);
        document.body.appendChild(form);
        form.submit();
    }
    
    // 삭제 모달 열기
    function deleteNotice(noticeId) {
        document.getElementById("deleteId").value = noticeId;
        document.getElementById("deleteModal").style.display = "block";
    }
    </script>

</body>
</html> 