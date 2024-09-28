package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class BranchDAO {
    private Context context = null;
    private DataSource dataSource = null;

    private Connection connection = null;
    private PreparedStatement statement = null;
    private ResultSet resultSet = null;
    
    private String BRANCH_LIST = "select * from branch";
    private String BRANCH_INSERT = "insert into branch values(?, ?, ?, ?, ?, ?)";
    private	String BRANCH_GET = "select * from branch where branch_code = ?";
    
    public BranchDAO () {
        try {
            context = new InitialContext();
            dataSource = (DataSource) context.lookup("java:comp/env/jdbc/acorn");
        } catch (NamingException e) {
            System.out.println("[BranchDAO] Message : " + e.getMessage());
            System.out.println("[BranchDAO] Class   : " + e.getClass().getSimpleName());
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
    
    // 회원 등록
    public void insertBranch(BranchDTO dto) {
    	try {
    		Class.forName("org.mariadb.jdbc.Driver");
            connection = dataSource.getConnection();
            statement = connection.prepareStatement(BRANCH_INSERT);
            statement.setString(1, dto.getBranch_code());
            statement.setString(2, dto.getBranch_pw());
            statement.setString(3, dto.getBranch_name());
            statement.setString(4, dto.getBranch_tel());
            statement.setString(5, dto.getBranch_address());
            statement.setString(6, dto.getBranch_note());
            statement.executeUpdate();
    		
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("[getBranch] Message : " + e.getMessage());
            System.out.println("[getBranch] Class   : " + e.getClass().getSimpleName());
        } finally {
            freeConnection();
        }
    }
    
    // 로그인 회원 조회
    public BranchDTO getBranch(BranchDTO dto) {
    	BranchDTO branch = null;
    	try {
    		Class.forName("org.mariadb.jdbc.Driver");
            connection = dataSource.getConnection();
            statement = connection.prepareStatement(BRANCH_GET);
    		statement.setString(1, dto.getBranch_code());
    		resultSet = statement.executeQuery();
    		
    		while(resultSet.next()) {
                branch = new BranchDTO();
                branch.setBranch_code(resultSet.getString("branch_code"));
                branch.setBranch_pw(resultSet.getString("branch_pw"));
                branch.setBranch_name(resultSet.getString("branch_name"));
                branch.setBranch_tel(resultSet.getString("branch_tel"));
                branch.setBranch_address(resultSet.getString("branch_address"));
    		}
    	} catch (Exception e) {
            System.out.println("[getBranch] Message : " + e.getMessage());
            System.out.println("[getBranch] Class   : " + e.getClass().getSimpleName());
        } finally {
            freeConnection();
        }
		return branch;
    }
  
/*  
    // 저장할 자료구조로 변경해주세요.
    public java.util.Set<AdminDTO> getAdmin(String ad_id) {
        java.util.Set<AdminDTO> set = new java.util.HashSet<>();
        String sql;
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            connection = dataSource.getConnection();

            sql = "SELECT * FROM admin WHERE ad_id=?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, ad_id);
            resultSet = statement.executeQuery();

            while(resultSet.next()) {
                AdminDTO DTO = new AdminDTO();
                DTO.setAd_id(resultSet.getString("ad_id"));
                DTO.setAd_name(resultSet.getString("ad_name"));
                DTO.setAd_ph(resultSet.getString("ad_ph"));
                DTO.setAd_mail(resultSet.getString("ad_mail"));

                set.add(DTO);
            }
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("[getAdmin] Message : " + e.getMessage());
            System.out.println("[getAdmin] Class   : " + e.getClass().getSimpleName());
        } finally {
            freeConnection();
        }
        return set;
    }
*/
}