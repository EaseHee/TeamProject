package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ProductDAO {
    
    private Context context = null;
    private DataSource dataSource = null;

    private Connection connection = null;
    private PreparedStatement statement = null;
    private ResultSet resultSet = null;

    public ProductDAO () {
        try {
            context = new InitialContext();
            dataSource = (DataSource) context.lookup("java:comp/env/jdbc/acorn");
        } catch (NamingException e) {
            System.out.println("[ProductDAO] Message : " + e.getMessage());
            System.out.println("[ProductDAO] Class   : " + e.getClass().getSimpleName());
        }
    }
        
    /* DB 연결 해제 */
    public void freeConnection() {
        try {
            if (connection != null) {
                connection.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (resultSet != null) {
                resultSet.close();
            }
        } catch (SQLException e) {
            System.out.println("[freeConnection] Message : " + e.getMessage());
            System.out.println("[freeConnection] Class   : " + e.getClass().getSimpleName());
        }
    }

    /* 
		product.jsp(상품 관리)
		> product_B 테이블 조회
	*/
	//상품 리스트 조회(대분류 페이지 조회)
	public List<ProductDTO> getProduct_B_List(String keyWord) {
		String sql = "";
		ArrayList<ProductDTO> list = new ArrayList<>();
	    
	    if(keyWord == null || keyWord.isEmpty()) {
	    	sql = "SELECT product_B_code, product_name FROM product_B";
	    } else {
	    	sql = "SELECT product_B_code, product_name FROM product_B WHERE product_name like '%" + keyWord + "%'";
	    }
	
	    try {
	        connection = dataSource.getConnection();
	  
	        statement = connection.prepareStatement(sql);
	        resultSet = statement.executeQuery();
	
	        while(resultSet.next()) {
	            ProductDTO board = new ProductDTO();
	            board.setProduct_B_code(resultSet.getString("product_B_code"));
	            board.setProduct_name(resultSet.getString("product_name"));
	
	            list.add(board);
	        }
	    } catch (Exception e) {
	        System.out.println("[getProduct_B_List] Message : " + e.getMessage());
	        System.out.println("[getProduct_B_List] Class   : " + e.getClass().getSimpleName());
	    } finally {
	        freeConnection();
	    }
	    
	    return list;
	}

    /*
		product_detail.jsp
		(product.jsp > product_detail.jsp로 이동했을 때 조회되는 화면)
	*/
	//상품 리스트 조회(소분류 페이지 조회)
	public List<ProductDTO> getProductList(String product_B_code, String keyWord) {
		String sql = "";
		ArrayList<ProductDTO> list = new ArrayList<>();
		
		if(keyWord == null || keyWord.isEmpty()) {
        	sql = "SELECT product.product_code, product.product_name, product.product_price, product.product_ea "
                + "FROM product "
                + "JOIN product_B ON product.product_B_code = product_B.product_B_code "
                + "WHERE product_B.product_B_code=?";
        } else {
        	sql = "SELECT product.product_code, product.product_name, product.product_price, product.product_ea "
                + "FROM product "
                + "JOIN product_B ON product.product_B_code = product_B.product_B_code "
                + "WHERE product_B.product_B_code=? AND product.product_name like '%" + keyWord + "%'";
        }
		
		try {
			connection = dataSource.getConnection();			
			statement = connection.prepareStatement(sql);
			statement.setString(1, product_B_code);
			resultSet = statement.executeQuery();
			
			while(resultSet.next()){
				ProductDTO board = new ProductDTO();
				board.setProduct_code(resultSet.getString("product_code"));
				board.setProduct_name(resultSet.getString("product_name"));
				board.setProduct_price(resultSet.getInt("product_price"));
				board.setProduct_ea(resultSet.getInt("product_ea"));
				
				list.add(board);
			}
		} catch (SQLException e) {
            System.out.println("[getProductList] Message : " + e.getMessage());
            System.out.println("[getProductList] Class   : " + e.getClass().getSimpleName());
        } finally {
			freeConnection();
		}
		return list;
	}
	
	/*
		product_B_read.jsp
		(prproductuct.jsp > product_B_read.jsp로 이동했을 때 대분류에 대한 정보
	*/
	//대분류 개별 조회(샴푸, 린스 등...)
	public ProductDTO getProductBOne(String product_B_code) {
		String sql = "SELECT product_B_code, product_name FROM product_B WHERE product_B_code=?";
		
		ProductDTO board = new ProductDTO();
		
		board.setProduct_B_code(product_B_code);
		
		try {
			connection = dataSource.getConnection();
	        
	        statement = connection.prepareStatement(sql);
	        
	        statement.setString(1, product_B_code);
	        
	        resultSet = statement.executeQuery();
	        
	        if(resultSet.next()) {
	        	board.setProduct_B_code(resultSet.getString("product_B_code"));
	        	board.setProduct_name(resultSet.getString("product_name"));
	        }
		} catch(Exception e) {
			System.out.println("[getProductBOne] Message : " + e.getMessage());
			System.out.println("[getProductBOne] Class   : " + e.getClass().getSimpleName());
		} finally {
			freeConnection();
		}
		
		return board;
	}
	
	/*
		product_read.jsp
		(prproductuct_detail.jsp > product_read.jsp로 이동했을 때 상품에 대한 정보
	*/
	//개별 상품 조회(미장센, 려 등...)
	public ProductDTO getProductOne(String product_B_code, String product_code) {
		String sql = "SELECT product_B.product_B_code, product.product_code, product.product_name, product.product_price, product.product_ea "
			       + "FROM product "
			       + "JOIN product_B ON product.product_B_code = product_B.product_B_code "
			       + "WHERE product_B.product_B_code=? AND product.product_code=?";
		
		ProductDTO board = new ProductDTO();
		
		board.setProduct_B_code(product_B_code);
		
		try {
			connection = dataSource.getConnection();
	        
	        statement = connection.prepareStatement(sql);
	        
	        statement.setString(1, product_B_code);
	        statement.setString(2, product_code);
	        
	        resultSet = statement.executeQuery();
	        
	        if(resultSet.next()) {
	        	board.setProduct_B_code(resultSet.getString("product_B_code"));
	        	board.setProduct_code(resultSet.getString("product_code"));
	        	board.setProduct_name(resultSet.getString("product_name"));
	        	board.setProduct_price(resultSet.getInt("product_price"));
	        	board.setProduct_ea(resultSet.getInt("product_ea"));
	        }
		} catch(Exception e) {
			System.out.println("[getProductOne] Message : " + e.getMessage());
			System.out.println("[getProductOne] Class   : " + e.getClass().getSimpleName());
		} finally {
			freeConnection();
		}
		
		return board;
	}
	
	/*
		product_B_add.jsp, product_B_addProc.jsp
	*/
	//대분류 및 상품 등록
	public void setBProduct(ProductDTO board) {
		String sql = "";
		
		try {
			connection = dataSource.getConnection();
	        
	        sql = "INSERT INTO product_B(product_B_code, product_name) "
	        		 + "VALUES(?, ?)";
	        
	        statement = connection.prepareStatement(sql);
	        
	        statement.setString(1, board.getProduct_B_code());
	        statement.setString(2, board.getProduct_name());
	        
	        statement.executeUpdate();
		} catch(Exception e) {
			System.out.println("[setBProduct] Message : " + e.getMessage());
			System.out.println("[setBProduct] Class   : " + e.getClass().getSimpleName());
		} finally {
			freeConnection();
		}
	}
	
	/*
		product_add.jsp, product_addProc.jsp
	*/
	//개별 상품 등록
	public void setProductOne(ProductDTO board) {
		String sql = "INSERT INTO product(product_B_code, product_code, product_name, product_price, product_ea) "
	   	           + "VALUES(?, ?, ?, ?, ?)";
		
		try {
			connection = dataSource.getConnection();
	        
	        statement = connection.prepareStatement(sql);
	        
	        statement.setString(1, board.getProduct_B_code());
	        statement.setString(2, board.getProduct_code());
	        statement.setString(3, board.getProduct_name());
	        statement.setInt(4, board.getProduct_price());
	        statement.setInt(5, board.getProduct_ea());
	        
	        statement.executeUpdate();
		} catch(Exception e) {
			System.out.println("[setProductOne] Message : " + e.getMessage());
			System.out.println("[setProductOne] Class   : " + e.getClass().getSimpleName());
		} finally {
			freeConnection();
		}
	}
	
	/*
		product_update.jsp
	*/
	//상품 수정
	public void updateProductOne(ProductDTO board) {
		String sql = "UPDATE product SET product_name=?, product_price=?, product_ea=? WHERE product_code=?";
	
		try {
			connection = dataSource.getConnection();
	        statement = connection.prepareStatement(sql);
			
	        statement.setString(1, board.getProduct_name());
	        statement.setInt(2, board.getProduct_price());
	        statement.setInt(3, board.getProduct_ea());
	        statement.setString(4, board.getProduct_code());
			
	        statement.executeUpdate();
		} catch(Exception e) {
			System.out.println("[updateProductOne] Message : " + e.getMessage());
			System.out.println("[updateProductOne] Class   : " + e.getClass().getSimpleName());
		} finally {
			freeConnection();
		}
	}
	
	/*
		product_B_delete.jsp
	*/
	//대분류 삭제
	public void deleteBProduct(String product_B_code) {
		String sql = "DELETE FROM product_B WHERE product_B_code=?";
		
		try {
			connection = dataSource.getConnection();
	        statement = connection.prepareStatement(sql);
			
	        statement.setString(1, product_B_code);
	        
	        statement.executeUpdate();
		} catch(Exception e) {
			System.out.println("[deleteBProduct] Message : " + e.getMessage());
			System.out.println("[deleteBProduct] Class   : " + e.getClass().getSimpleName());
		} finally {
			freeConnection();
		}
	}
	
	/*
		product_delete.jsp
	*/
	//상품 삭제
	public void deleteProductOne(String product_B_code, String product_code) {
		String sql = "DELETE FROM product WHERE product_B_code=? AND product_code=?";
		
		try {
			connection = dataSource.getConnection();
	        statement = connection.prepareStatement(sql);
			
	        statement.setString(1, product_B_code);
	        statement.setString(2, product_code);
	        
	        statement.executeUpdate();
		} catch(Exception e) {
			System.out.println("[delelteProductOne] Message : " + e.getMessage());
			System.out.println("[delelteProductOne] Class   : " + e.getClass().getSimpleName());
		} finally {
			freeConnection();
		}
	}
	
	/* 대시보드 - 재고수량 */
	public List<ProductDTO> getProductToDashBoard() {
		
		String sql = "SELECT product_name, product_ea FROM product WHERE product_ea < 4";
		ArrayList<ProductDTO> list = new ArrayList<>();
		
		try {
			connection = dataSource.getConnection();			
			statement = connection.prepareStatement(sql);
			resultSet = statement.executeQuery();
			
			while(resultSet.next()){
				ProductDTO board = new ProductDTO();
				board.setProduct_name(resultSet.getString("product_name"));
				board.setProduct_ea(resultSet.getInt("product_ea"));
				
				list.add(board);
			}
		} catch (SQLException e) {
            System.out.println("[getProductToDashBoard] Message : " + e.getMessage());
            System.out.println("[getProductToDashBoard] Class   : " + e.getClass().getSimpleName());
        } finally {
			freeConnection();
		}
		return list;
	}
}
