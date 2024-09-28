package bean;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.json.*;

public class DashboardDAO {
    private Context context = null;
    private DataSource dataSource = null;
    private Connection connection = null;
    private PreparedStatement statement = null;
    private ResultSet resultSet = null;
    
    public DashboardDAO () {
        try {
            context = new InitialContext();
            dataSource = (DataSource) context.lookup("java:comp/env/jdbc/acorn");
        } catch (NamingException e) {
            System.out.println("[DashboardDAO] Message : " + e.getMessage());
            System.out.println("[DashboardDAO] Class   : " + e.getClass().getSimpleName());
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

	public List<DashboardDTO> getNotice() {
		String sql = "SELECT notice_title FROM notice WHERE notice_check = 1 ORDER BY notice_reg desc";
		ArrayList<DashboardDTO> list = new ArrayList<>();
		try {
			connection = dataSource.getConnection();			
			statement = connection.prepareStatement(sql);
			resultSet = statement.executeQuery();
			
			while(resultSet.next()){
				DashboardDTO board = new DashboardDTO();
				board.setNotice_title(resultSet.getString("notice_title"));
				
				list.add(board);
			}
		} catch (SQLException e) {
            System.out.println("[getNotice] Message : " + e.getMessage());
            System.out.println("[getNotice] Class   : " + e.getClass().getSimpleName());
        } finally {
			freeConnection();
		}
		return list;
	}    
    
	public List<DashboardDTO> getProduct() {
		String sql = "SELECT product_name, product_ea FROM product WHERE product_ea < 4 ORDER BY product_ea";
		ArrayList<DashboardDTO> list = new ArrayList<>();
		try {
			connection = dataSource.getConnection();			
			statement = connection.prepareStatement(sql);
			resultSet = statement.executeQuery();
			
			while(resultSet.next()){
				DashboardDTO board = new DashboardDTO();
				board.setProduct_name(resultSet.getString("product_name"));
				board.setProduct_ea(resultSet.getInt("product_ea"));
				
				list.add(board);
			}
		} catch (SQLException e) {
            System.out.println("[getProduct] Message : " + e.getMessage());
            System.out.println("[getProduct] Class   : " + e.getClass().getSimpleName());
        } finally {
			freeConnection();
		}
		return list;
	}
    
	public List<DashboardDTO> getReservation() {
		String sql = "SELECT a.reservation_time, b.service_name FROM reservation a INNER JOIN service b ON a.service_code = b.service_code WHERE reservation_date=CURDATE() ORDER BY reservation_time";
		ArrayList<DashboardDTO> list = new ArrayList<>();
		try {
			connection = dataSource.getConnection();			
			statement = connection.prepareStatement(sql);
			resultSet = statement.executeQuery();
			
			while(resultSet.next()){
				DashboardDTO board = new DashboardDTO();
				board.setReservation_time(resultSet.getString("reservation_time"));
				board.setService_name(resultSet.getString("service_name"));
				
				list.add(board);
			}
		} catch (SQLException e) {
            System.out.println("[getReservation] Message : " + e.getMessage());
            System.out.println("[getReservation] Class   : " + e.getClass().getSimpleName());
        } finally {
			freeConnection();
		}
		return list;
	}

        /* 
     		===== 서비스 매출 현황 통계 =====
            1. 예약 테이블에서 기준일(now) 까지의 1개월간 서비스별 시술 횟수 조회
            2. 복수 선택의 경우 개별 횟수에 추가
                1> 이름을 "," 으로 split   "반환 타입 : String[]"
                2> 배열에 해당하는 데이터(서비스명)가 있는 경우 카운트 증가
            3. DashboardDTO 객체 활용
                1> 단일 서비스의 DTO를 생성 _ 상품코드의 두 번째 자리가 0
    */
    // 인스턴스 변수 메서드화 : 리팩토링 예정 
    String services;
    String revenues;
    // 이전 매출 현황 조회 시 indexMonth 값 입력 (ex. 이번 달의 경우 0, 한 달 전의 경우 1)
    public JSONArray setService (int indexMonth) {
        // 서비스별 월매출액 저장용
        List<DashboardDTO> list = new LinkedList<>();        
        JSONArray jsonArray = null;
		try{
			connection = dataSource.getConnection();
            // 단일 서비스 조회
            String sql = "SELECT service_code, service_name, service_price FROM service " +
                    "WHERE service_code LIKE 'S0%'";  
			statement = connection.prepareStatement(sql);			
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
            	DashboardDTO service = new DashboardDTO();
                service.setService_code(resultSet.getString("service_code"));
                service.setService_name(resultSet.getString("service_name"));   // 통계 자료에 출력하기 위한 service_name
                service.setService_price(resultSet.getInt("service_price"));    // 서비스별 이용 요금
                service.setService_cnt(0); // 서비스 이용 횟수 초기화
                list.add(service);  // 매출액(value) 0으로 초기화
            }

            // 월별 서비스 매출액 조회
			sql ="SELECT service_name, reservation_date FROM service INNER JOIN reservation " + 
                    "ON reservation_date >= DATE_SUB(now(), INTERVAL " + indexMonth + " +1 MONTH) " +
                    "AND reservation_date <= DATE_SUB(now(), INTERVAL " + indexMonth + " MONTH)";

			statement = connection.prepareStatement(sql);			
            resultSet = statement.executeQuery();
            while(resultSet.next()) {
            	// 복수 선택 서비스 분리 : 서비스명으로 조회 후 카운트 증가
                String[] service_nameArr = resultSet.getString("service_name").split(",");
                for (String service_name : service_nameArr) {
                    for (DashboardDTO dto : list) {
                        if (dto.getService_name().equals(service_name)) {
                            dto.setService_cnt(dto.getService_cnt()+1);
                        }
                    }
                }
            }
            
            /* JSON 라이브러리 객체 활용 */
            jsonArray = new JSONArray(list);
            jsonArray.put(list);
            
            // // 배열에 저장
            // String[] servicesArr = new String[list.size()];
            // String[] revenuesArr = new String[list.size()];

            // for (int i = 0; i < list.size(); i++) {
            //     servicesArr[i] = list.get(i).getService_name();
            //     revenuesArr[i] = String.valueOf(list.get(i).getChart_revenue()/10000);
            // }
            
            // services = "[\"" + String.join("\", \"",  servicesArr) + "\"]";
            // revenues = "[" + String.join(", ",  revenuesArr) + "]";
            // System.out.println(services);
            // System.out.println(revenues);
		} catch (SQLException e) {
            System.out.println("[setService] Message : " + e.getMessage());
            System.out.println("[setService] Class   : " + e.getClass().getSimpleName());
        } finally{
			freeConnection();
		}
        return jsonArray;
    }
    // 배열로 return :  JS에 전달용
    public String getServices() {
        return services;
    }
    public String getRevenues() {
        return revenues;
    }
    
    // == 달력에서 선택된 날짜에 대한 예약현황 데이터 가져오기 로직 시작 ==
    private String selectedDateStr = null;
    
    /**
     * 달력에서 사용자가 선택한 날짜 정보 설정. 
     * @param selectedDateStr - yyyy-mm-dd 형태.
     */
    public void setSelectedDate(String selectedDateStr) {
    	this.selectedDateStr = selectedDateStr;
    }
    
    /**
     * setSelectedDate() 메서드를 통해 설정된 날짜 데이터를 조건으로 하는 
     * 예약 날짜 및 예약 서비스명 데이터 모두 추출.
     * @return
     */
    public List<DashboardDTO> getReservationByDate() {
		if (this.selectedDateStr == null) return null;
		Date selectedDate = Date.valueOf(this.selectedDateStr);
    	
		String sql = """
				SELECT a.reservation_time, b.service_name 
					FROM reservation a 
					INNER JOIN service b 
						ON a.service_code = b.service_code 
						WHERE reservation_date=? ORDER BY reservation_time
				""".trim();
		ArrayList<DashboardDTO> list = new ArrayList<>();
		try {
			connection = dataSource.getConnection();			
			statement = connection.prepareStatement(sql);
			statement.setDate(1, selectedDate);
			resultSet = statement.executeQuery();
			
			while(resultSet.next()){
				DashboardDTO board = new DashboardDTO();
				
				board.setReservation_time(resultSet.getString("reservation_time"));
				board.setService_name(resultSet.getString("service_name"));
				
				list.add(board);
			}
		} catch (SQLException e) {
            System.out.println("[getReservationByDate] Message : " + e.getMessage());
            System.out.println("[getReservationByDate] Class   : " + e.getClass().getSimpleName());
        } finally {
			freeConnection();
		}
		return list;
	}
    // == 달력에서 선택된 날짜에 대한 예약현황 데이터 가져오기 로직 끝 ===
}
