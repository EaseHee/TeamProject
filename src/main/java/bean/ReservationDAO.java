package bean;


import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ReservationDAO {
    private Context context = null;
    private DataSource dataSource = null;

    private Connection connection = null;
    private PreparedStatement statement = null;
    private ResultSet resultSet = null;

    public ReservationDAO () {
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
    
    //reservation.jsp
    public List<ReservationDTO> getReservationDTOList(String keyField, String keyWord, String startDate, String endDate) {
        String sql = "SELECT reservation_no, service_name, reservation_date, reservation_time, customer_name, member_name, reservation_comm "
            + "FROM reservation res "
            + "INNER JOIN customer cus ON cus.customer_id = res.customer_id "
            + "INNER JOIN service ser ON ser.service_code = res.service_code "
            + "INNER JOIN member mem ON mem.member_id = res.member_id";
        
        // 조건별로 SQL 쿼리 추가
        boolean whereAdded = false;
        
        // 기간 조회 조건
        if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
            sql += " WHERE reservation_date BETWEEN ? AND ?";
            whereAdded = true;
        }
        
        // 검색 조회 조건
        if (keyField != null && keyWord != null && !keyWord.isEmpty()) {
            if (whereAdded) {
                sql += " AND " + keyField + " LIKE ?";
            } else {
                sql += " WHERE " + keyField + " LIKE ?";
            }
            whereAdded = true;
        }
        
        // 전체 조회를 위한 조건 검색
        if (!whereAdded) {
            sql += " WHERE 1=1"; // 모든 레코드를 조회
        }
        
        // 정렬
        sql += " ORDER BY reservation_date DESC";

        ArrayList<ReservationDTO> list = new ArrayList<>();

        try {
            // 데이터베이스 연결
            context = new InitialContext();
            dataSource = (DataSource) context.lookup("java:comp/env/jdbc/acorn");
            connection = dataSource.getConnection();

            // PreparedStatement 준비
            statement = connection.prepareStatement(sql);
            
            // 파라미터 바인딩
            int paramIndex = 1;
            
            // 기간 조건 파라미터 설정
            if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                java.sql.Date sqlStartDate = new java.sql.Date(format.parse(startDate).getTime());
                java.sql.Date sqlEndDate = new java.sql.Date(format.parse(endDate).getTime());
                statement.setDate(paramIndex++, sqlStartDate);
                statement.setDate(paramIndex++, sqlEndDate);
            }
            
            // 검색 조건 파라미터 설정
            if (keyField != null && keyWord != null && !keyWord.isEmpty()) {
                statement.setString(paramIndex++, "%" + keyWord + "%");
            }

            // 쿼리 실행
            resultSet = statement.executeQuery();

            // 결과 처리
            while (resultSet.next()) {
                ReservationDTO reservationDTO = new ReservationDTO();
                reservationDTO.setReservation_no(resultSet.getInt("reservation_no"));
                reservationDTO.setService_name(resultSet.getString("service_name"));
                reservationDTO.setReservation_date(resultSet.getString("reservation_date"));
                reservationDTO.setReservation_time(resultSet.getString("reservation_time"));
                reservationDTO.setCustomer_name(resultSet.getString("customer_name"));
                reservationDTO.setMember_name(resultSet.getString("member_name"));
                reservationDTO.setReservation_comm(resultSet.getString("reservation_comm"));

                list.add(reservationDTO);
            }

        } catch (Exception e) {
            System.out.println("[getReservationDTOList] Message : " + e.getMessage());
            System.out.println("[getReservationDTOList] Class   : " + e.getClass().getSimpleName());
        } finally {
        	System.out.println("startDate : " + startDate + ", " +"endDate : " + endDate );
     
            freeConnection();
        }

        return list;
    }



    
    //reservationPostProc.jsp 
    public void setReservationDTO(ReservationDTO reservationDTO) throws SQLException, ClassNotFoundException {
        String sql = null;

        try { 
        	context = new InitialContext();
    		dataSource = (DataSource)context.lookup("java:comp/env/jdbc/acorn");
    		connection = dataSource.getConnection();
    		
    		// 각 name에 맞는 customer_id, service_code, member_id 조회하는 쿼리
    		sql = "SELECT c.customer_id, s.service_code, m.member_id FROM customer c, service s, member m"
    				+ " WHERE c.customer_name = ? AND s.service_name = ? AND m.member_name = ?";
    		statement = connection.prepareStatement(sql);
    		statement.setString(1, reservationDTO.getCustomer_name());
    		statement.setString(2, reservationDTO.getService_name());
    		statement.setString(3, reservationDTO.getMember_name());

    		resultSet = statement.executeQuery();

    		if(resultSet.next()) {
    		    int customer_id = resultSet.getInt("customer_id");
    		    String service_code = resultSet.getString("service_code");
    		    String member_id = resultSet.getString("member_id");

    		    // res 테이블에 삽입하는 쿼리
    		    sql = "INSERT INTO reservation (customer_id, service_code, reservation_date, reservation_time, member_id, reservation_comm) VALUES (?, ?, ?, ?, ?, ?)";
    		    statement = connection.prepareStatement(sql);
    		    statement.setInt(1, customer_id);
    		    statement.setString(2, service_code);
    		    statement.setString(3, reservationDTO.getReservation_date());
    		    statement.setString(4, reservationDTO.getReservation_time());
    		    statement.setString(5, member_id);
    		    statement.setString(6, reservationDTO.getReservation_comm());
    		    statement.executeUpdate();
    		    
    		    //service_cnt 증가
    		    sql = "UPDATE service SET service_cnt = service_cnt + 1 WHERE service_code = ?";
    		    statement = connection.prepareStatement(sql);
    		    statement.setString(1, service_code);
    		    statement.executeUpdate();

    		    //member_cnt 증가
    		    sql = "UPDATE member SET member_cnt = member_cnt + 1 WHERE member_id = ?";
    		    statement = connection.prepareStatement(sql);
    		    statement.setString(1, member_id);
    		    statement.executeUpdate();
    		    
    		    //customer_total 증가
    		    sql = "UPDATE customer c "
    		    	     + "JOIN service s ON c.customer_id = ? AND s.service_code = ? "
    		    	     + "SET c.customer_total = c.customer_total + s.service_price";
    		    	statement = connection.prepareStatement(sql);
    		    	statement.setInt(1, customer_id); 
    		    	statement.setString(2, service_code);  
    		    	statement.executeUpdate();
    		}

        } 
        catch(Exception e) {
    		System.out.println("[setReservationDTO] Message : " + e.getMessage());
            System.out.println("[setReservationDTO] Class   : " + e.getClass().getSimpleName());
    	}
        finally {
            freeConnection();
        }
    }
    
    //reservationPost.jsp 
    //예약 고객명 조회
    public List<String> getAllCustomerNames() throws SQLException{
		List<String> customerNames = new ArrayList<>();
		String query = "SELECT customer_name FROM customer"; //'customer' 테이블에서 회원명 가져옴
    	
		try {
			connection = dataSource.getConnection();
			statement = connection.prepareStatement(query);
			
			resultSet = statement.executeQuery();
			
			while(resultSet.next()) {
				customerNames.add(resultSet.getString("customer_name"));
			}
		} 
		catch (SQLException e) {
            System.out.println("[getAllCustomerNames] Message : " + e.getMessage());
            System.out.println("[getAllCustomerNames] Class   : " + e.getClass().getSimpleName());
        }
		finally {
			freeConnection();
		}
		return customerNames;
    }
    
    //예약 서비스명 조회
    public List<String> getAllServiceNames() throws SQLException {
	    List<String> serviceNames = new ArrayList<>();
	    String query = "SELECT service_name FROM service"; // 'service' 테이블에서 서비스 명 가져옴

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
	        freeConnection(); 
	    }
	    return serviceNames;
	}
    
    //예약 직원명 조회
    public List<String> getAllMemberNames() throws SQLException {
	    List<String> memberNames = new ArrayList<>();
	    String query = "SELECT member_name FROM member"; // 'member' 테이블에서 서비스 명 가져옴

	    try {
	        connection = dataSource.getConnection();
	        statement = connection.prepareStatement(query);
	        resultSet = statement.executeQuery();

	        while (resultSet.next()) {
	            memberNames.add(resultSet.getString("member_name"));
	        }
	    } 
	    catch (SQLException e) {
            System.out.println("[getAllServiceNames] Message : " + e.getMessage());
            System.out.println("[getAllServiceNames] Class   : " + e.getClass().getSimpleName());
        }
	    finally {
	        freeConnection();
	    }
	    return memberNames;
	}
    
    //reservationRead.jsp , reservationUpdate.jsp
    public ReservationDTO getReservationDTO(int reservation_no) {
    	String sql = null;
    	ReservationDTO dto = new ReservationDTO();
    	
    	try {
    		context = new InitialContext();
            dataSource = (DataSource) context.lookup("java:comp/env/jdbc/acorn");
            connection = dataSource.getConnection();
            
            sql = "SELECT * FROM reservation res "
            		+ "INNER JOIN customer cus ON cus.customer_id = res.customer_id "
            		+ "INNER JOIN service ser ON ser.service_code = res.service_code "
            		+ "INNER JOIN member mem ON mem.member_id = res.member_id "
            		+ "WHERE reservation_no=?";
            statement = connection.prepareStatement(sql);
            
            statement.setInt(1, reservation_no);
            resultSet = statement.executeQuery();
            
            if(resultSet.next()) {
            	dto.setReservation_no(resultSet.getInt("reservation_no"));
            	dto.setCustomer_id(resultSet.getInt("customer_id"));
            	dto.setCustomer_name(resultSet.getString("customer_name"));
            	dto.setReservation_comm(resultSet.getString("reservation_comm"));
            	dto.setReservation_date(resultSet.getString("reservation_date"));     	
            	dto.setReservation_time(resultSet.getString("reservation_time"));
            	dto.setService_code(resultSet.getString("service_code"));
            	dto.setService_name(resultSet.getString("service_name"));
            	dto.setMember_id(resultSet.getString("member_id"));
            	dto.setMember_name(resultSet.getString("member_name"));
            }
    	}
    	catch(Exception e) {
    		System.out.println("[getReservationDTO] Message : " + e.getMessage());
            System.out.println("[getReservationDTO] Class   : " + e.getClass().getSimpleName());
    	}
    	finally {
    		freeConnection();
    	}
    	return dto;
    }
    
    
    //reservationUpdateProc.jsp 
    public void updateReservationDTO(ReservationDTO resDto) {
        String sql = null;

        try {
            context = new InitialContext();
            dataSource = (DataSource)context.lookup("java:comp/env/jdbc/acorn");
            connection = dataSource.getConnection();
            
            // res 테이블에서 기존 service_code, member_id, customer_id 조회
            sql = "SELECT service_code, member_id, customer_id FROM reservation WHERE reservation_no = ?";
            statement = connection.prepareStatement(sql);
            statement.setInt(1, resDto.getReservation_no()); 
            resultSet = statement.executeQuery();
            
            //수정하려고 하는 (기존의) service_code,member_id,customer_id를 별도로 저장
            String old_ser_code = null;
            String old_mem_id = null;
            int old_cus_id = 0;
            if (resultSet.next()) {
                old_ser_code = resultSet.getString("service_code");
                old_mem_id = resultSet.getString("member_id");
                old_cus_id = resultSet.getInt("customer_id");
            }
            
            // customer_id, service_code, member_id를 조회하는 쿼리
            sql = "SELECT c.customer_id, s.service_code, m.member_id FROM customer c, service s, member m"
            		+ " WHERE c.customer_name = ? AND s.service_name = ? AND m.member_name = ?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, resDto.getCustomer_name());
            statement.setString(2, resDto.getService_name());
            statement.setString(3, resDto.getMember_name());
            resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
            	//수정하려고하는 (새로운) customer_id, service_code, member_id를 별도로 저장
                int new_cus_id = resultSet.getInt("customer_id");
                String new_ser_code = resultSet.getString("service_code");
                String new_mem_id = resultSet.getString("member_id");

                // service_code가 변경된 경우에만 service_cnt 수정
                if (!old_ser_code.equals(new_ser_code)) {
                    // 기존 service_code의 service_cnt 감소
                    sql = "UPDATE service SET service_cnt = service_cnt - 1 WHERE service_code = ?";
                    statement = connection.prepareStatement(sql);
                    statement.setString(1, old_ser_code);
                    statement.executeUpdate();

                    // 새로운 service_code의 service_cnt 증가
                    sql = "UPDATE service SET service_cnt = service_cnt + 1 WHERE service_code = ?";
                    statement = connection.prepareStatement(sql);
                    statement.setString(1, new_ser_code);
                    statement.executeUpdate();
                }
                
                
                // member_id가 변경된 경우에만 member_cnt 수정
                if (!old_mem_id.equals(new_mem_id)) {
                    // 기존 member_id의 member_cnt 감소
                    sql = "UPDATE member SET member_cnt = member_cnt - 1 WHERE member_id = ?";
                    statement = connection.prepareStatement(sql);
                    statement.setString(1, old_mem_id);
                    statement.executeUpdate();

                    // 새로운 member_code의 member_cnt 증가
                    sql = "UPDATE member SET member_cnt = member_cnt + 1 WHERE member_id = ?";
                    statement = connection.prepareStatement(sql);
                    statement.setString(1, new_mem_id);
                    statement.executeUpdate();
                }
                
                
                // customer_id가 변경된 경우에만 customer_total 수정
                if (old_cus_id != new_cus_id) {
                    // 기존customer_id의 customer_total 감소
                	sql = "UPDATE customer c "
       		    	     + "JOIN service s ON c.customer_id = ? AND s.service_code = ? "
       		    	     + "SET c.customer_total = c.customer_total - s.service_price";
                    statement = connection.prepareStatement(sql);
                    statement.setInt(1, old_cus_id);
                    statement.setString(2, old_ser_code);
                    statement.executeUpdate();

                    // 새로운 customer_id의 customer_total 증가
                    sql = "UPDATE customer c "
       		    	     + "JOIN service s ON c.customer_id = ? AND s.service_code = ? "
       		    	     + "SET c.customer_total = c.customer_total + s.service_price";
                    statement = connection.prepareStatement(sql);
                    statement.setInt(1, new_cus_id);
                    statement.setString(2, new_ser_code);
                    statement.executeUpdate();
                } 
                else if (old_cus_id == new_cus_id) {
                	//customer_id에 customer_total 감소
                	sql = "UPDATE customer c "
          		    	     + "JOIN service s ON c.customer_id = ? AND s.service_code = ? "
          		    	     + "SET c.customer_total = c.customer_total - s.service_price";
                       statement = connection.prepareStatement(sql);
                       statement.setInt(1, old_cus_id);
                       statement.setString(2, old_ser_code);
                       statement.executeUpdate();
                       
                    // 새로운 customer_id의 customer_total 증가
                       sql = "UPDATE customer c "
          		    	     + "JOIN service s ON c.customer_id = ? AND s.service_code = ? "
          		    	     + "SET c.customer_total = c.customer_total + s.service_price";
                       statement = connection.prepareStatement(sql);
                       statement.setInt(1, new_cus_id);
                       statement.setString(2, new_ser_code);
                       statement.executeUpdate();
                }
                
                
                
                

                // res 테이블 수정
                sql = "UPDATE reservation SET customer_id = ?, service_code = ?, reservation_date = ?, reservation_time = ?, member_id = ?, reservation_comm = ? WHERE reservation_no = ?";
                statement = connection.prepareStatement(sql);
                statement.setInt(1, new_cus_id);
                statement.setString(2, new_ser_code);
                statement.setString(3, resDto.getReservation_date());
                statement.setString(4, resDto.getReservation_time());
                statement.setString(5, new_mem_id);
                statement.setString(6, resDto.getReservation_comm());
                statement.setInt(7, resDto.getReservation_no());
                statement.executeUpdate();
            }
        } catch(Exception e) {
    		System.out.println("[updateReservationDTO] Message : " + e.getMessage());
            System.out.println("[updateReservationDTO] Class   : " + e.getClass().getSimpleName());
    	} finally {
            freeConnection();
        }
    }

    
    //reservationDelete.jsp
	public void deleteReservationDTO(int reservation_no) throws SQLException {

		String sql;

		try {
			context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/acorn");
			connection = dataSource.getConnection();

			// res 테이블에서 service_code, member_id 조회
			sql = "SELECT service_code, member_id, customer_id FROM reservation WHERE reservation_no=?";
			statement = connection.prepareStatement(sql);
			statement.setInt(1, reservation_no);
			resultSet = statement.executeQuery();

			// resultSet을 통해 ser_code를 가져옴
			String service_code = null;
			String member_id = null;
			int customer_id = 0;
			if (resultSet.next()) {
				service_code = resultSet.getString("service_code");
				member_id = resultSet.getString("member_id");
				customer_id = resultSet.getInt("customer_id");
			}

			// 예약 삭제하는 쿼리
			sql = "DELETE FROM reservation WHERE reservation_no=?";
			statement = connection.prepareStatement(sql);
			statement.setInt(1, reservation_no);
			statement.executeUpdate();

			// service_cnt 감소하는 쿼리
			sql = "UPDATE service SET service_cnt = service_cnt - 1 WHERE service_code = ?";
			statement = connection.prepareStatement(sql);
			statement.setString(1, service_code);
			statement.executeUpdate();
			
			// member_cnt 감소하는 쿼리
			sql = "UPDATE member SET member_cnt = member_cnt - 1 WHERE member_id = ?";
			statement = connection.prepareStatement(sql);
			statement.setString(1, member_id);
			statement.executeUpdate();
			
			//customer_total 감소하는 쿼리
		    sql = "UPDATE customer c "
		    	     + "JOIN service s ON c.customer_id = ? AND s.service_code = ? "
		    	     + "SET c.customer_total = c.customer_total - s.service_price";
		    	statement = connection.prepareStatement(sql);
		    	statement.setInt(1, customer_id);  // customer_id가 첫 번째로 들어가야 함
		    	statement.setString(2, service_code);  // service_code가 두 번째로 들어가야 함
		    	statement.executeUpdate();

		} catch(Exception e) {
    		System.out.println("[deleteReservationDTO] Message : " + e.getMessage());
            System.out.println("[deleteReservationDTO] Class   : " + e.getClass().getSimpleName());
    	} finally {
			freeConnection();
		}
	  }
}