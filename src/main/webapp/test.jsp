<%@page import="java.util.Vector"%>
<%@page import="DAO.ProductDAO"%>
<%@ page  contentType="text/html; charset=UTF-8"%>
<%
		ProductDAO p = new ProductDAO();
		Vector<String> list = p.img();
%>

<div>
<%for(int i = 0; i<list.size(); i++){
		String a = list.get(i);
	%>
<img alt="a" src="<%=a%>">
<%}%>
</div>
