<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DAO.AdminDeliveryDAO" %>
<%@ page import="java.util.*" %>

<%
// 인코딩 설정
request.setCharacterEncoding("UTF-8");

// DAO 객체 생성
AdminDeliveryDAO deliveryDAO = new AdminDeliveryDAO();

// 일괄 업데이트 여부 확인
String bulkUpdate = request.getParameter("bulkUpdate");
boolean isBulkUpdate = "true".equals(bulkUpdate);

String message = "";
boolean success = false;

if (isBulkUpdate) {
    // 일괄 업데이트 처리
    String bulkStatus = request.getParameter("bulkStatus");
    String[] deliveryIdsStr = request.getParameterValues("deliveryIds");
    
    if (deliveryIdsStr != null && deliveryIdsStr.length > 0 && bulkStatus != null && !bulkStatus.isEmpty()) {
        int[] deliveryIds = new int[deliveryIdsStr.length];
        for (int i = 0; i < deliveryIdsStr.length; i++) {
            deliveryIds[i] = Integer.parseInt(deliveryIdsStr[i]);
        }
        
        success = deliveryDAO.updateMultipleDeliveryStatus(deliveryIds, bulkStatus);
        
        if (success) {
            message = deliveryIds.length + "개 배송 정보의 상태가 '" + bulkStatus + "'(으)로 변경되었습니다.";
        } else {
            message = "배송 상태 변경 중 오류가 발생했습니다.";
        }
    } else {
        message = "업데이트할 배송 정보가 선택되지 않았거나 상태값이 잘못되었습니다.";
    }
} else {
    // 개별 업데이트 처리
    Enumeration<String> paramNames = request.getParameterNames();
    int updateCount = 0;
    
    while (paramNames.hasMoreElements()) {
        String paramName = paramNames.nextElement();
        
        if (paramName.startsWith("status_")) {
            String d_idStr = paramName.substring("status_".length());
            int d_id = Integer.parseInt(d_idStr);
            String status = request.getParameter(paramName);
            
            boolean updateSuccess = deliveryDAO.updateDeliveryStatus(d_id, status);
            if (updateSuccess) {
                updateCount++;
            }
        }
    }
    
    if (updateCount > 0) {
        success = true;
        message = updateCount + "개 배송 정보의 상태가 변경되었습니다.";
    } else {
        message = "변경된 배송 상태가 없습니다.";
    }
}

// 상태 메시지와 함께 목록 페이지로 리다이렉트
response.sendRedirect("admin_order_delivery.jsp?message=" + java.net.URLEncoder.encode(message, "UTF-8"));
%> 