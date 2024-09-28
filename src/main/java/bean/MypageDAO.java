package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class MypageDAO {
	private Context context = null;
    private DataSource dataSource = null;

    private Connection connection = null;
    private PreparedStatement statement = null;
    private ResultSet resultSet = null;
    
    private String MANAGER_UPDATE = "UPDATE manager SET name = ?, tel = ?, email = ? WHERE branch_code = ?";
    
    public MypageDAO () {
        try {
            context = new InitialContext();
            dataSource = (DataSource) context.lookup("java:comp/env/jdbc/acorn");
        } catch (NamingException e) {
            System.out.println("[MypageDAO] Message : " + e.getMessage());
            System.out.println("[MypageDAO] Class   : " + e.getClass().getSimpleName());
        }
    }

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

    public void updateManager(MypageDTO dto) {
    	try {
    		Class.forName("org.mariadb.jdbc.Driver");
            connection = dataSource.getConnection();
            statement = connection.prepareStatement(MANAGER_UPDATE);
            statement.setString(1, dto.getBranch_code());
            statement.setString(2, dto.getManager_name());
            statement.setString(3, dto.getManager_tel());
            statement.setString(4, dto.getManager_mail());
            statement.executeUpdate();
    		
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("[getAdmin] Message : " + e.getMessage());
            System.out.println("[getAdmin] Class   : " + e.getClass().getSimpleName());
        } finally {
            freeConnection();
        }
    }
}
