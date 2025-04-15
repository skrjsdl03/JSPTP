<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="DAO.ReviewDAO"%>
<%@page import="DTO.ReviewDTO"%>
<%@page import="DTO.ReviewImgDTO"%>
<%@page import="DTO.ReviewCmtDTO"%>
<%
String user_id = request.getParameter("user_id");
String user_type = request.getParameter("user_type");
int r_id = Integer.parseInt(request.getParameter("r_id"));
String admin_id = "admin01"; // 로그인 세션으로 교체 가능

ReviewDAO dao = new ReviewDAO();

// 댓글 등록 처리
if ("POST".equals(request.getMethod()) && "addComment".equals(request.getParameter("mode"))) {
    String rc_content = request.getParameter("rc_content");

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

// 리뷰 삭제 처리
if ("POST".equals(request.getMethod()) && "deleteReview".equals(request.getParameter("mode"))) {
    dao.deleteReview(r_id);
    out.println("<script>alert('리뷰가 삭제되었습니다.'); window.close(); window.opener.location.reload();</script>");
    return;
}

ReviewDTO review = dao.getReviewById(r_id);
String pdName = dao.getProductNameByPdId(review.getPd_id());
List<ReviewImgDTO> imgs = dao.getReviewImages(r_id);
List<ReviewCmtDTO> cmts = dao.getReviewComments(r_id);
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>리뷰 상세 관리</title>
</head>
<link rel="stylesheet" href="CRM.css/userCRM.css">
<body>
  <div class="container">
    <h2>📝 리뷰 상세 정보</h2>
    <div class="review-box">
      <p><strong>작성자:</strong> <%=review.getUser_id()%> (<%=review.getUser_type()%>)</p>
      <p><strong>상품명:</strong> <%=pdName%> (<%=review.getPd_id()%>)</p>
      <p><strong>내용:</strong> <%=review.getR_content()%></p>
      <p><strong>별점:</strong>
        <span class="rating-stars">
          <span class="stars" style="--rating: <%=review.getR_rating()%>;"></span>
        </span>
        (<%=review.getR_rating()%>점)
      </p>
      <p><strong>작성일:</strong> <%=review.getCreated_at()%></p>
      <p><strong>신고 수:</strong> <%=review.getR_report_count()%></p>
      <p><strong>숨김 여부:</strong>
        <span class="<%="hidden-" + review.getR_isHidden().toLowerCase()%>">
          <%=review.getR_isHidden().equals("Y") ? "숨김" : "공개"%>
        </span>
      </p>
      <div class="image-preview">
        <%
        for (ReviewImgDTO img : imgs) {
        %>
          <img src="<%=img.getRi_url()%>" />
        <%
        }
        %>
      </div>
    </div>

    <h3>💬 댓글 목록</h3>
    <div class="comment-box">
      <%
      if (cmts.isEmpty()) {
      %>
        <p>등록된 댓글이 없습니다.</p>
      <%
      } else {
      %>
        <%
        for (ReviewCmtDTO c : cmts) {
        %>
          <div class="comment">
            <strong><%=c.getRc_author_id()%> (<%=c.getRc_author_type()%>)</strong>
            <span style="margin-left: 10px; color: #777; font-size: 12px;">
              <%=c.getCreated_at()%>
            </span>
            <form action="reviewCmtDelete.jsp" method="post" style="display:inline">
              <input type="hidden" name="rc_id" value="<%=c.getRc_id()%>">
              <button class="btn btn-delete" type="submit">삭제</button>
            </form>
          </div>
        <% } %>
      <% } %>
    </div>

    <h3>✍️ 관리자 댓글 등록</h3>
    <form method="post">
      <input type="hidden" name="mode" value="addComment">
      <input type="hidden" name="r_id" value="<%=r_id%>">
      <textarea name="rc_content" rows="4" cols="70" placeholder="댓글을 입력하세요"></textarea><br><br>
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
