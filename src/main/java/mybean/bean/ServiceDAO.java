package mybean.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ServiceDAO {
    
    private Context context = null;
    private DataSource dataSource = null;

    private Connection connection = null;
    private PreparedStatement statement = null;
    private ResultSet resultSet = null;

    public ServiceDAO () {
        try {
            context = new InitialContext();
            dataSource = (DataSource) context.lookup("java:comp/env/jdbc/acorn");
        } catch (NamingException e) {
            System.out.println("[Constructor] Message : " + e.getMessage());
            System.out.println("[Constructor] Class   : " + e.getClass().getSimpleName());
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
    // 저장할 자료구조로 변경해주세요.
    public java.util.Set<ServiceDTO> getService(String ser_code) {
        java.util.Set<ServiceDTO> set = new java.util.HashSet<>();
        String sql;
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            connection = dataSource.getConnection();

            sql = "SELECT * FROM ser WHERE ser_code=?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, ser_code);
            resultSet = statement.executeQuery();

            while(resultSet.next()) {
                ServiceDTO DTO = new ServiceDTO();
                DTO.setSer_code(resultSet.getString("ser_code"));
                DTO.setSer_name(resultSet.getString("ser_name"));
                DTO.setSer_price(resultSet.getInt("ser_price"));
                DTO.setSer_cnt(resultSet.getInt("ser_cnt"));

                set.add(DTO);
            }
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("[getService] Message : " + e.getMessage());
            System.out.println("[getService] Class   : " + e.getClass().getSimpleName());
        } finally {
            freeConnection();
        }
        return set;
    }
*/
}
