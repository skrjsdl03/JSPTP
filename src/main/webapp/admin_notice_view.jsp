<%@ page contentType="text/html;charset=UTF-8" language="java"%>
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
            <h2>공지사항 상세</h2>
            
            <div class="notice-view">
                <div class="notice-header">
                    <div class="notice-title">
                        <span class="badge important">중요</span>
                        이용 안내
                    </div>
                    <div class="notice-info">
                        <span>등록일: 2025-03-30</span>
                        <span>조회수: 56</span>
                        <span>작성자: 관리자</span>
                    </div>
                </div>
                
                <div class="notice-content">
                    <p>
                        안녕하세요, everyWEAR 고객님!
                    </p>
                    <p>
                        저희 everyWEAR 서비스를 이용해 주셔서 감사합니다. 
                        원활한 서비스 이용을 위해 아래 사항을 안내해 드립니다.
                    </p>
                    <p>
                        <strong>1. 회원 가입 및 로그인</strong><br>
                        - 회원 가입은 이메일 인증을 통해 진행됩니다.<br>
                        - 비밀번호는 영문, 숫자, 특수문자를 조합하여 8자 이상으로 설정해주세요.<br>
                        - 개인정보 보호를 위해 주기적인 비밀번호 변경을 권장합니다.
                    </p>
                    <p>
                        <strong>2. 주문 및 결제</strong><br>
                        - 주문은 24시간 가능합니다.<br>
                        - 결제는 신용카드, 계좌이체, 휴대폰 결제 등 다양한 방법으로 가능합니다.<br>
                        - 주문 완료 후 결제 정보 변경은 고객센터로 문의해 주세요.
                    </p>
                    <p>
                        <strong>3. 배송 안내</strong><br>
                        - 배송은 주문 완료 후 1-2일 내에 출고됩니다.(공휴일 제외)<br>
                        - 배송 조회는 마이페이지에서 확인 가능합니다.<br>
                        - 일부 지역은 배송이 제한될 수 있습니다.
                    </p>
                    <p>
                        <strong>4. 교환 및 반품</strong><br>
                        - 교환/반품은 상품 수령 후 7일 이내에 신청 가능합니다.<br>
                        - 고객 변심으로 인한 교환/반품의 경우 배송비는 고객 부담입니다.<br>
                        - 상품 불량, 오배송의 경우 배송비는 당사에서 부담합니다.
                    </p>
                    <p>
                        보다 자세한 내용은 고객센터로 문의해 주시기 바랍니다.
                    </p>
                    <p>
                        항상 최상의 서비스를 제공하기 위해 노력하겠습니다.<br>
                        감사합니다.
                    </p>
                </div>
            </div>
            
            <div class="button-group">
                <button class="btn btn-primary" onclick="location.href='admin_notice.jsp'">목록</button>
                <button class="btn" onclick="editNotice()">수정</button>
                <button class="btn btn-danger" onclick="deleteNotice()">삭제</button>
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
                <div class="form-actions">
                    <button type="button" id="cancelDeleteBtn" class="btn">취소</button>
                    <button type="button" id="confirmDeleteBtn" class="btn btn-danger">삭제</button>
                </div>
            </div>
        </div>
    </div>

    <script>
    document.addEventListener("DOMContentLoaded", function() {
        const deleteModal = document.getElementById("deleteModal");
        const closeBtn = document.querySelector(".close");
        const cancelDeleteBtn = document.getElementById("cancelDeleteBtn");
        const confirmDeleteBtn = document.getElementById("confirmDeleteBtn");
        
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
        
        // 삭제 확인
        confirmDeleteBtn.addEventListener("click", function() {
            // 서버에 삭제 요청 보내는 코드
            alert("공지사항이 삭제되었습니다.");
            window.location.href = "admin_notice.jsp";
        });
    });
    
    // 공지사항 수정 페이지로 이동
    function editNotice() {
        // 실제로는 공지사항 ID를 전달해야 함
        window.location.href = "admin_notice.jsp?edit=true";
    }
    
    // 삭제 모달 열기
    function deleteNotice() {
        document.getElementById("deleteModal").style.display = "block";
    }
    </script>

</body>
</html> 