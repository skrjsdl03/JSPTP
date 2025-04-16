package DAO;

import DTO.ProductDTO;
import DTO.ProductDetailDTO;
import DTO.ProductImgDTO;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;

public class ProductDAO {
    private DBConnectionMgr pool;

	private final SimpleDateFormat SDF_DATE = new SimpleDateFormat("yyyy-MM-dd");
    
    public ProductDAO() {
        pool = DBConnectionMgr.getInstance();
    }

    // 상품 리스트 (검색 포함)
    public List<ProductDTO> getProductListWithSearch(int start, int count, String keyword, String size) {
        List<ProductDTO> productList = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT DISTINCT p.* FROM product p "
        );

        if (size != null && !size.isEmpty()) {
            sql.append("JOIN product_detail pd ON p.p_id = pd.p_id ");
        }

        sql.append("WHERE 1=1 ");
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND p.p_name LIKE ? ");
        }
        if (size != null && !size.isEmpty()) {
            sql.append("AND pd.pd_size = ? ");
        }

        sql.append("ORDER BY p.p_id DESC LIMIT ?, ?");

        try (Connection con = pool.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql.toString())) {

            int idx = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                pstmt.setString(idx++, "%" + keyword.trim() + "%");
            }
            if (size != null && !size.isEmpty()) {
                pstmt.setString(idx++, size);
            }
            pstmt.setInt(idx++, start);
            pstmt.setInt(idx, count);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    ProductDTO product = new ProductDTO();
                    product.setP_id(rs.getInt("p_id"));
                    product.setP_name(rs.getString("p_name"));
                    product.setP_category(rs.getString("p_category"));
                    product.setP_price(rs.getInt("p_price"));
                    productList.add(product);
                }
            }

        } catch (Exception e) {
            System.out.println("getProductListWithSearch 오류: " + e.getMessage());
            e.printStackTrace();
        }

        return productList;
    }


    // 총 상품 수 (검색 포함)
    public int getTotalProductCountWithSearch(String keyword, String size) {
        int total = 0;
        StringBuilder sql = new StringBuilder("SELECT COUNT(DISTINCT p.p_id) FROM product p ");

        if (size != null && !size.isEmpty()) {
            sql.append("JOIN product_detail pd ON p.p_id = pd.p_id ");
        }

        sql.append("WHERE 1=1 ");
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND p.p_name LIKE ? ");
        }
        if (size != null && !size.isEmpty()) {
            sql.append("AND pd.pd_size = ? ");
        }

        try (Connection con = pool.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql.toString())) {

            int idx = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                pstmt.setString(idx++, "%" + keyword.trim() + "%");
            }
            if (size != null && !size.isEmpty()) {
                pstmt.setString(idx++, size);
            }

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt(1);
                }
            }

        } catch (Exception e) {
            System.out.println("getTotalProductCountWithSearch 오류: " + e.getMessage());
            e.printStackTrace();
        }

        return total;
    }


    // 상품 상세 정보 (사이즈별 재고)
    public List<ProductDetailDTO> getProductDetails(int p_id) {
        List<ProductDetailDTO> detailsList = new ArrayList<>();
        String sql = "SELECT * FROM product_detail WHERE p_id = ?";

        try (Connection con = pool.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, p_id);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    ProductDetailDTO detail = new ProductDetailDTO();
                    detail.setPd_id(rs.getInt("pd_id"));
                    detail.setP_id(rs.getInt("p_id"));
                    detail.setPd_size(rs.getString("pd_size"));
                    detail.setPd_stock(rs.getInt("pd_stock"));
                    detailsList.add(detail);
                }
            }

        } catch (Exception e) {
            System.out.println("getProductDetails 오류: " + e.getMessage());
            e.printStackTrace();
        }

        return detailsList;
    }

    // 상품 대표 이미지
    public String getProductMainImage(int p_id) {
        String sql = "SELECT pi_url FROM product_image WHERE p_id = ? ORDER BY pi_orders ASC LIMIT 1";
        String url = null;

        try (Connection con = pool.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, p_id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    url = rs.getString("pi_url");
                }
            }

        } catch (Exception e) {
            System.out.println("getProductMainImage 오류: " + e.getMessage());
            e.printStackTrace();
        }

        return url;
    }

    // 전체 상품 수 (기존)
    public int getTotalProductCount() {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM product";

        try (Connection con = pool.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    // 전체 재고 합산
    public int getTotalStock(int p_id) {
        String sql = "SELECT SUM(pd_stock) FROM product_detail WHERE p_id = ?";
        int totalStock = 0;

        try (Connection con = pool.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, p_id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    totalStock = rs.getInt(1);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return totalStock;
    }

    // 상품 리스트 (검색 + 정렬)
    public List<ProductDTO> getProductListWithSearchAndSort(int start, int count, String keyword, String size, String sortBy, String sortOrder) {
        List<ProductDTO> productList = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT DISTINCT p.* FROM product p "
        );

        if (size != null && !size.isEmpty()) {
            sql.append("JOIN product_detail pd ON p.p_id = pd.p_id ");
        }
        
        // 재고 기준 정렬을 위한 조인
        if (sortBy != null && sortBy.equals("stock")) {
            sql.append("LEFT JOIN (SELECT p_id, SUM(pd_stock) AS total_stock FROM product_detail GROUP BY p_id) ts ON p.p_id = ts.p_id ");
        }

        sql.append("WHERE 1=1 ");
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND p.p_name LIKE ? ");
        }
        if (size != null && !size.isEmpty()) {
            sql.append("AND pd.pd_size = ? ");
        }

        // 정렬 조건 추가
        sql.append("ORDER BY ");
        if (sortBy != null) {
            switch (sortBy) {
                case "p_name":
                    sql.append("p.p_name ");
                    break;
                case "p_price":
                    sql.append("p.p_price ");
                    break;
                case "created_at":
                    sql.append("p.created_at ");
                    break;
                case "stock":
                    // 재고 정렬 수정 - IFNULL 사용
                    sql.append("IFNULL(ts.total_stock, 0) ");
                    break;
                case "p_disc":
                    sql.append("p.p_disc ");
                    break;
                default:
                    sql.append("p.p_id ");
                    break;
            }
            
            // 정렬 방향
            if (sortOrder != null && sortOrder.equals("asc")) {
                sql.append("ASC ");
            } else {
                sql.append("DESC ");
            }
            
            // 2차 정렬 기준 - 재고 외에는 상품ID로 2차 정렬, 재고순은 동일 재고에서 최신순(ID 내림차순)
            if ("stock".equals(sortBy)) {
                sql.append(", p.p_id DESC ");
            } else {
                sql.append(", p.p_id DESC ");
            }
        } else {
            sql.append("p.p_id DESC ");
        }
        
        sql.append("LIMIT ?, ?");

        try (Connection con = pool.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql.toString())) {

            int idx = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                pstmt.setString(idx++, "%" + keyword.trim() + "%");
            }
            if (size != null && !size.isEmpty()) {
                pstmt.setString(idx++, size);
            }
            pstmt.setInt(idx++, start);
            pstmt.setInt(idx, count);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    ProductDTO product = new ProductDTO();
                    product.setP_id(rs.getInt("p_id"));
                    product.setP_name(rs.getString("p_name"));
                    product.setP_category(rs.getString("p_category"));
                    product.setP_price(rs.getInt("p_price"));
                    product.setP_disc(rs.getInt("p_disc"));
                    product.setP_text(rs.getString("p_text"));
                    product.setP_color(rs.getString("p_color"));
                    product.setCreated_at(rs.getString("created_at"));
                    productList.add(product);
                }
            }

        } catch (Exception e) {
            System.out.println("getProductListWithSearchAndSort 오류: " + e.getMessage());
            e.printStackTrace();
        }

        return productList;
    }

    // 고급 필터링이 적용된 상품 리스트 조회
    public List<ProductDTO> getProductListWithAdvancedFilters(
            int start, int count, String keyword, String size, String category, 
            Integer minPrice, Integer maxPrice, String stockStatus, String discount,
            String sortBy, String sortOrder) {
        
        // 재고순 또는 등록일순 정렬이 선택된 경우 등록순(p_id)으로 대체
        if ("stock".equals(sortBy) || "created_at".equals(sortBy)) {
            System.out.println("경고: 제거된 정렬 옵션 선택됨(" + sortBy + ") - 기본 정렬로 대체합니다.");
            sortBy = "p_id"; // 기본 정렬(등록순)으로 대체
        }
        
        List<ProductDTO> productList = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT DISTINCT p.* FROM product p "
        );

        // 항상 재고 정보 조인 (재고 필터링을 위해)
        boolean needsDetailJoin = size != null && !size.isEmpty();
        boolean needsStockFilter = stockStatus != null && !stockStatus.isEmpty();
        boolean needsCategoryJoin = category != null && !category.isEmpty();
        
        if (needsDetailJoin) {
            sql.append("LEFT JOIN product_detail pd ON p.p_id = pd.p_id ");
        }
        
        // 재고 서브쿼리는 항상 조인 (LEFT JOIN) - 재고 상태 필터링을 위해
        sql.append("LEFT JOIN (SELECT p_id, SUM(pd_stock) AS total_stock FROM product_detail GROUP BY p_id) ts ON p.p_id = ts.p_id ");
        
        // 특정 사이즈의 재고 상태를 확인하기 위한 추가 조인
        if (needsDetailJoin && needsStockFilter) {
            sql.append("LEFT JOIN (SELECT p_id, pd_size, pd_stock FROM product_detail WHERE ");
            
            if (size != null && !size.isEmpty()) {
                sql.append("pd_size = '").append(size).append("' ");
            } else {
                sql.append("1=1 ");
            }
            
            sql.append(") size_stock ON p.p_id = size_stock.p_id ");
        }

        sql.append("WHERE 1=1 ");
        
        // 검색어 필터 (상품명 또는 코드)
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (p.p_name LIKE ? OR p.p_id LIKE ?) ");
        }
        
        // 카테고리 필터
        if (category != null && !category.isEmpty()) {
            // 디버깅: 카테고리 정보 출력
            System.out.println("카테고리 필터 적용: " + category);
            
            // 카테고리 검색 조건 - 상위 카테고리 포함
            sql.append("AND (");
            
            // 1. 직접 일치 - 현재 상품의 카테고리가 선택한 카테고리인 경우
            sql.append("p.p_category = ? ");
            
            // 2. 하위 카테고리 포함 - 선택한 카테고리가 상위 카테고리인 경우 
            sql.append("OR EXISTS (SELECT 1 FROM category c WHERE c.category_name = p.p_category AND c.top_category = ?) ");
            
            // 3. 두 단계 아래 카테고리 포함 - 선택한 카테고리가 최상위 카테고리인 경우
            sql.append("OR EXISTS (SELECT 1 FROM category c1 JOIN category c2 ON c1.top_category = c2.category_name WHERE c1.category_name = p.p_category AND c2.top_category = ?) ");
            
            sql.append(") ");
        }
        
        // 사이즈 필터
        if (needsDetailJoin) {
            if (size != null && !size.isEmpty()) {
                sql.append("AND pd.pd_size = ? ");
            }
        }
        
        // 가격 범위 필터
        if (minPrice != null) {
            sql.append("AND p.p_price >= ? ");
        }
        
        if (maxPrice != null) {
            sql.append("AND p.p_price <= ? ");
        }
        
        // 재고 상태 필터 - 특정 사이즈와 결합하여 처리
        if (needsStockFilter) {
            if (needsDetailJoin) {
                // 특정 사이즈의 재고 상태 필터링
                switch (stockStatus) {
                    case "instock":
                        sql.append("AND size_stock.pd_stock > 0 ");
                        break;
                    case "lowstock":
                        sql.append("AND size_stock.pd_stock > 0 AND size_stock.pd_stock <= 15 ");
                        break;
                    case "outofstock":
                        sql.append("AND (size_stock.pd_stock = 0 OR size_stock.pd_stock IS NULL) ");
                        break;
                }
            } else {
                // 전체 상품의 재고 상태 필터링
                switch (stockStatus) {
                    case "instock":
                        sql.append("AND ts.total_stock > 0 ");
                        break;
                    case "lowstock":
                        sql.append("AND ts.total_stock > 0 AND ts.total_stock <= 15 ");
                        break;
                    case "outofstock":
                        sql.append("AND (ts.total_stock = 0 OR ts.total_stock IS NULL) ");
                        break;
                }
            }
        }
        
        // 할인 적용 여부 필터
        if (discount != null && !discount.isEmpty()) {
            if ("yes".equals(discount)) {
                sql.append("AND p.p_disc > 0 ");
            } else if ("no".equals(discount)) {
                sql.append("AND (p.p_disc = 0 OR p.p_disc IS NULL) ");
            }
        }

        sql.append("ORDER BY ");
        if (sortBy != null) {
            switch (sortBy) {
                case "p_name":
                    sql.append("p.p_name ");
                    break;
                case "p_price":
                    sql.append("p.p_price ");
                    break;
                case "created_at":
                    sql.append("p.created_at ");
                    break;
                case "stock":
                    // 재고 정렬 최적화
                    sql.append("IFNULL(ts.total_stock, 0) ");
                    break;
                case "p_disc":
                    sql.append("p.p_disc ");
                    break;
                default:
                    sql.append("p.p_id ");
                    break;
            }
            
            // 정렬 방향
            if (sortOrder != null && sortOrder.equals("asc")) {
                sql.append("ASC ");
            } else {
                sql.append("DESC ");
            }
            
            // 모든 정렬에 2차 정렬 기준 추가
            sql.append(", p.p_id DESC ");
        } else {
            sql.append("p.p_id DESC ");
        }

        System.out.println("SQL: " + sql.toString()); // 디버그용 SQL 출력
        
        sql.append("LIMIT ?, ?");

        try (Connection con = pool.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql.toString())) {

            int idx = 1;
            
            // 검색어 파라미터 설정
            if (keyword != null && !keyword.trim().isEmpty()) {
                pstmt.setString(idx++, "%" + keyword.trim() + "%");
                pstmt.setString(idx++, "%" + keyword.trim() + "%");
            }
            
            // 카테고리 파라미터 설정
            if (category != null && !category.isEmpty()) {
                System.out.println("카테고리 파라미터 설정: " + category);
                
                // 1. 직접 일치
                pstmt.setString(idx++, category);
                
                // 2. 하위 카테고리
                pstmt.setString(idx++, category);
                
                // 3. 두 단계 아래 카테고리
                pstmt.setString(idx++, category);
            }
            
            // 사이즈 파라미터 설정
            if (size != null && !size.isEmpty()) {
                pstmt.setString(idx++, size);
            }
            
            // 가격 범위 파라미터 설정
            if (minPrice != null) {
                pstmt.setInt(idx++, minPrice);
            }
            
            if (maxPrice != null) {
                pstmt.setInt(idx++, maxPrice);
            }
            
            // 페이지네이션 파라미터 설정
            pstmt.setInt(idx++, start);
            pstmt.setInt(idx, count);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    ProductDTO product = new ProductDTO();
                    product.setP_id(rs.getInt("p_id"));
                    product.setP_name(rs.getString("p_name"));
                    product.setP_category(rs.getString("p_category"));
                    product.setP_price(rs.getInt("p_price"));
                    product.setP_disc(rs.getInt("p_disc"));
                    product.setP_text(rs.getString("p_text"));
                    product.setP_color(rs.getString("p_color"));
                    product.setCreated_at(rs.getString("created_at"));
                    productList.add(product);
                }
            }

        } catch (Exception e) {
            System.out.println("getProductListWithAdvancedFilters 오류: " + e.getMessage());
            e.printStackTrace();
        }

        return productList;
    }
    
    // 고급 필터링이 적용된 총 상품 개수 조회
    public int getTotalProductCountWithAdvancedFilters(
            String keyword, String size, String category, 
            Integer minPrice, Integer maxPrice, String stockStatus, String discount) {
        
        int total = 0;
        StringBuilder sql = new StringBuilder(
            "SELECT COUNT(DISTINCT p.p_id) FROM product p "
        );

        // 사이즈나 재고 상태 필터가 있으면 product_detail 테이블 조인
        boolean needsDetailJoin = size != null && !size.isEmpty();
        boolean needsStockFilter = stockStatus != null && !stockStatus.isEmpty();
        
        if (needsDetailJoin) {
            sql.append("LEFT JOIN product_detail pd ON p.p_id = pd.p_id ");
        }
        
        // 재고 상태 필터링을 위한 서브쿼리 조인
        sql.append("LEFT JOIN (SELECT p_id, SUM(pd_stock) AS total_stock FROM product_detail GROUP BY p_id) ts ON p.p_id = ts.p_id ");
        
        // 특정 사이즈의 재고 상태를 확인하기 위한 추가 조인
        if (needsDetailJoin && needsStockFilter) {
            sql.append("LEFT JOIN (SELECT p_id, pd_size, pd_stock FROM product_detail WHERE ");
            
            if (size != null && !size.isEmpty()) {
                sql.append("pd_size = '").append(size).append("' ");
            } else {
                sql.append("1=1 ");
            }
            
            sql.append(") size_stock ON p.p_id = size_stock.p_id ");
        }

        sql.append("WHERE 1=1 ");
        
        // 검색어 필터 (상품명 또는 코드)
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (p.p_name LIKE ? OR p.p_id LIKE ?) ");
        }
        
        // 카테고리 필터
        if (category != null && !category.isEmpty()) {
            // 디버깅: 카테고리 정보 출력
            System.out.println("카테고리 필터 적용: " + category);
            
            // 카테고리 검색 조건 - 상위 카테고리 포함
            sql.append("AND (");
            
            // 1. 직접 일치 - 현재 상품의 카테고리가 선택한 카테고리인 경우
            sql.append("p.p_category = ? ");
            
            // 2. 하위 카테고리 포함 - 선택한 카테고리가 상위 카테고리인 경우 
            sql.append("OR EXISTS (SELECT 1 FROM category c WHERE c.category_name = p.p_category AND c.top_category = ?) ");
            
            // 3. 두 단계 아래 카테고리 포함 - 선택한 카테고리가 최상위 카테고리인 경우
            sql.append("OR EXISTS (SELECT 1 FROM category c1 JOIN category c2 ON c1.top_category = c2.category_name WHERE c1.category_name = p.p_category AND c2.top_category = ?) ");
            
            sql.append(") ");
        }
        
        // 사이즈 필터
        if (needsDetailJoin) {
            if (size != null && !size.isEmpty()) {
                sql.append("AND pd.pd_size = ? ");
            }
        }
        
        // 가격 범위 필터
        if (minPrice != null) {
            sql.append("AND p.p_price >= ? ");
        }
        
        if (maxPrice != null) {
            sql.append("AND p.p_price <= ? ");
        }
        
        // 재고 상태 필터 - 특정 사이즈와 결합하여 처리
        if (needsStockFilter) {
            if (needsDetailJoin) {
                // 특정 사이즈의 재고 상태 필터링
                switch (stockStatus) {
                    case "instock":
                        sql.append("AND size_stock.pd_stock > 0 ");
                        break;
                    case "lowstock":
                        sql.append("AND size_stock.pd_stock > 0 AND size_stock.pd_stock <= 15 ");
                        break;
                    case "outofstock":
                        sql.append("AND (size_stock.pd_stock = 0 OR size_stock.pd_stock IS NULL) ");
                        break;
                }
            } else {
                // 전체 상품의 재고 상태 필터링
                switch (stockStatus) {
                    case "instock":
                        sql.append("AND ts.total_stock > 0 ");
                        break;
                    case "lowstock":
                        sql.append("AND ts.total_stock > 0 AND ts.total_stock <= 15 ");
                        break;
                    case "outofstock":
                        sql.append("AND (ts.total_stock = 0 OR ts.total_stock IS NULL) ");
                        break;
                }
            }
        }
        
        // 할인 적용 여부 필터
        if (discount != null && !discount.isEmpty()) {
            if ("yes".equals(discount)) {
                sql.append("AND p.p_disc > 0 ");
            } else if ("no".equals(discount)) {
                sql.append("AND (p.p_disc = 0 OR p.p_disc IS NULL) ");
            }
        }

        try (Connection con = pool.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql.toString())) {

            int idx = 1;
            
            // 검색어 파라미터 설정
            if (keyword != null && !keyword.trim().isEmpty()) {
                pstmt.setString(idx++, "%" + keyword.trim() + "%");
                pstmt.setString(idx++, "%" + keyword.trim() + "%");
            }
            
            // 카테고리 파라미터 설정
            if (category != null && !category.isEmpty()) {
                System.out.println("카테고리 파라미터 설정: " + category);
                
                // 1. 직접 일치
                pstmt.setString(idx++, category);
                
                // 2. 하위 카테고리
                pstmt.setString(idx++, category);
                
                // 3. 두 단계 아래 카테고리
                pstmt.setString(idx++, category);
            }
            
            // 사이즈 파라미터 설정
            if (size != null && !size.isEmpty()) {
                pstmt.setString(idx++, size);
            }
            
            // 가격 범위 파라미터 설정
            if (minPrice != null) {
                pstmt.setInt(idx++, minPrice);
            }
            
            if (maxPrice != null) {
                pstmt.setInt(idx++, maxPrice);
            }

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt(1);
                }
            }

        } catch (Exception e) {
            System.out.println("getTotalProductCountWithAdvancedFilters 오류: " + e.getMessage());
            e.printStackTrace();
        }

        return total;
    }
    
    public ProductDTO getProductById(int id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ProductDTO product = null;
        String sql = "SELECT * FROM product WHERE p_id = ?";
        try {
            con = pool.getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                product = new ProductDTO();
                product.setP_id(rs.getInt("p_id"));
                product.setP_name(rs.getString("p_name"));
                product.setP_category(rs.getString("p_category"));
                product.setP_price(rs.getInt("p_price"));
                product.setP_disc(rs.getInt("p_disc"));
                product.setP_text(rs.getString("p_text"));
                product.setP_color(rs.getString("p_color"));
                product.setCreated_at(rs.getString("created_at"));
                // 등 필요한 필드 추가
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return product;
    }

    // 상품 등록
    public int insertProduct(ProductDTO product) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        int generatedId = 0;
        
        try {
            con = pool.getConnection();
            
            // p_id가 0이면 AUTO_INCREMENT 사용
            if (product.getP_id() == 0) {
                sql = "INSERT INTO product (p_category, p_name, p_price, p_disc, p_text, p_color, created_at) VALUES (?, ?, ?, ?, ?, ?, ?)";
                pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                
                pstmt.setString(1, product.getP_category());
                pstmt.setString(2, product.getP_name());
                pstmt.setInt(3, product.getP_price());
                pstmt.setInt(4, product.getP_disc());
                pstmt.setString(5, product.getP_text());
                pstmt.setString(6, product.getP_color());
                pstmt.setString(7, product.getCreated_at());
            } else {
                // p_id 값이 있으면 해당 ID 사용
                sql = "INSERT INTO product (p_id, p_category, p_name, p_price, p_disc, p_text, p_color, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                
                pstmt.setInt(1, product.getP_id());
                pstmt.setString(2, product.getP_category());
                pstmt.setString(3, product.getP_name());
                pstmt.setInt(4, product.getP_price());
                pstmt.setInt(5, product.getP_disc());
                pstmt.setString(6, product.getP_text());
                pstmt.setString(7, product.getP_color());
                pstmt.setString(8, product.getCreated_at());
            }
            
            int affectedRows = pstmt.executeUpdate();
            
            if (affectedRows > 0) {
                rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    generatedId = rs.getInt(1);
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        
        return generatedId;
    }
    
    // 상품 상세 정보(사이즈, 재고) 등록
    public boolean insertProductDetail(ProductDetailDTO detail) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = "INSERT INTO product_detail (p_id, pd_size, pd_stock) VALUES (?, ?, ?)";
        boolean success = false;
        
        try {
            con = pool.getConnection();
            pstmt = con.prepareStatement(sql);
            
            pstmt.setInt(1, detail.getP_id());
            pstmt.setString(2, detail.getPd_size());
            pstmt.setInt(3, detail.getPd_stock());
            
            int affectedRows = pstmt.executeUpdate();
            if (affectedRows > 0) {
                success = true;
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt);
        }
        
        return success;
    }
    
    // 상품 이미지 등록
    public boolean insertProductImage(ProductImgDTO image) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = "INSERT INTO product_image (p_id, pi_url, pi_orders) VALUES (?, ?, ?)";
        boolean success = false;
        
        try {
            con = pool.getConnection();
            pstmt = con.prepareStatement(sql);
            
            pstmt.setInt(1, image.getP_id());
            pstmt.setString(2, image.getPi_url());
            pstmt.setInt(3, image.getPi_orders());
            
            int affectedRows = pstmt.executeUpdate();
            if (affectedRows > 0) {
                success = true;
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt);
        }
        
        return success;
    }
    
    // 상품 삭제
    public boolean deleteProduct(int p_id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            con = pool.getConnection();
            
            // 트랜잭션 시작
            con.setAutoCommit(false);
            
            // 1. 상품 상세 정보 삭제
            pstmt = con.prepareStatement("DELETE FROM product_detail WHERE p_id = ?");
            pstmt.setInt(1, p_id);
            pstmt.executeUpdate();
            pstmt.close();
            
            // 2. 상품 이미지 정보 삭제
            pstmt = con.prepareStatement("DELETE FROM product_image WHERE p_id = ?");
            pstmt.setInt(1, p_id);
            pstmt.executeUpdate();
            pstmt.close();
            
            // 3. 상품 정보 삭제
            pstmt = con.prepareStatement("DELETE FROM product WHERE p_id = ?");
            pstmt.setInt(1, p_id);
            int affectedRows = pstmt.executeUpdate();
            
            // 트랜잭션 커밋
            con.commit();
            
            if (affectedRows > 0) {
                success = true;
            }
            
        } catch (Exception e) {
            try {
                // 오류 발생 시 롤백
                if (con != null) {
                    con.rollback();
                }
            } catch (SQLException se) {
                se.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                if (con != null) {
                    con.setAutoCommit(true);
                }
            } catch (SQLException se) {
                se.printStackTrace();
            }
            pool.freeConnection(con, pstmt);
        }
        
        return success;
    }

    // 상품 정보 업데이트 메소드 추가
    public boolean updateProduct(ProductDTO product) {
        Connection con = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            con = pool.getConnection();
            String sql = "UPDATE product SET p_name=?, p_category=?, p_price=?, p_disc=?, p_text=?, p_color=? WHERE p_id=?";
            pstmt = con.prepareStatement(sql);
            
            pstmt.setString(1, product.getP_name());
            pstmt.setString(2, product.getP_category());
            pstmt.setInt(3, product.getP_price());
            pstmt.setInt(4, product.getP_disc());
            pstmt.setString(5, product.getP_text());
            pstmt.setString(6, product.getP_color());
            pstmt.setInt(7, product.getP_id());
            
            int affectedRows = pstmt.executeUpdate();
            if (affectedRows > 0) {
                success = true;
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt);
        }
        
        return success;
    }
    
    // 상품 상세 정보(사이즈, 재고) 삭제 메소드 추가
    public boolean deleteProductDetails(int p_id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            con = pool.getConnection();
            String sql = "DELETE FROM product_detail WHERE p_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, p_id);
            
            int affectedRows = pstmt.executeUpdate();
            success = true; // 삭제할 항목이 없어도 성공으로 간주
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt);
        }
        
        return success;
    }

    // 상품 이미지 목록 가져오기
    public List<ProductImgDTO> getProductImages(int p_id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<ProductImgDTO> imageList = new ArrayList<>();
        String sql = "SELECT * FROM product_image WHERE p_id = ? ORDER BY pi_orders ASC";
        
        try {
            con = pool.getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, p_id);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                ProductImgDTO image = new ProductImgDTO();
                image.setPi_id(rs.getInt("pi_id"));
                image.setP_id(rs.getInt("p_id"));
                image.setPi_url(rs.getString("pi_url"));
                image.setPi_orders(rs.getInt("pi_orders"));
                image.setCreated_at(rs.getString("created_at"));
                imageList.add(image);
            }
        } catch (Exception e) {
            System.out.println("getProductImages 오류: " + e.getMessage());
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        
        return imageList;
    }
    
    //한 리뷰에 대한 상품 출력
    public ProductDTO getProductByReview(int r_id) {
    	Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int pd_id = 0;
		int p_id = 0;
		ProductDTO pDto = null;
		try {
			con = pool.getConnection();
			sql = "select pd_id from review where r_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, r_id);
			rs = pstmt.executeQuery();
			if(rs.next())
				pd_id = rs.getInt(1);
			pstmt.close();
			rs.close();
			
			sql = "select p_id from product_detail where pd_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pd_id);
			rs = pstmt.executeQuery();
			if(rs.next()) 
				p_id = rs.getInt(1);
			pstmt.close();
			rs.close();
			
			sql = "select * from product where p_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, p_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				pDto = new ProductDTO(rs.getInt(1), rs.getString(2), 
						rs.getString(3), rs.getString(4), rs.getInt(5), rs.getInt(6), 
						rs.getString(7), rs.getString(8), SDF_DATE.format(rs.getDate(9)));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return pDto;
    }
    
    //한 리뷰에 대한 상품 출력
    public String getProductByReviewSize(int r_id) {
    	Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int pd_id = 0;
		String pd_size = "";
		try {
			con = pool.getConnection();
			sql = "select pd_id from review where r_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, r_id);
			rs = pstmt.executeQuery();
			if(rs.next())
				pd_id = rs.getInt(1);
			pstmt.close();
			rs.close();
			
			sql = "select pd_size from product_detail where pd_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pd_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				pd_size = rs.getString(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return pd_size;
    }
    
    //한 리뷰에 대한 상품 이미지 출력
    public String getProductByReviewImg(int r_id) {
    	Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int pd_id = 0;
		String pd_size = "";
		try {
			con = pool.getConnection();
			sql = "select pd_id from review where r_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, r_id);
			rs = pstmt.executeQuery();
			if(rs.next())
				pd_id = rs.getInt(1);
			pstmt.close();
			rs.close();
			
			sql = "select p_id from product_detail where pd_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pd_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				pd_size = rs.getString(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return pd_size;
    }
}
