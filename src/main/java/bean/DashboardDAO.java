package bean;

import java.sql.Connection;
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

import org.json.simple.JSONArray;

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

	public List<DashboardDTO> getProduct() {
		String sql = "SELECT pd_name, pd_ea FROM pd WHERE pd_ea < 4 ORDER BY pd_ea";
		ArrayList<DashboardDTO> list = new ArrayList<>();
		try {
			connection = dataSource.getConnection();			
			statement = connection.prepareStatement(sql);
			resultSet = statement.executeQuery();
			
			while(resultSet.next()){
				DashboardDTO board = new DashboardDTO();
				board.setPd_name(resultSet.getString("pd_name"));
				board.setPd_ea(resultSet.getInt("pd_ea"));
				
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
		String sql = "SELECT a.res_time, b.ser_name FROM res a INNER JOIN ser b ON a.ser_code = b.ser_code WHERE res_date=CURDATE() ORDER BY res_time";
		ArrayList<DashboardDTO> list = new ArrayList<>();
		try {
			connection = dataSource.getConnection();			
			statement = connection.prepareStatement(sql);
			resultSet = statement.executeQuery();
			
			while(resultSet.next()){
				DashboardDTO board = new DashboardDTO();
				board.setRes_time(resultSet.getString("res_time"));
				board.setSer_name(resultSet.getString("ser_name"));
				
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
    public void setService (int indexMonth) {
        // 서비스별 월매출액 저장용
        List<DashboardDTO> list = new LinkedList<>();
        DashboardDTO service;
		try{
			connection = dataSource.getConnection();
            // 단일 서비스 조회
            String sql = "SELECT ser_code, ser_name, ser_price FROM ser " +
                    "WHERE ser_code LIKE 'S0__'";  
			statement = connection.prepareStatement(sql);			
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                service = new DashboardDTO();
                service.setSer_code(resultSet.getString("ser_code"));
                service.setSer_name(resultSet.getString("ser_name"));   // 통계 자료에 출력하기 위한 ser_name
                service.setSer_price(resultSet.getInt("ser_price"));    // 서비스별 이용 요금
                service.setSer_cnt(0); // 서비스 이용 횟수 초기화
                list.add(service);  // 매출액(value) 0으로 초기화
            }

            // 월별 서비스 매출액 조회
			sql ="SELECT ser_name, res.res_date FROM ser INNER JOIN res " + 
                    "ON res_date >= DATE_SUB(now(), INTERVAL " + indexMonth + " +1 MONTH) " +
                    "AND res_date <= DATE_SUB(now(), INTERVAL " + indexMonth + " MONTH)";

			statement = connection.prepareStatement(sql);			
            resultSet = statement.executeQuery();
            while(resultSet.next()) {
            	// 복수 선택 서비스 분리 : 서비스명으로 조회 후 카운트 증가
                String[] ser_nameArr = resultSet.getString("ser_name").split(",");
                for (String ser_name : ser_nameArr) {
                    for (DashboardDTO dto : list) {
                        if (dto.getSer_name().equals(ser_name)) {
                            dto.setSer_cnt(dto.getSer_cnt()+1);
                        }
                    }
                    // if (i>0 && i == list.size()-1) {
                    //     for (DashboardDTO dto : list) {
                    //         if (dto.getSer_name().equals("커트")) {
                    //             dto.setSer_cnt(dto.getSer_cnt()+1);
                    //         }
                    //     }
                    // }
                }
            }
            
            // 배열에 저장
            String[] servicesArr = new String[list.size()];
            String[] revenuesArr = new String[list.size()];

            for (int i = 0; i < list.size(); i++) {
                servicesArr[i] = list.get(i).getSer_name();
                revenuesArr[i] = String.valueOf(list.get(i).getChart_revenue()/10000);
            }
            
            services = "[\"" + String.join("\", \"",  servicesArr) + "\"]";
            revenues = "[" + String.join(", ",  revenuesArr) + "]";
            System.out.println(services);
            System.out.println(revenues);
		} catch (SQLException e) {
            System.out.println("[getServiceMap] Message : " + e.getMessage());
            System.out.println("[getServiceMap] Class   : " + e.getClass().getSimpleName());
        } finally{
			freeConnection();
		}
    }
    // 배열로 return :  JS에 전달용
    public String getServices() {
        return services;
    }
    public String getRevenues() {
        return revenues;
    }
}
