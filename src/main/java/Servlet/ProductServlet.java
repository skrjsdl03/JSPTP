package Servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import DAO.ProductDAO;
import DTO.ProductDTO;
import DTO.ProductDetailDTO;
import DTO.ProductImgDTO;

@WebServlet("/ProductServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        
        if ("insert".equals(action)) {
            insertProduct(request, response);
        } else if ("update".equals(action)) {
            updateProduct(request, response);
        } else if ("delete".equals(action)) {
            deleteProduct(request, response);
        } else {
            response.sendRedirect("admin_product_list.jsp?error=invalidAction");
        }
    }
    
    // GET 요청 처리를 위한 메소드 추가
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        
        if ("delete".equals(action)) {
            deleteProduct(request, response);
        } else {
            response.sendRedirect("admin_product_list.jsp");
        }
    }
    
    private void insertProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 상품 기본 정보 가져오기
            String p_name = request.getParameter("p_name");
            String p_category = request.getParameter("p_category");
            
            System.out.println("선택된 최종 카테고리: " + p_category); // 디버깅
            
            int p_price = Integer.parseInt(request.getParameter("p_price"));
            int p_disc = 0;
            if (request.getParameter("p_disc") != null && !request.getParameter("p_disc").isEmpty()) {
                p_disc = Integer.parseInt(request.getParameter("p_disc"));
            }
            String p_text = request.getParameter("p_text");
            // 줄바꿈을 <br> 태그로 변환 전에 기존의 <br> 태그를 개행문자로 변환하여 중복 방지
            if(p_text != null) {
                System.out.println("원본 상품 설명: " + p_text.substring(0, Math.min(50, p_text.length())) + "...");
                
                // 먼저 기존의 <br> 태그를 임시 마커로 변환
                p_text = p_text.replace("<br>", "\n");
                System.out.println("<br> 태그 제거 후: " + p_text.substring(0, Math.min(50, p_text.length())) + "...");
                
                // 그 다음 줄바꿈을 <br> 태그로 변환
                p_text = p_text.replace("\n", "<br>");
                
                System.out.println("최종 변환 결과: " + p_text.substring(0, Math.min(50, p_text.length())) + "...");
            }
            String p_color = request.getParameter("p_color");
            
            // p_id 처리 (입력값이 있으면 사용, 없으면 자동 생성)
            int p_id = 0;
            if (request.getParameter("p_id") != null && !request.getParameter("p_id").isEmpty()) {
                p_id = Integer.parseInt(request.getParameter("p_id"));
            }
            
            // 상품 DTO 생성
            ProductDTO product = new ProductDTO();
            product.setP_id(p_id);
            product.setP_name(p_name);
            product.setP_category(p_category);
            product.setP_price(p_price);
            product.setP_disc(p_disc);
            product.setP_text(p_text);
            product.setP_color(p_color);
            
            // 현재 날짜 및 시간 설정
            LocalDateTime now = LocalDateTime.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            product.setCreated_at(now.format(formatter));
            
            // DAO를 통해 상품 정보 저장
            ProductDAO productDAO = new ProductDAO();
            
            // 상품 등록 및 생성된 상품 ID 가져오기
            int productId = productDAO.insertProduct(product);
            
            if (productId > 0) {
                // 사이즈 및 재고 정보 저장
                String[] sizes = request.getParameterValues("sizes[]");
                String[] stocks = request.getParameterValues("stocks[]");
                
                if (sizes != null && stocks != null && sizes.length == stocks.length) {
                    for (int i = 0; i < sizes.length; i++) {
                        if (sizes[i] != null && !sizes[i].isEmpty() && stocks[i] != null && !stocks[i].isEmpty()) {
                            ProductDetailDTO detail = new ProductDetailDTO();
                            detail.setP_id(productId);
                            detail.setPd_size(sizes[i]);
                            detail.setPd_stock(Integer.parseInt(stocks[i]));
                            
                            productDAO.insertProductDetail(detail);
                        }
                    }
                }
                
                // 이미지 파일 저장 (대표 이미지)
                String uploadPath = getServletContext().getRealPath("/uploads/products/");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                
                Part mainImagePart = request.getPart("main_image");
                if (mainImagePart != null && mainImagePart.getSize() > 0) {
                    String fileName = getSubmittedFileName(mainImagePart);
                    String fileExtension = getFileExtension(fileName);
                    String newFileName = "product_" + productId + "_main_" + System.currentTimeMillis() + fileExtension;
                    
                    String filePath = uploadPath + File.separator + newFileName;
                    mainImagePart.write(filePath);
                    
                    // 이미지 정보 DB에 저장
                    ProductImgDTO imgDTO = new ProductImgDTO();
                    imgDTO.setP_id(productId);
                    imgDTO.setPi_url("uploads/products/" + newFileName);
                    imgDTO.setPi_orders(1); // 대표 이미지는 1번
                    productDAO.insertProductImage(imgDTO);
                }
                
                // 상세 이미지 저장
                List<Part> detailImageParts = getDetailImageParts(request);
                int order = 2; // 대표 이미지가 1번이므로 상세 이미지는 2번부터 시작
                
                for (Part part : detailImageParts) {
                    if (part.getSize() > 0) {
                        String fileName = getSubmittedFileName(part);
                        String fileExtension = getFileExtension(fileName);
                        String newFileName = "product_" + productId + "_detail_" + System.currentTimeMillis() + "_" + order + fileExtension;
                        
                        String filePath = uploadPath + File.separator + newFileName;
                        part.write(filePath);
                        
                        // 이미지 정보 DB에 저장
                        ProductImgDTO imgDTO = new ProductImgDTO();
                        imgDTO.setP_id(productId);
                        imgDTO.setPi_url("uploads/products/" + newFileName);
                        imgDTO.setPi_orders(order);
                        productDAO.insertProductImage(imgDTO);
                        
                        order++;
                    }
                }
                
                // 등록 성공 시 상품 목록 페이지로 리다이렉트
                // response.sendRedirect("AdminProductServlet?status=success&message=등록이 완료되었습니다");
                request.setAttribute("status", "success");
                request.setAttribute("message", "등록이 완료되었습니다");
                request.getRequestDispatcher("/admin_product_list.jsp").forward(request, response);
            } else {
                // response.sendRedirect("admin_product_edit.jsp?error=insertFailed");
                request.setAttribute("error", "insertFailed");
                request.getRequestDispatcher("/admin_product_edit.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            // response.sendRedirect("admin_product_edit.jsp?error=" + e.getMessage());
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/admin_product_edit.jsp").forward(request, response);
        }
    }
    
    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 상품 기본 정보 가져오기
            int p_id = Integer.parseInt(request.getParameter("id"));
            System.out.println("상품 ID: " + p_id); // 디버깅
            
            String p_name = request.getParameter("p_name");
            String p_category = request.getParameter("p_category");
            
            System.out.println("선택된 최종 카테고리: " + p_category); // 디버깅
            
            int p_price = Integer.parseInt(request.getParameter("p_price"));
            int p_disc = 0;
            if (request.getParameter("p_disc") != null && !request.getParameter("p_disc").isEmpty()) {
                p_disc = Integer.parseInt(request.getParameter("p_disc"));
            }
            String p_text = request.getParameter("p_text");
            // 줄바꿈을 <br> 태그로 변환 전에 기존의 <br> 태그를 개행문자로 변환하여 중복 방지
            if(p_text != null) {
                System.out.println("원본 상품 설명: " + p_text.substring(0, Math.min(50, p_text.length())) + "...");
                
                // 먼저 기존의 <br> 태그를 임시 마커로 변환
                p_text = p_text.replace("<br>", "\n");
                System.out.println("<br> 태그 제거 후: " + p_text.substring(0, Math.min(50, p_text.length())) + "...");
                
                // 그 다음 줄바꿈을 <br> 태그로 변환
                p_text = p_text.replace("\n", "<br>");
                
                System.out.println("최종 변환 결과: " + p_text.substring(0, Math.min(50, p_text.length())) + "...");
            }
            String p_color = request.getParameter("p_color");
            
            // 상품 DTO 생성
            ProductDTO product = new ProductDTO();
            product.setP_id(p_id);
            product.setP_name(p_name);
            product.setP_category(p_category);
            product.setP_price(p_price);
            product.setP_disc(p_disc);
            product.setP_text(p_text);
            product.setP_color(p_color);
            
            // 현재 날짜 및 시간 설정 유지
            String createdAt = request.getParameter("created_at");
            if (createdAt != null && !createdAt.isEmpty()) {
                product.setCreated_at(createdAt);
            }
            
            // DAO를 통해 상품 정보 업데이트
            ProductDAO productDAO = new ProductDAO();
            System.out.println("상품 정보 업데이트 시도"); // 디버깅
            boolean success = productDAO.updateProduct(product);
            
            if (success) {
                System.out.println("상품 정보 업데이트 성공, 상세 정보 삭제 시도"); // 디버깅
                // 기존 사이즈 및 재고 정보 삭제 후 재등록
                boolean detailsDeleted = productDAO.deleteProductDetails(p_id);
                
                if (detailsDeleted) {
                    System.out.println("상세 정보 삭제 성공, 재등록 시도"); // 디버깅
                    String[] sizes = request.getParameterValues("sizes[]");
                    String[] stocks = request.getParameterValues("stocks[]");
                    
                    boolean detailsSuccess = true;
                    
                    if (sizes != null && stocks != null && sizes.length == stocks.length) {
                        System.out.println("사이즈 및 재고 데이터 확인: " + sizes.length + "개"); // 디버깅
                        for (int i = 0; i < sizes.length; i++) {
                            if (sizes[i] != null && !sizes[i].isEmpty() && stocks[i] != null && !stocks[i].isEmpty()) {
                                try {
                                    ProductDetailDTO detail = new ProductDetailDTO();
                                    detail.setP_id(p_id);
                                    detail.setPd_size(sizes[i]);
                                    detail.setPd_stock(Integer.parseInt(stocks[i]));
                                    
                                    boolean inserted = productDAO.insertProductDetail(detail);
                                    if (!inserted) {
                                        detailsSuccess = false;
                                        System.out.println("상세 정보 " + i + " 등록 실패"); // 디버깅
                                    }
                                } catch (NumberFormatException e) {
                                    detailsSuccess = false;
                                    System.out.println("재고 수량 변환 오류: " + stocks[i]); // 디버깅
                                    e.printStackTrace();
                                }
                            }
                        }
                    }
                    
                    if (detailsSuccess) {
                        // 수정 성공 시 상품 목록 페이지로 리다이렉트
                        System.out.println("모든 처리 완료, 리다이렉트"); // 디버깅
                        // response.sendRedirect("AdminProductServlet?status=success&message=수정이 완료되었습니다");
                        request.setAttribute("status", "success");
                        request.setAttribute("message", "수정이 완료되었습니다");
                        request.getRequestDispatcher("/admin_product_list.jsp").forward(request, response);
                    } else {
                        // response.sendRedirect("admin_product_edit.jsp?id=" + p_id + "&error=detailInsertFailed");
                        request.setAttribute("id", p_id);
                        request.setAttribute("error", "detailInsertFailed");
                        request.getRequestDispatcher("/admin_product_edit.jsp").forward(request, response);
                    }
                } else {
                    // response.sendRedirect("admin_product_edit.jsp?id=" + p_id + "&error=detailDeleteFailed");
                    request.setAttribute("id", p_id);
                    request.setAttribute("error", "detailDeleteFailed");
                    request.getRequestDispatcher("/admin_product_edit.jsp").forward(request, response);
                }
            } else {
                // response.sendRedirect("admin_product_edit.jsp?id=" + p_id + "&error=updateFailed");
                request.setAttribute("id", p_id);
                request.setAttribute("error", "updateFailed");
                request.getRequestDispatcher("/admin_product_edit.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            // response.sendRedirect("admin_product_edit.jsp?error=" + e.getMessage());
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/admin_product_edit.jsp").forward(request, response);
        }
    }
    
    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("id"));
            
            ProductDAO productDAO = new ProductDAO();
            boolean success = productDAO.deleteProduct(productId);
            
            if (success) {
                // response.sendRedirect("AdminProductServlet?status=success&message=삭제가 완료되었습니다");
                request.setAttribute("status", "success");
                request.setAttribute("message", "삭제가 완료되었습니다");
                request.getRequestDispatcher("/admin_product_list.jsp").forward(request, response);
            } else {
                // response.sendRedirect("AdminProductServlet?error=deleteFailed");
                request.setAttribute("error", "deleteFailed");
                request.getRequestDispatcher("/admin_product_list.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            // response.sendRedirect("AdminProductServlet?error=" + e.getMessage());
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/admin_product_list.jsp").forward(request, response);
        }
    }
    
    // Part에서 파일명 추출하는 유틸리티 메소드
    private String getSubmittedFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                String fileName = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                return fileName.substring(fileName.lastIndexOf('/') + 1).substring(fileName.lastIndexOf('\\') + 1);
            }
        }
        return null;
    }
    
    // 파일 확장자 추출 유틸리티 메소드
    private String getFileExtension(String fileName) {
        if (fileName == null) return "";
        int dotIndex = fileName.lastIndexOf('.');
        return (dotIndex == -1) ? "" : fileName.substring(dotIndex);
    }
    
    // 상세 이미지 파트 목록 가져오기
    private List<Part> getDetailImageParts(HttpServletRequest request) throws ServletException, IOException {
        List<Part> imageParts = new ArrayList<>();
        for (Part part : request.getParts()) {
            if (part.getName().equals("detail_image[]")) {
                imageParts.add(part);
            }
        }
        return imageParts;
    }
} 