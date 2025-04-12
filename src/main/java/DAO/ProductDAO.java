package DAO;

import java.sql.*;
import java.util.*;
import DTO.ProductDTO;
import DTO.ProductImgDTO;
import DTO.ProductDetailDTO;

public class ProductDAO {
    private DBConnectionMgr pool;

    public ProductDAO() {
        pool = DBConnectionMgr.getInstance();
    }

    // 상품 리스트 가져오기
    public List<ProductDTO> getProductList(int start, int count) {
        List<ProductDTO> productList = new ArrayList<>();
        String sql = "SELECT * FROM product ORDER BY p_id DESC LIMIT ?, ?";

        try (Connection con = pool.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setInt(1, start);
            pstmt.setInt(2, count);

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
            System.out.println("getProductList 오류: " + e.getMessage());
            e.printStackTrace();
        }
        return productList;
    }

    // 전체 상품 수
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
            e.printStackTrace();
        }
        return url;
    }

    // 상품 총 재고
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
}
