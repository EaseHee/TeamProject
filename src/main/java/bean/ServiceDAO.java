package bean;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ServiceDAO {

    private Context context = null;
    private DataSource dataSource = null;

    private Connection connection;
    private PreparedStatement statement;
    private ResultSet resultSet;

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

    public Set<ServiceDTO> getAllServices() {
        Set<ServiceDTO> serviceSet = new HashSet<>();
        String sql = "SELECT * FROM service ORDER BY service_code DESC";

        try {
            connection = dataSource.getConnection();
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                ServiceDTO serviceDTO = new ServiceDTO();
                serviceDTO.setService_code(resultSet.getString("service_code"));
                serviceDTO.setService_name(resultSet.getString("service_name"));
                serviceDTO.setService_price(resultSet.getInt("service_price"));
                serviceSet.add(serviceDTO);
            }
        } catch (Exception e) {
            System.out.println("[getAllServices] Message : " + e.getMessage());
            System.out.println("[getAllServices] Class   : " + e.getClass().getSimpleName());
        } finally {
            freeConnection();
        }

        return serviceSet;
    }
    
    public Set<ServiceDTO> getServicesByName(String service_name) {
        Set<ServiceDTO> serviceSet = new HashSet<>();
        String sql = "SELECT * FROM service WHERE service_name LIKE ?";

        try {
            connection = dataSource.getConnection();
            statement = connection.prepareStatement(sql);
            // LIKE 연산자와 '%'를 사용하여 부분 문자열 검색
            statement.setString(1, "%" + service_name + "%");
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                ServiceDTO serviceDTO = new ServiceDTO();
                serviceDTO.setService_code(resultSet.getString("service_code"));
                serviceDTO.setService_name(resultSet.getString("service_name"));
                serviceDTO.setService_price(resultSet.getInt("service_price"));
                serviceSet.add(serviceDTO);
            }
        } catch (Exception e) {
            System.out.println("[getServicesByName] Message : " + e.getMessage());
            System.out.println("[getServicesByName] Class   : " + e.getClass().getSimpleName());
        } finally {
            freeConnection();
        }

        return serviceSet;
    }
    public Set<ServiceDTO> getServicesWithPaging(int currentPage, int recordsPerPage) {
        Set<ServiceDTO> services = new HashSet<>();

        int start = (currentPage - 1) * recordsPerPage;

        try {
            connection = dataSource.getConnection();        // ser_code를 기준으로 내림차순 정렬
            String sql = "SELECT * FROM service ORDER BY service_code DESC LIMIT ?, ?";
            statement = connection.prepareStatement(sql);
            statement.setInt(1, start);
            statement.setInt(2, recordsPerPage);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                ServiceDTO service = new ServiceDTO();
                service.setService_code(resultSet.getString("service_code"));
                service.setService_name(resultSet.getString("service_name"));
                service.setService_price(resultSet.getInt("service_price"));
                services.add(service);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                freeConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return services;
    }

    public int getTotalServiceCount() {
        int total = 0;

        try {
            connection = dataSource.getConnection();
            String sql = "SELECT COUNT(*) FROM service";
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                total = resultSet.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            freeConnection();
        }

        return total;
    }
    
    public void insertService(String service_code, String service_name, int service_price) { 
        System.out.println("Service Code: " + service_code);
        System.out.println("Service Name: " + service_name);
        System.out.println("Service Price: " + service_price);

        String sql = "INSERT INTO service (service_code, service_name, service_price) VALUES (?, ?, ?)";

        try {
            connection = dataSource.getConnection();
            statement = connection.prepareStatement(sql);

            // 파라미터 바인딩
            statement.setString(1, service_code);
            statement.setString(2, service_name);
            statement.setInt(3, service_price);

            // 실행
            statement.executeUpdate();
            System.out.println("DB에 서비스가 성공적으로 추가되었습니다.");

        } catch (SQLException e) {
            System.out.println("[insertService] Message : " + e.getMessage());
            System.out.println("[insertService] Class   : " + e.getClass().getSimpleName());
        } finally {
            try {
                freeConnection();
            } catch (Exception e) {
                System.out.println("[freeConnection] Message : " + e.getMessage());
                System.out.println("[freeConnection] Class   : " + e.getClass().getSimpleName());
            }
        }
    }
    
    // 서비스 코드로 서비스 정보 조회
    public ServiceDTO getServiceDetail(String code) {
        ServiceDTO service = null;
        String sql = "SELECT * FROM service WHERE service_code=?";

        try {
            connection = dataSource.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, code);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                service = new ServiceDTO();
                service.setService_code(resultSet.getString("service_code"));
                service.setService_name(resultSet.getString("service_name"));
                service.setService_price(resultSet.getInt("service_price"));
            }
        } catch (SQLException e) {
            System.out.println("[getServiceByCode] Message : " + e.getMessage());
            System.out.println("[getServiceByCode] Class   : " + e.getClass().getSimpleName());
        } finally {
            freeConnection();
        }

        return service;
    }

    public boolean updateService(String service_code, String service_name, int service_price) {
        Connection connection = null;
        PreparedStatement statement = null;
        
        String sql = "UPDATE service SET service_name = ?, service_price = ? WHERE service_code = ?";
        try {
            connection = dataSource.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, service_name);
            statement.setInt(2, service_price);
            statement.setString(3, service_code);

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0; // 업데이트 성공 여부 반환

        } catch (Exception e) {
            e.printStackTrace();
            return false; // 오류 발생 시 false 반환
        } finally {
            try {
            	freeConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
	public void deleteService(String service_code) {
   		String sql = "DELETE FROM service WHERE service_code=?";
   		
   	 try {
   		connection = dataSource.getConnection();
        statement = connection.prepareStatement(sql);
        statement.setString(1, service_code);
        statement.executeUpdate(); // DML 문법
         
	   	} catch (Exception e) {
	         System.out.println("deleteService : " + e);
	   	}
	         finally {
	        	 freeConnection();
	    }
	  }
	
	//예약 서비스명 조회
    public List<String> getAllServiceNames() throws SQLException {
	    List<String> serviceNames = new ArrayList<>();
	    String query = "SELECT service_name FROM service"; // 'ser' 테이블에서 서비스 명 가져옴

	    try {
	        connection = dataSource.getConnection();
	        statement = connection.prepareStatement(query);
	        resultSet = statement.executeQuery();

	        while (resultSet.next()) {
	            serviceNames.add(resultSet.getString("service_name"));
	        }
	    } 
	    catch (SQLException e) {
            System.out.println("[getAllServiceNames] Message : " + e.getMessage());
            System.out.println("[getAllServiceNames] Class   : " + e.getClass().getSimpleName());
        }
	    finally {
	        freeConnection(); // freeConnection을 finally 블록에서 호출하여 자원을 반환
	    }
	    return serviceNames;
	}
}
