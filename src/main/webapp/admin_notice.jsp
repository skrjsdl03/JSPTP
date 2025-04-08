<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>관리자 공지사항 | everyWEAR</title>
<link rel="icon" type="image/png" href="images/fav-icon.png">
<link rel="stylesheet" type="text/css" href="css/admin_notice.css">
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
            <h2>공지사항 관리</h2>
            
            <div class="notice-control">
                <button id="addNoticeBtn" class="btn btn-primary">새 공지사항 작성</button>
                <div class="search-box">
                    <select id="searchType">
                        <option value="title">제목</option>
                        <option value="content">내용</option>
                    </select>
                    <input type="text" id="searchKeyword" placeholder="검색어 입력">
                    <button id="searchBtn" class="btn">검색</button>
                </div>
            </div>
            
            <table class="notice-table" id="notice-table">
                <thead>
                    <tr>
                        <th class="checkbox"><input type="checkbox" id="selectAll"></th>
                        <th class="no">No</th>
                        <th class="title">제목</th>
                        <th class="date">등록일</th>
                        <th class="views">조회수</th>
                        <th class="status">상태</th>
                        <th class="actions">관리</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><input type="checkbox" class="notice-check"></td>
                        <td>10</td>
                        <td>이용 안내</td>
                        <td>2025-03-30</td>
                        <td>56</td>
                        <td><span class="badge important">중요</span></td>
                        <td>
                            <button class="btn btn-sm btn-edit">수정</button>
                            <button class="btn btn-sm btn-delete">삭제</button>
                        </td>
                    </tr>
                    <tr>
                        <td><input type="checkbox" class="notice-check"></td>
                        <td>9</td>
                        <td>일부 지역 배송 제한 안내</td>
                        <td>2025-03-25</td>
                        <td>42</td>
                        <td><span class="badge important">중요</span></td>
                        <td>
                            <button class="btn btn-sm btn-edit">수정</button>
                            <button class="btn btn-sm btn-delete">삭제</button>
                        </td>
                    </tr>
                    <tr>
                        <td><input type="checkbox" class="notice-check"></td>
                        <td>8</td>
                        <td>4월 신상품 입고 안내</td>
                        <td>2025-03-20</td>
                        <td>78</td>
                        <td><span class="badge normal">일반</span></td>
                        <td>
                            <button class="btn btn-sm btn-edit">수정</button>
                            <button class="btn btn-sm btn-delete">삭제</button>
                        </td>
                    </tr>
                    <tr>
                        <td><input type="checkbox" class="notice-check"></td>
                        <td>7</td>
                        <td>시스템 점검 안내</td>
                        <td>2025-03-15</td>
                        <td>35</td>
                        <td><span class="badge normal">일반</span></td>
                        <td>
                            <button class="btn btn-sm btn-edit">수정</button>
                            <button class="btn btn-sm btn-delete">삭제</button>
                        </td>
                    </tr>
                    <tr>
                        <td><input type="checkbox" class="notice-check"></td>
                        <td>6</td>
                        <td>회원 등급 혜택 변경 안내</td>
                        <td>2025-03-10</td>
                        <td>64</td>
                        <td><span class="badge normal">일반</span></td>
                        <td>
                            <button class="btn btn-sm btn-edit">수정</button>
                            <button class="btn btn-sm btn-delete">삭제</button>
                        </td>
                    </tr>
                    <tr>
                        <td><input type="checkbox" class="notice-check"></td>
                        <td>5</td>
                        <td>3월 이벤트 당첨자 발표</td>
                        <td>2025-03-05</td>
                        <td>93</td>
                        <td><span class="badge normal">일반</span></td>
                        <td>
                            <button class="btn btn-sm btn-edit">수정</button>
                            <button class="btn btn-sm btn-delete">삭제</button>
                        </td>
                    </tr>
                    <tr>
                        <td><input type="checkbox" class="notice-check"></td>
                        <td>4</td>
                        <td>봄 시즌 할인 이벤트</td>
                        <td>2025-02-28</td>
                        <td>112</td>
                        <td><span class="badge normal">일반</span></td>
                        <td>
                            <button class="btn btn-sm btn-edit">수정</button>
                            <button class="btn btn-sm btn-delete">삭제</button>
                        </td>
                    </tr>
                </tbody>
            </table>
            
            <div class="notice-actions">
                <button id="deleteSelectedBtn" class="btn btn-danger">선택 삭제</button>
                <button id="setImportantBtn" class="btn">중요 설정</button>
                <button id="setNormalBtn" class="btn">일반 설정</button>
            </div>
            
            <div class="pagination" id="pagination">
                <span>Prev</span>
                <span class="active">1</span>
                <span>2</span>
                <span>3</span>
                <span>4</span>
                <span>5</span>
                <span>Next</span>
            </div>
        </div>
    </main>

    <!-- 공지사항 작성/수정 모달 -->
    <div id="noticeModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 id="modalTitle">공지사항 작성</h3>
                <span class="close">&times;</span>
            </div>
            <div class="modal-body">
                <form id="noticeForm">
                    <div class="form-group">
                        <label for="noticeTitle">제목</label>
                        <input type="text" id="noticeTitle" name="noticeTitle" placeholder="제목을 입력하세요" required>
                    </div>
                    <div class="form-group">
                        <label for="noticeContent">내용</label>
                        <textarea id="noticeContent" name="noticeContent" rows="10" placeholder="내용을 입력하세요" required></textarea>
                    </div>
                    <div class="form-group">
                        <label>공지 상태</label>
                        <div class="radio-group">
                            <label>
                                <input type="radio" name="noticeStatus" value="normal" checked> 일반
                            </label>
                            <label>
                                <input type="radio" name="noticeStatus" value="important"> 중요
                            </label>
                        </div>
                    </div>
                    <div class="form-actions">
                        <button type="button" id="cancelBtn" class="btn">취소</button>
                        <button type="submit" id="saveNoticeBtn" class="btn btn-primary">저장</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- 삭제 확인 모달 -->
    <div id="deleteModal" class="modal">
        <div class="modal-content confirm-modal">
            <div class="modal-header">
                <h3>삭제 확인</h3>
                <span class="close">&times;</span>
            </div>
            <div class="modal-body">
                <p>선택한 공지사항을 삭제하시겠습니까?</p>
                <div class="form-actions">
                    <button type="button" id="cancelDeleteBtn" class="btn">취소</button>
                    <button type="button" id="confirmDeleteBtn" class="btn btn-danger">삭제</button>
                </div>
            </div>
        </div>
    </div>

    <script>
    document.addEventListener("DOMContentLoaded", function() {
        // 모달 관련 요소
        const noticeModal = document.getElementById("noticeModal");
        const deleteModal = document.getElementById("deleteModal");
        const addNoticeBtn = document.getElementById("addNoticeBtn");
        const modalCloseButtons = document.querySelectorAll(".close");
        const cancelBtn = document.getElementById("cancelBtn");
        const modalTitle = document.getElementById("modalTitle");
        const noticeForm = document.getElementById("noticeForm");
        
        // 체크박스 관련
        const selectAllCheckbox = document.getElementById("selectAll");
        const noticeCheckboxes = document.querySelectorAll(".notice-check");
        
        // 버튼 관련
        const deleteSelectedBtn = document.getElementById("deleteSelectedBtn");
        const setImportantBtn = document.getElementById("setImportantBtn");
        const setNormalBtn = document.getElementById("setNormalBtn");
        const editButtons = document.querySelectorAll(".btn-edit");
        const deleteButtons = document.querySelectorAll(".btn-delete");
        const cancelDeleteBtn = document.getElementById("cancelDeleteBtn");
        const confirmDeleteBtn = document.getElementById("confirmDeleteBtn");
        
        // 모달 열기
        addNoticeBtn.addEventListener("click", function() {
            modalTitle.textContent = "공지사항 작성";
            noticeForm.reset();
            noticeModal.style.display = "block";
        });
        
        // 모달 닫기
        modalCloseButtons.forEach(function(btn) {
            btn.addEventListener("click", function() {
                noticeModal.style.display = "none";
                deleteModal.style.display = "none";
            });
        });
        
        cancelBtn.addEventListener("click", function() {
            noticeModal.style.display = "none";
        });
        
        cancelDeleteBtn.addEventListener("click", function() {
            deleteModal.style.display = "none";
        });
        
        // 모달 외부 클릭 시 닫기
        window.addEventListener("click", function(event) {
            if (event.target === noticeModal) {
                noticeModal.style.display = "none";
            }
            if (event.target === deleteModal) {
                deleteModal.style.display = "none";
            }
        });
        
        // 체크박스 전체 선택/해제
        selectAllCheckbox.addEventListener("change", function() {
            noticeCheckboxes.forEach(function(checkbox) {
                checkbox.checked = selectAllCheckbox.checked;
            });
        });
        
        // 수정 버튼 클릭
        editButtons.forEach(function(btn) {
            btn.addEventListener("click", function() {
                const row = this.closest("tr");
                const title = row.querySelector("td:nth-child(3)").textContent;
                const isImportant = row.querySelector(".badge").classList.contains("important");
                
                document.getElementById("noticeTitle").value = title;
                document.getElementById("noticeContent").value = "샘플 공지사항 내용입니다."; // 실제로는 DB에서 가져와야 함
                document.querySelector(`input[name="noticeStatus"][value="${isImportant ? 'important' : 'normal'}"]`).checked = true;
                
                modalTitle.textContent = "공지사항 수정";
                noticeModal.style.display = "block";
            });
        });
        
        // 삭제 버튼 클릭
        deleteButtons.forEach(function(btn) {
            btn.addEventListener("click", function() {
                deleteModal.style.display = "block";
            });
        });
        
        // 선택 삭제 버튼 클릭
        deleteSelectedBtn.addEventListener("click", function() {
            const hasSelected = Array.from(noticeCheckboxes).some(checkbox => checkbox.checked);
            if (hasSelected) {
                deleteModal.style.display = "block";
            } else {
                alert("삭제할 공지사항을 선택해주세요.");
            }
        });
        
        // 공지사항 저장
        noticeForm.addEventListener("submit", function(e) {
            e.preventDefault();
            // 여기에 서버로 데이터 전송 코드 추가
            alert("공지사항이 저장되었습니다.");
            noticeModal.style.display = "none";
        });
        
        // 공지사항 삭제 확인
        confirmDeleteBtn.addEventListener("click", function() {
            // 여기에 서버로 삭제 요청 코드 추가
            alert("선택한 공지사항이 삭제되었습니다.");
            deleteModal.style.display = "none";
        });
        
        // 중요/일반 설정 버튼
        setImportantBtn.addEventListener("click", function() {
            const hasSelected = Array.from(noticeCheckboxes).some(checkbox => checkbox.checked);
            if (hasSelected) {
                // 여기에 서버로 상태 변경 요청 코드 추가
                alert("선택한 공지사항이 중요로 설정되었습니다.");
            } else {
                alert("상태를 변경할 공지사항을 선택해주세요.");
            }
        });
        
        setNormalBtn.addEventListener("click", function() {
            const hasSelected = Array.from(noticeCheckboxes).some(checkbox => checkbox.checked);
            if (hasSelected) {
                // 여기에 서버로 상태 변경 요청 코드 추가
                alert("선택한 공지사항이 일반으로 설정되었습니다.");
            } else {
                alert("상태를 변경할 공지사항을 선택해주세요.");
            }
        });
        
        // 페이지네이션
        const paginationSpans = document.querySelectorAll(".pagination span");
        paginationSpans.forEach(function(span) {
            if (span.textContent !== "Prev" && span.textContent !== "Next") {
                span.addEventListener("click", function() {
                    document.querySelector(".pagination .active").classList.remove("active");
                    this.classList.add("active");
                    // 여기에 페이지 변경 코드 추가
                });
            }
        });
    });
    </script>

</body>
</html> 