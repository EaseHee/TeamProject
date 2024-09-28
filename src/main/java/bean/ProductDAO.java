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
		> pd_B 테이블 조회
	*/
	//상품 리스트 조회(대분류 페이지 조회)
	public List<ProductDTO> getProduct_B_List(String keyWord) {
		String sql = "";
		ArrayList<ProductDTO> list = new ArrayList<>();
	    
	    if(keyWord == null || keyWord.isEmpty()) {
	    	sql = "SELECT pd_B_code, pd_name FROM pd_B";
	    } else {
	    	sql = "SELECT pd_B_code, pd_name FROM pd_B WHERE pd_name like '%" + keyWord + "%'";
	    }
	
	    try {
	        connection = dataSource.getConnection();
	  
	        statement = connection.prepareStatement(sql);
	        resultSet = statement.executeQuery();
	
	        while(resultSet.next()) {
	            ProductDTO board = new ProductDTO();
	            board.setPd_B_code(resultSet.getString("pd_B_code"));
	            board.setPd_name(resultSet.getString("pd_name"));
	
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
	public List<ProductDTO> getProductList(String pd_B_code, String keyWord) {
		String sql = "";
		ArrayList<ProductDTO> list = new ArrayList<>();
		
		if(keyWord == null || keyWord.isEmpty()) {
        	sql = "SELECT pd.pd_code, pd.pd_name, pd.pd_price, pd.pd_ea "
                + "FROM pd "
                + "JOIN pd_B ON pd.pd_B_code = pd_B.pd_B_code "
                + "WHERE pd_B.pd_B_code=?";
        } else {
        	System.out.println("키워드 존재");
        	System.out.println(keyWord);
        	/*sql = "SELECT pd.pd_code, pd.pd_name, pd.pd_price, pd.pd_ea "
                + "FROM pd "
                + "JOIN pd_B ON pd.pd_B_code = pd_B.pd_B_code "
                + "WHERE pd_B.pd_B_code=? AND pd.pd_name like '%" + keyWord + "%'";*/
        	sql = "SELECT * FROM pd WHERE " + keyWord + "%'";
        }
		
		try {
			connection = dataSource.getConnection();			
			statement = connection.prepareStatement(sql);
			statement.setString(1, pd_B_code);
			resultSet = statement.executeQuery();
			
			while(resultSet.next()){
				ProductDTO board = new ProductDTO();
				board.setPd_code(resultSet.getString("pd_code"));
				board.setPd_name(resultSet.getString("pd_name"));
				board.setPd_price(resultSet.getInt("pd_price"));
				board.setPd_ea(resultSet.getInt("pd_ea"));
				
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
		(prpduct.jsp > product_B_read.jsp로 이동했을 때 대분류에 대한 정보
	*/
	//대분류 개별 조회(샴푸, 린스 등...)
	public ProductDTO getProductBOne(String pd_B_code) {
		String sql = "SELECT pd_B_code, pd_name FROM pd_B WHERE pd_B_code=?";
		
		ProductDTO board = new ProductDTO();
		
		board.setPd_B_code(pd_B_code);
		
		try {
			connection = dataSource.getConnection();
	        
	        statement = connection.prepareStatement(sql);
	        
	        statement.setString(1, pd_B_code);
	        
	        resultSet = statement.executeQuery();
	        
	        if(resultSet.next()) {
	        	board.setPd_B_code(resultSet.getString("pd_B_code"));
	        	board.setPd_name(resultSet.getString("pd_name"));
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
		(prpduct_detail.jsp > product_read.jsp로 이동했을 때 상품에 대한 정보
	*/
	//개별 상품 조회(미장센, 려 등...)
	public ProductDTO getProductOne(String pd_B_code, String pd_code) {
		String sql = "SELECT pd_B.pd_B_code, pd.pd_code, pd.pd_name, pd.pd_price, pd.pd_ea "
			       + "FROM pd "
			       + "JOIN pd_B ON pd.pd_B_code = pd_B.pd_B_code "
			       + "WHERE pd_B.pd_B_code=? AND pd.pd_code=?";
		
		ProductDTO board = new ProductDTO();
		
		board.setPd_B_code(pd_B_code);
		
		try {
			connection = dataSource.getConnection();
	        
	        statement = connection.prepareStatement(sql);
	        
	        statement.setString(1, pd_B_code);
	        statement.setString(2, pd_code);
	        
	        resultSet = statement.executeQuery();
	        
	        if(resultSet.next()) {
	        	board.setPd_B_code(resultSet.getString("pd_B_code"));
	        	board.setPd_code(resultSet.getString("pd_code"));
	        	board.setPd_name(resultSet.getString("pd_name"));
	        	board.setPd_price(resultSet.getInt("pd_price"));
	        	board.setPd_ea(resultSet.getInt("pd_ea"));
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
	        
	        sql = "INSERT INTO pd_B(pd_B_code, pd_name) "
	        		 + "VALUES(?, ?)";
	        
	        statement = connection.prepareStatement(sql);
	        
	        statement.setString(1, board.getPd_B_code());
	        statement.setString(2, board.getPd_name());
	        
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
		String sql = "INSERT INTO pd(pd_B_code, pd_code, pd_name, pd_price, pd_ea) "
	   	           + "VALUES(?, ?, ?, ?, ?)";
		
		try {
			connection = dataSource.getConnection();
	        
	        statement = connection.prepareStatement(sql);
	        
	        statement.setString(1, board.getPd_B_code());
	        statement.setString(2, board.getPd_code());
	        statement.setString(3, board.getPd_name());
	        statement.setInt(4, board.getPd_price());
	        statement.setInt(5, board.getPd_ea());
	        
	        statement.executeUpdate();
		} catch(Exception e) {
			System.out.println("[setProductOne] Message : " + e.getMessage());
			System.out.println("[setProductOne] Class   : " + e.getClass().getSimpleName());
		} finally {
			freeConnection();
		}
	}
	
	/*
		product_read_action(update).jsp
	*/
	//상품 수정
	public void updateProductOne(ProductDTO board) {
		String sql = "UPDATE pd SET pd_name=?, pd_price=?, pd_ea=? WHERE pd_code=?";
	
		try {
			connection = dataSource.getConnection();
	        statement = connection.prepareStatement(sql);
			
	        statement.setString(1, board.getPd_name());
	        statement.setInt(2, board.getPd_price());
	        statement.setInt(3, board.getPd_ea());
	        statement.setString(4, board.getPd_code());
			
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
	public void delelteBProduct(String pd_B_code) {
		String sql = "DELETE FROM pd_B WHERE pd_B_code=?";
		
		try {
			connection = dataSource.getConnection();
	        statement = connection.prepareStatement(sql);
			
	        statement.setString(1, pd_B_code);
	        
	        statement.executeUpdate();
		} catch(Exception e) {
			System.out.println("[delelteBProduct] Message : " + e.getMessage());
			System.out.println("[delelteBProduct] Class   : " + e.getClass().getSimpleName());
		} finally {
			freeConnection();
		}
	}
	
	/*
		product_read_action(delete).jsp
	*/
	//상품 삭제
	public void delelteProductOne(String pd_B_code, String pd_code) {
		String sql = "DELETE FROM pd WHERE pd_B_code=? AND pd_code=?";
		
		try {
			connection = dataSource.getConnection();
	        statement = connection.prepareStatement(sql);
			
	        statement.setString(1, pd_B_code);
	        statement.setString(2, pd_code);
	        
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
		
		String sql = "SELECT pd_name, pd_ea FROM pd WHERE pd_ea < 4";
		ArrayList<ProductDTO> list = new ArrayList<>();
		
		try {
			connection = dataSource.getConnection();			
			statement = connection.prepareStatement(sql);
			resultSet = statement.executeQuery();
			
			while(resultSet.next()){
				ProductDTO board = new ProductDTO();
				board.setPd_name(resultSet.getString("pd_name"));
				board.setPd_ea(resultSet.getInt("pd_ea"));
				
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
