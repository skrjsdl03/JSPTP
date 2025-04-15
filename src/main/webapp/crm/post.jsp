<!-- post.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String user_id = request.getParameter("user_id");
String user_type = request.getParameter("user_type");
%>

<div class="crm-section">
	<h2>📝 회원 게시글 정보</h2>

	<!-- 탭 버튼 -->
	<div class="tab-buttons">
		<button onclick="loadPostTab('review')">리뷰</button>
		<button onclick="loadPostTab('inquiry')">문의</button>
	</div>

	<!-- 탭 콘텐츠 -->
	<div id="post-content" class="post-content-box">
		<!-- 여기에 AJAX로 콘텐츠 삽입됨 -->
	</div>
</div>
<script>
function loadPostTab(type) {
	  const content = document.getElementById("post-content");
	  const userId = "<%=user_id%>";
	  const userType = "<%=user_type%>";

	  let url = "";

	  if (type === "review") {
	    url = "reviewTab.jsp?user_id=" + userId + "&user_type=" + userType;
	  } else if (type === "inquiry") {
	    url = "inquiryTab.jsp?user_id=" + userId + "&user_type=" + userType;
	  }

	  if (!url) return;

	  fetch(url)
	  .then(function(res) { return res.text(); })
	  .then(function(html) {
	    content.innerHTML = html;

	    // 모든 버튼에서 active 제거
	    document.querySelectorAll(".tab-buttons button").forEach(function(btn) {
	      btn.classList.remove("active");
	    });

	    // 클릭한 버튼에만 active 추가
	    document.querySelector(".tab-buttons button[onclick=\"loadPostTab('" + type + "')\"]").classList.add("active");
	  });
	}


// 기본 탭 로드
window.addEventListener("DOMContentLoaded", () => {
  loadPostTab("review");
});
</script>
