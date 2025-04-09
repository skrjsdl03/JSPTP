<%@page import="DTO.NoticeDTO"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<jsp:useBean id="nDao" class="DAO.NoticeDAO"/>
<%
    Vector<NoticeDTO> nIlist = nDao.showImpNotice();      // 중요 공지 리스트
    Vector<NoticeDTO> nNIlist = nDao.showNotImpNotice();  // 일반 공지 리스트
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>에브리웨어 | everyWEAR</title>
<link rel="icon" type="image/png" href="images/fav-icon.png">
<link rel="stylesheet" type="text/css" href="css/board.css?v=789">
</head>
<body>

<%@ include file="includes/boardHeader.jsp"%>

<section2 class="content2">
    <h3>BOARD</h3>
</section2>

<div class="container">
    <aside class="sidebar2">
        <ul>
            <li><a href="board.jsp?reload=true">BOARD</a></li>
            <li><a href="FAQ.jsp">FAQ</a></li>
            <li><a href="Q&A.jsp">Q&A</a></li>
            <li><a href="review.jsp">REVIEW</a></li>
        </ul>
    </aside>

    <section class="content">
        <table class="notice-table" id="notice-table">
            <tbody>
                <%-- 중요 공지사항은 항상 보이도록 출력 --%>
                <% for (int i = 0; i < nIlist.size(); i++) {
                    NoticeDTO notice = nIlist.get(i);
                %>
                    <tr class="important">
                        <td class="title"><a href="noticeRead.jsp?noti_id=<%=notice.getNoti_id()%>"> ※ <%=notice.getNoti_title()%></a></td>
                        <td class="date"><%=notice.getCreated_at()%></td>
                        <td class="views">조회수: <%=notice.getNoti_views()%></td>
                    </tr>
                <% } %>

                <%-- 일반 공지사항은 class="normal"로 지정해서 JS로 페이징 처리 --%>
                <% for (int i = 0; i < nNIlist.size(); i++) {
                    NoticeDTO notice = nNIlist.get(i);
                %>
                    <tr class="normal">
                        <td class="title"><a href="noticeRead.jsp?noti_id=<%=notice.getNoti_id()%>"><%=notice.getNoti_title()%></a></td>
                        <td class="date"><%=notice.getCreated_at()%></td>
                        <td class="views">조회수: <%=notice.getNoti_views()%></td>
                    </tr>
                <% } %>
            </tbody>
        </table>

        <%-- 페이징 영역 추가 --%>
        <div class="pagination" id="pagination"></div>

        <div class="footer-bottom">
            <p>2025&copy;everyWEAR</p>
        </div>
    </section>
</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
    const rowsPerPage = 7; // 한 페이지당 7개씩
    const allRows = document.querySelectorAll("#notice-table tbody tr");

    // 중요 공지와 일반 공지를 분리
    const normalRows = Array.from(allRows).filter(row => row.classList.contains("normal"));
    const importantRows = Array.from(allRows).filter(row => row.classList.contains("important"));

    const totalPages = Math.ceil(normalRows.length / rowsPerPage);
    const pagination = document.getElementById("pagination");

    let currentPage = 1;

    function showPage(page) {
        const start = (page - 1) * rowsPerPage;
        const end = start + rowsPerPage;

        // 일반 공지를 페이징 처리
        normalRows.forEach((row, index) => {
            row.style.display = (index >= start && index < end) ? "" : "none";
        });

        // 중요 공지는 항상 표시
        importantRows.forEach(row => {
            row.style.display = "";
        });

        updatePagination(page);
    }

    function updatePagination(activePage) {
        pagination.innerHTML = ""; // 기존 페이지 초기화

        // Prev 버튼
        const prev = document.createElement("span");
        prev.textContent = "Prev";
        prev.onclick = () => {
            if (currentPage > 1) {
                currentPage--;
                showPage(currentPage);
            }
        };
        pagination.appendChild(prev);

        // 페이지 숫자들
        for (let i = 1; i <= totalPages; i++) {
            const span = document.createElement("span");
            span.textContent = i;
            if (i === activePage) span.classList.add("active");
            span.onclick = () => {
                currentPage = i;
                showPage(currentPage);
            };
            pagination.appendChild(span);
        }

        // Next 버튼
        const next = document.createElement("span");
        next.textContent = "Next";
        next.onclick = () => {
            if (currentPage < totalPages) {
                currentPage++;
                showPage(currentPage);
            }
        };
        pagination.appendChild(next);
    }

    // 첫 페이지 보여주기
    showPage(currentPage);
});
</script>

</body>
</html>
