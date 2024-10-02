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
    
    private String MANAGER_UPDATE = "UPDATE manager SET manager_name = ?, manager_tel = ?, manager_mail = ? WHERE branch_code = ?";

    public MypageDAO () {
        try {
            context = new InitialContext();
            dataSource = (DataSource) context.lookup("java:comp/env/jdbc/acorn");
        } catch (NamingException e) {
            System.out.println("[MypageDAO] Message : " + e.getMessage());
        }
    }

    // DB 연결 해제 메소드
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
        }
    }

    // 관리자 정보 업데이트 메소드
    public void updateManager(MypageDTO dto) {
        try {
            connection = dataSource.getConnection();
            statement = connection.prepareStatement(MANAGER_UPDATE);
            statement.setString(1, dto.getManager_name());
            statement.setString(2, dto.getManager_tel());
            statement.setString(3, dto.getManager_mail());
            statement.setString(4, dto.getBranch_code());
            statement.executeUpdate();
        } catch (SQLException e) {
            System.out.println("[updateManager] Message : " + e.getMessage());
        } finally {
            freeConnection();
        }
    }
    
    // branchcode로 관리자 정보 조회 메소드
    public MypageDTO getManagerInfo(String branchcode) {
        MypageDTO manager = null;
        try {
            connection = dataSource.getConnection();
            String sql = "SELECT manager_name, manager_tel, manager_mail FROM manager WHERE branch_code = ?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, branchcode);
            resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                manager = new MypageDTO();
                manager.setManager_name(resultSet.getString("manager_name"));
                manager.setManager_tel(resultSet.getString("manager_tel"));
                manager.setManager_mail(resultSet.getString("manager_mail"));
                manager.setBranch_code(branchcode);  // branchcode는 쿼리에서 가져오는 값이 아니므로 그대로 설정
                
                //조회된 관리자 정보 확인
                System.out.println("조회된 관리자 정보 확인 branch_code: " + branchcode);
            } else {
                //조회된 데이터가 없을 경우
                System.out.println("조회된 데이터가 없을 경우 branch_code: " + branchcode);
            }
            
        } catch (SQLException e) {
            // 예외 발생 시 로그 출력
            System.out.println("getManagerInfo Error: " + e.getMessage());
        } finally {
            freeConnection();
        }
        return manager;
    }

}
