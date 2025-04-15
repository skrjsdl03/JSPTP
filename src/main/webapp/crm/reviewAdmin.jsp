<%@page import="java.util.List, java.util.Set"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="DAO.ReviewDAO"%>
<%@page import="DTO.ReviewDTO"%>
<%@page import="DTO.ReviewImgDTO"%>
<%@page import="DTO.ReviewCmtDTO"%>
<%@page import="DTO.ReviewReportDTO"%>
<%
String user_id = request.getParameter("user_id");
String user_type = request.getParameter("user_type");
int r_id = Integer.parseInt(request.getParameter("r_id"));
String admin_id = "admin01";

ReviewDAO dao = new ReviewDAO();

if ("POST".equals(request.getMethod()) && "addComment".equals(request.getParameter("mode"))) {
	String rc_content = request.getParameter("rc_content");
	if (rc_content == null || rc_content.trim().isEmpty()) {
		out.println("<script>alert('댓글 내용을 입력해주세요.'); history.back();</script>");
		return;
	}
	ReviewCmtDTO cmt = new ReviewCmtDTO();
	cmt.setR_id(r_id);
	cmt.setRc_author_id(admin_id);
	cmt.setRc_author_type("관리자");
	cmt.setRc_content(rc_content);
	dao.insertReviewComment(cmt);
	String encodedType = java.net.URLEncoder.encode(user_type, "UTF-8");
	response.sendRedirect("reviewAdmin.jsp?r_id=" + r_id + "&user_id=" + user_id + "&user_type=" + encodedType);
	return;
}

if ("POST".equals(request.getMethod()) && "deleteReview".equals(request.getParameter("mode"))) {
	dao.deleteReview(r_id);
	out.println("<script>alert('리뷰가 삭제되었습니다.'); window.close(); if(window.opener){ window.opener.loadTab('post'); }</script>");
	return;
}

if ("POST".equals(request.getMethod()) && "deleteComment".equals(request.getParameter("mode"))) {
	int rc_id = Integer.parseInt(request.getParameter("rc_id"));
	dao.markReviewCommentAsDeleted(rc_id);
	String encodedType = java.net.URLEncoder.encode(user_type, "UTF-8");
	response.sendRedirect("reviewAdmin.jsp?r_id=" + r_id + "&user_id=" + user_id + "&user_type=" + encodedType);
	return;
}

ReviewDTO review = dao.getReviewById(r_id);
String pdName = dao.getProductNameByPdId(review.getPd_id());
List<ReviewImgDTO> imgs = dao.getReviewImages(r_id);
List<ReviewCmtDTO> cmts = dao.getReviewComments(r_id);
Set<Integer> reportedIds = dao.getReportedCommentIdsByReviewId(r_id);
List<ReviewReportDTO> reports = dao.getReportsByReviewId(r_id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 상세 관리</title>
<link rel="stylesheet" href="CRM.css/userCRM.css">
<script>
function filterReports() {
  const type = document.getElementById("reportFilter").value;
  const items = document.querySelectorAll(".report-item");
  items.forEach(el => {
    const reason = el.getAttribute("data-reason");
    el.style.display = (type === "all" || reason === type) ? "block" : "none";
  });
}
</script>
</head>
<body>
	<div class="container">
		<h2>📝 리뷰 상세 정보</h2>
		<div class="review-box">
			<p><strong>작성자:</strong> <%=review.getUser_id()%> (<%=review.getUser_type()%>)</p>
			<p><strong>상품ID:</strong> <%=review.getPd_id()%></p>
			<p><strong>상품명:</strong> <%=pdName%></p>
			<p><strong>내용:</strong> <%=review.getR_content()%></p>
			<p><strong>별점:</strong> <span class="rating-stars"> <span class="stars" style="--rating: <%=review.getR_rating()%>;"></span> </span> (<%=review.getR_rating()%>점)</p>
			<p><strong>작성일:</strong> <%=review.getCreated_at()%></p>
			<p><strong>수정일:</strong> <%=review.getUpdated_at() != null ? review.getUpdated_at() : "-"%></p>
			<p><strong>신고 수:</strong> <%=review.getR_report_count()%></p>
			<p><strong>숨김 여부:</strong> <span class="<%="hidden-" + review.getR_isHidden().toLowerCase()%>"><%=review.getR_isHidden().equals("Y") ? "숨김" : "공개"%></span></p>
			<div class="image-preview">
			<% for (ReviewImgDTO img : imgs) { %>
			<img src="<%=img.getRi_url()%>" />
			<% } %>
			</div>
		</div>

		<h3>🚨 리뷰 신고 목록</h3>
		<div class="comment-box">
			<select id="reportFilter" onchange="filterReports()">
				<option value="all">전체</option>
				<option value="욕설 사용">욕설 사용</option>
				<option value="비방/비하">비방/비하</option>
				<option value="스팸/광고">스팸/광고</option>
				<option value="부적절한 표현/내용">부적절한 표현/내용</option>
				<option value="개인정보 노출">개인정보 노출</option>
				<option value="중복 게시물">중복 게시물</option>
				<option value="기타">기타</option>
			</select>
			<hr>
			<% if (reports.isEmpty()) { %>
			<p>등록된 리뷰 신고가 없습니다.</p>
			<% } else { %>
			<% for (ReviewReportDTO r : reports) { %>
			<div class="report-item" data-reason="<%=r.getRr_reason_code()%>" style="border: 1px solid #ccc; padding: 12px; margin-bottom: 10px; border-radius: 6px; background-color: #fdfdfd;">
				<p><strong>신고자:</strong> <%=r.getUser_id()%> | <strong>사유:</strong> <%=r.getRr_reason_code()%></p>
				<% if (r.getRr_reason_text() != null && !r.getRr_reason_text().isEmpty()) { %>
				<p><strong>상세 사유:</strong> <%=r.getRr_reason_text()%></p>
				<% } %>
				<p style="font-size: 12px; color: #777;">신고일시: <%=r.getReported_at()%></p>
			</div>
			<% } %>
			<% } %>
		</div>

		<h3>💬 댓글 목록</h3>
		<div class="comment-box">
			<% if (cmts.isEmpty()) { %>
			<p>등록된 댓글이 없습니다.</p>
			<% } else { %>
			<% for (ReviewCmtDTO c : cmts) { %>
			<div class="comment">
				<strong><%=c.getRc_author_id()%> (<%=c.getRc_author_type()%>)</strong>
				<span style="margin-left: 10px; color: #777; font-size: 12px;">
					<%=c.getCreated_at()%>
				</span>
				<% if (reportedIds.contains(c.getRc_id())) { %>
				<span class="reported-label">🚨 신고된 댓글</span>
				<% } %>
				<% if (!"Y".equals(c.getRc_isDeleted())) { %>
				<form method="post" onsubmit="return confirm('해당 댓글을 삭제하시겠습니까?')" style="display:inline">
					<input type="hidden" name="mode" value="deleteComment">
					<input type="hidden" name="rc_id" value="<%=c.getRc_id()%>">
					<button class="btn btn-delete" type="submit">삭제</button>
				</form>
				<% } else { %>
				<span style="color: #ccc; margin-left: 10px;"><em>삭제된 댓글</em></span>
				<% } %>
			</div>
			<% } %>
			<% } %>
		</div>

		<h3>✍️ 관리자 댓글 등록</h3>
		<form method="post">
			<input type="hidden" name="mode" value="addComment">
			<input type="hidden" name="r_id" value="<%=r_id%>">
			<textarea name="rc_content" rows="4" cols="70" placeholder="댓글을 입력하세요"></textarea>
			<br><br>
			<button class="btn btn-submit" type="submit">댓글 등록</button>
		</form>

		<h3>🗑️ 리뷰 삭제</h3>
		<form method="post" onsubmit="return confirm('정말 이 리뷰를 삭제하시겠습니까?')">
			<input type="hidden" name="mode" value="deleteReview">
			<input type="hidden" name="r_id" value="<%=r_id%>">
			<button class="btn btn-delete" type="submit">리뷰 삭제</button>
		</form>

		<div style="margin-top: 20px; text-align: right;">
			<button class="btn btn-back" onclick="window.close()">뒤로가기 ✖</button>
		</div>
	</div>
</body>
</html>