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

public class OrderDAO {
    
    private Context context = null;
    private DataSource dataSource = null;

    private Connection connection = null;
    private PreparedStatement statement = null;
    private ResultSet resultSet = null;

    public OrderDAO () {
        try {
            context = new InitialContext();
            dataSource = (DataSource) context.lookup("java:comp/env/jdbc/acorn");
        } catch (NamingException e) {
            System.out.println("[OrderDAO] Message : " + e.getMessage());
            System.out.println("[OrderDAO] Class   : " + e.getClass().getSimpleName());
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

	public List<OrderDTO> getProduct_B_List() {
		String sql = "SELECT product_name FROM product_B";
		ArrayList<OrderDTO> list = new ArrayList<>();  
	
	    try {
	        connection = dataSource.getConnection();
	  
	        statement = connection.prepareStatement(sql);
	        resultSet = statement.executeQuery();
	
	        while(resultSet.next()) {
	            OrderDTO board = new OrderDTO();
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
	
	public List<OrderDTO> getProductList(String product_B_code) {
		String str = product_B_code.substring(0, 2);
		String sql = "SELECT product_name FROM product WHERE product_code LIKE '" + str + "%' ";
		ArrayList<OrderDTO> list = new ArrayList<>();
	
	    try {
	        connection = dataSource.getConnection();
	  
	        statement = connection.prepareStatement(sql);
	        resultSet = statement.executeQuery();
	
	        while(resultSet.next()) {
	            OrderDTO board = new OrderDTO();
	            board.setProduct_name(resultSet.getString("product_name"));
	
	            list.add(board);
	        }
	    } catch (Exception e) {
	        System.out.println("[getProductList] Message : " + e.getMessage());
	        System.out.println("[getProductList] Class   : " + e.getClass().getSimpleName());
	    } finally {
	        freeConnection();
	    }	    
	    return list;
	}
}
