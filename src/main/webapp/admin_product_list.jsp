<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="DTO.ProductDTO" %>
<%@ page import="DAO.ProductDAO" %>
<%
    int currentPage = 1;
    if (request.getParameter("page") != null) {
        try {
            currentPage = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException e) {
            currentPage = 1;
        }
    }

    int itemsPerPage = 10;
    int start = (currentPage - 1) * itemsPerPage;

    ProductDAO productDAO = new ProductDAO();
    List<ProductDTO> productList = productDAO.getProductList(start, itemsPerPage);
    int totalProducts = productDAO.getTotalProductCount();
    int totalPages = (int) Math.ceil((double) totalProducts / itemsPerPage);

    DecimalFormat priceFormat = new DecimalFormat("#,###");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 관리 | everyWEAR 관리자</title>
    <style>
        body { font-family: 'Noto Sans KR', sans-serif; background: #f8f9fa; }
        .container { width: 95%; max-width: 1200px; margin: 0 auto; padding: 20px; }
        .product-item { display: flex; padding: 15px; border-bottom: 1px solid #eee; }
        .product-image { width: 80px; height: 80px; margin-right: 20px; object-fit: cover; border-radius: 4px; }
        .product-details { flex-grow: 1; }
        .product-name { font-weight: bold; }
        .product-actions button { margin-left: 5px; }
        .btn-add-product { margin: 10px 0; padding: 10px; background: #4CAF50; color: white; border: none; border-radius: 4px; cursor: pointer; }
    </style>
</head>
<body>

<jsp:include page="/includes/admin_header.jsp" />

<div class="container">
    <h2>상품 관리</h2>
    <p>총 <b><%= totalProducts %></b>개의 상품이 있습니다.</p>
    <button class="btn-add-product" onclick="location.href='admin_product_add.jsp'">상품 등록</button>

    <% if (productList == null || productList.isEmpty()) { %>
        <p>등록된 상품이 없습니다.</p>
    <% } else {
        for (ProductDTO product : productList) {
            String imageUrl = productDAO.getProductMainImage(product.getP_id());
            if (imageUrl == null || imageUrl.isEmpty()) {
                imageUrl = "images/no_image.png";
            }
            int stock = productDAO.getTotalStock(product.getP_id());
    %>
    <div class="product-item">
        <img src="<%= imageUrl %>" class="product-image" alt="상품 이미지">
        <div class="product-details">
            <div class="product-name"><%= product.getP_name() %></div>
            <div class="product-category"><%= product.getP_category() %></div>
            <div class="product-stock">재고: <%= stock %>개</div>
        </div>
        <div class="product-actions">
            <button onclick="location.href='admin_product_edit.jsp?id=<%= product.getP_id() %>'">수정</button>
            <button onclick="deleteProduct('<%= product.getP_id() %>')">삭제</button>
        </div>
    </div>
    <% }} %>
</div>

<script>
    function deleteProduct(id) {
        if (confirm('정말 삭제하시겠습니까?')) {
            location.href = 'ProductServlet?action=delete&id=' + id;
        }
    }
</script>

<jsp:include page="/includes/admin_footer.jsp" />

</body>
</html>
