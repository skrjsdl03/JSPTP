<!-- reviewTab.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DAO.UserDAO, DTO.ReviewDTO"%>
<%@ page import="java.util.List"%>
<%
String user_id = request.getParameter("user_id");
UserDAO dao = new UserDAO();
List<ReviewDTO> list = dao.getReviewsByUser(user_id);
%>

<div class="review-scroll-area">
  <h3>✍ 작성한 리뷰 목록 (<%=list.size()%>개)</h3>
  <% if (list.isEmpty()) { %>
    <p>작성한 리뷰가 없습니다.</p>
  <% } else { %>
    <table>
      <thead>
        <tr>
          <th>리뷰ID</th>
          <th>상품ID</th>
          <th>작성일</th>
          <th>평점</th>
          <th>내용</th>
          <th>답변</th>
          <th>신고수</th>
          <th>숨김여부</th>
        </tr>
      </thead>
      <tbody>
        <% for (ReviewDTO r : list) { %>
          <tr>
            <td><%=r.getR_id()%></td>
            <td><%=r.getPd_id()%></td>
            <td><%=r.getCreated_at()%></td>
            <td><%=r.getR_rating()%>점</td>
            <td><%=r.getR_content()%></td>
            <td><%=r.getR_report_count()%></td>
            <td><%=r.getR_isHidden().equals("Y") ? "숨김" : "공개"%></td>
          </tr>
        <% } %>
      </tbody>
    </table>
  <% } %>
</div>
