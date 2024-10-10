package bean;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

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
		String sql = "SELECT notice_no, notice_title FROM notice WHERE notice_check = 1 ORDER BY notice_reg desc";
		ArrayList<DashboardDTO> list = new ArrayList<>();
		try {
			connection = dataSource.getConnection();			
			statement = connection.prepareStatement(sql);
			resultSet = statement.executeQuery();
			
			while(resultSet.next()){
				DashboardDTO board = new DashboardDTO();
				board.setNotice_title(resultSet.getString("notice_title"));
				board.setNotice_no(resultSet.getInt("notice_no"));
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
    
    /* ======================== 서비스 매출 현황 통계 로직 시작 ======================= */
    /**
     *  1. 예약 테이블에서 기준일(now) 을 기준으로 1개월 간격으로 서비스별 시술 횟수 조회
     *  2. 복수 선택의 경우 단일 서비스로 분할하여 적용
     *      1> 이름을 "," 으로 split   "반환 타입 : String[]"
     *      2> 배열에 해당하는 데이터(서비스)의 수익 금액 배열리스트에 저장
     *  3. JSON 라이브러리 활용 <ChartServiceCommand.java 에서 처리>
     *      JSONArray.put() / .get()
     * @param isMulti 복합 서비스 여부  (단일 : false | 복합 : true) _ ChartServiceCommand에서 인자 전달
     * @return 
     */  
    // 서비스(DTO) 리스트 반환 (매개변수 : 복합 서비스 여부 | 없을 시 단일 서비스)
    public List<DashboardDTO> getServiceList(boolean isMulti) {
        List<DashboardDTO> serviceList = new ArrayList<>();
        try {
            // 단일 서비스 조회
            String sql = """
                SELECT service_code, service_name, service_price 
                    FROM service WHERE service_code LIKE ?
                """; // LIKE 연산자의 입력값은 ?로 부분 처리할 수 없다.
            connection = dataSource.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, "S" + (isMulti ? 1 : 0) + "%");   // 복합 서비스 여부 (단일 : 0 | 복합 : 1)
            resultSet = statement.executeQuery();
            while(resultSet.next()) {
                DashboardDTO service = new DashboardDTO();
                service.setService_code(resultSet.getString("service_code"));
                service.setService_name(resultSet.getString("service_name"));
                service.setService_price(resultSet.getInt("service_price"));
                serviceList.add(service);
            }
        } catch (SQLException e) {
            System.out.println("[getServiceList] \n\tMessage : " + e.getMessage() + "\n\tClass   : " + e.getClass().getSimpleName());
        } finally {
            freeConnection();
        }
        return serviceList;
    }
    // 오버로딩 (인자를 전달받지 못할 경우 단일 서비스 조회)
    public List<DashboardDTO> getServiceList() {return getServiceList(false);};

    /** 
     * @param board 서비스 객체 (getServiceList()에서 List에 저장된 DTO)
     * @return
     */
    // 서비스별 연간 수익액 반환 (1~12월 저장)
    public List<Integer> getMonthRevenueList(DashboardDTO board) {
        // DTO(서비스)별 월 수익 저장
        List<Integer> revenueList = new ArrayList<>();
        // 저장되지 않는 월이 없도록 0으로 초기화 (null 방지) _ 이후 값 변경은 add()가 아니라 set() 
        for (int i = 0; i < 12; i++) revenueList.add(0);

        try {
            String sql = """
                SELECT 
                    service_name , 
                    MONTH(reservation_date) month, 
                    COUNT(MONTH(reservation_date)) service_count 
                FROM service s 
                INNER JOIN reservation r ON s.service_code = r.service_code 
                WHERE YEAR(reservation_date) = YEAR(now())
                GROUP BY service_name, month 
                ORDER BY s.service_code ASC, reservation_date ASC
                """;
            connection = dataSource.getConnection();
			statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            /**
             * DB 조회 데이터 순회 : 서비스 별 수익 여부 저장 
             * 1> 서비스명 동일 여부  
             * 2> 월 조회  
             * 
             * 3> 수익 산출
             */
            while(resultSet.next()) {
                // 복수 선택 서비스 분리 : 서비스명으로 조회 후 카운트 증가
                String[] service_nameArr = resultSet.getString("service_name").split(",");  // split() _ "return : String[]"
                for (String service_name : service_nameArr) { // 반복 횟수 1~2회 (= 단일 서비스, 복합 서비스 차등)
                    /***** 1> DTO 객체의 서비스명과 동일 여부 확인  *****/
                    if (board.getService_name().equals(service_name)) {
                    /***** 2> 예약 월 조회 : ArrayList의 인덱스로 활용  *****/
                        int indexMonth = resultSet.getInt("month") - 1;   // MONTH()_ return : 1~12
                    /***** 3> 당월 서비스 수익 산출 (서비스 횟수 * 서비스 금액) *****/
                        revenueList.set(indexMonth, resultSet.getInt("service_count") * board.getService_price());
                    }   // .set() : 값 변경  "add()는 추가 : 배열의 크기가 증가됨"
                }
            }
        } catch (SQLException e) {
            System.out.println("[getMonthRevenueList] \n\tMessage : " + e.getMessage() + "\n\tClass   : " + e.getClass().getSimpleName());
        } finally {
            freeConnection();
        }
        return revenueList;
    }
    /* ======================== 서비스 매출 현황 통계 로직 종료 ======================= */

    

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
    public List<DashboardReservationDTO> getReservationByDate() {
		if (this.selectedDateStr == null) return null;
		Date selectedDate = Date.valueOf(this.selectedDateStr);
    	
		/*
		String sql = """
				SELECT a.reservation_time, b.service_name 
					FROM reservation a 
					INNER JOIN service b 
						ON a.service_code = b.service_code 
						WHERE reservation_date=? ORDER BY reservation_time
				""".trim(); */
		String sql = """
				SELECT 
					cus.customer_name, 
					res.reservation_time, 
					ser.service_name, 
					mem.member_name 
				FROM reservation res 
				INNER JOIN service ser 
					ON res.service_code = ser.service_code 
				INNER JOIN customer cus 
					ON cus.customer_id = res.customer_id 
				INNER JOIN member mem 
					ON mem.member_id = res.member_id 
				WHERE res.reservation_date=? 
				ORDER BY res.reservation_time 
				""".trim();
		ArrayList<DashboardReservationDTO> list = new ArrayList<>();
		try {
			connection = dataSource.getConnection();			
			statement = connection.prepareStatement(sql);
			statement.setDate(1, selectedDate);
			resultSet = statement.executeQuery();
			
			while(resultSet.next()){
				DashboardReservationDTO board = new DashboardReservationDTO();
				
				board.setReservation_time(resultSet.getString("reservation_time"));
				board.setService_name(resultSet.getString("service_name"));
				board.setCustomer_name(resultSet.getString("customer_name"));
				board.setMember_name(resultSet.getString("member_name"));
				
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
