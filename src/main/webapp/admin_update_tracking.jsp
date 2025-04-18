<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DAO.AdminOrderDAO" %>
<%
// POST 요청 확인
if(!"POST".equalsIgnoreCase(request.getMethod())) {
    response.sendRedirect("admin_order_list.jsp");
    return;
}

// 배송 ID와 주문 ID, 송장번호 가져오기
int deliveryId = 0;
int orderId = 0;
String trackingNumber = "";

try {
    deliveryId = Integer.parseInt(request.getParameter("d_id"));
    orderId = Integer.parseInt(request.getParameter("o_id"));
    trackingNumber = request.getParameter("tracking_number");
    
    // 입력값 유효성 검사
    if(deliveryId <= 0 || orderId <= 0) {
        response.sendRedirect("admin_order_detail.jsp?o_id=" + orderId + "&message=유효하지 않은 입력값입니다.&messageType=danger");
        return;
    }
    
    // 송장번호가 비어있는 경우 빈 문자열로 처리
    if(trackingNumber == null) {
        trackingNumber = "";
    }
    
    // DAO를 통해 송장번호 업데이트
    AdminOrderDAO orderDAO = new AdminOrderDAO();
    boolean success = orderDAO.updateTrackingNumber(deliveryId, trackingNumber);
    
    if(success) {
        // 송장번호 입력 시 자동으로 배송중 상태로 변경 (송장번호가 있으면)
        if(!trackingNumber.isEmpty()) {
            orderDAO.updateDeliveryStatus(deliveryId, "배송중");
            response.sendRedirect("admin_order_detail.jsp?o_id=" + orderId + "&message=송장번호가 등록되었고 배송 상태가 '배송중'으로 변경되었습니다.&messageType=success");
        } else {
            response.sendRedirect("admin_order_detail.jsp?o_id=" + orderId + "&message=송장번호가 삭제되었습니다.&messageType=success");
        }
    } else {
        response.sendRedirect("admin_order_detail.jsp?o_id=" + orderId + "&message=송장번호 수정에 실패했습니다.&messageType=danger");
    }
    
} catch(Exception e) {
    e.printStackTrace();
    response.sendRedirect("admin_order_detail.jsp?o_id=" + orderId + "&message=오류가 발생했습니다: " + e.getMessage() + "&messageType=danger");
}
%> 