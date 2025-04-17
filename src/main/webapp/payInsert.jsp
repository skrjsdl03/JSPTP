<%@page import="java.net.URLDecoder"%>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%@ page contentType="application/json; charset=UTF-8" %>
<jsp:useBean id="pDao" class="DAO.PaymentDAO"/>
<jsp:useBean id="oDao" class="DAO.OrderDAO"/>
<jsp:useBean id="pdDao" class="DAO.ProductDAO"/>
<jsp:useBean id="dDao" class="DAO.DeliveryDAO"/>
<%
  String id = (String)session.getAttribute("id");
if(id == null || id.equals(""))
	id = "비회원";
String userType = (String)session.getAttribute("userType");
if(userType == null || userType.equals(""))
	userType = "비회원";

String imp_uid = request.getParameter("imp_uid");
String apply_num = request.getParameter("apply_num");
String card_name = request.getParameter("card_name");
String o_num = request.getParameter("o_num");
String o_name = request.getParameter("o_name");
String o_phone = request.getParameter("o_phone");
String paid_amount = request.getParameter("paid_amount");
String zipcode = request.getParameter("zipcode");
String address1 = request.getParameter("address1");
String address2 = request.getParameter("address2");
String alias = request.getParameter("alias");

String prefix = "EW"; // EveryWear 예시
int number = (int)(Math.random() * 1000000000); // 9자리 난수
prefix = prefix + String.format("%09d", number);

// 💡 배열 파라미터 받기 (name="pd_id[]" 형태로 보낸 것들)
String[] pd_ids = request.getParameterValues("pd_id[]");
String[] quantities = request.getParameterValues("quantity[]");

if(pDao.insertPay(id, userType, imp_uid, apply_num, URLDecoder.decode(card_name, "UTF-8"))){
	for(int i = 0; i<pd_ids.length; i++){
		int o_id = oDao.insertOrder
				(id, 
				userType, 
				Integer.parseInt(pd_ids[i]), 
				o_num, 
				(id.equals("비회원") ? "N" : "Y"), 
				URLDecoder.decode(o_name, "UTF-8"), 
				o_phone, 
				Integer.parseInt(quantities[i]), 
				pdDao.getOnePdPrice(Integer.parseInt(pd_ids[i])) * Integer.parseInt(quantities[i]), 
				pDao.getPay_id(id, userType, imp_uid));
		if(o_id != -1){
			dDao.insertDelivery(o_id, alias, URLDecoder.decode(o_name, "UTF-8"), o_phone, zipcode, URLDecoder.decode(address1, "UTF-8"), URLDecoder.decode(address2, "UTF-8"), prefix);
		}
	}
	out.print("{\"result\":\"success\"}");
} else{
	out.print("{\"result\":\"fail\"}");
}


/*   if (userDao.updateEmail(id, userType, email)) {
    out.print("{\"result\":\"success\"}");
  } else {
    out.print("{\"result\":\"fail\"}");
  } */
%>
