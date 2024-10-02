package bean;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ReservationDAO_yye {
    private Context context = null;
    private DataSource dataSource = null;

    private Connection connection = null;
    private PreparedStatement statement = null;
    private ResultSet resultSet = null;

    public ReservationDAO_yye () {
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
    /*
    public List<ReservationDTO> getReservationDTOList(String keyField, String keyWord){
    	String sql = null;
    	
    	if(keyWord == null || keyWord.isEmpty()) {
    		sql = "SELECT reservation_no, service_name, reservation_date, reservation_time, customer_name, reservation_comm FROM reservation res "
            		+ "INNER JOIN customer cus ON cus.customer_id = res.customer_id "
            		+ "INNER JOIN service ser ON ser.service_code = res.service_code "
    				+ "ORDER BY reservation_date DESC";
    	}
    	else {
    		sql = "SELECT reservation_no, service_name, reservation_date, reservation_time, customer_name, reservation_comm FROM reservation res "
            		+ "INNER JOIN customer cus ON cus.customer_id = res.customer_id "
            		+ "INNER JOIN service ser ON ser.service_code = res.service_code "
    				+ "WHERE " + keyField + " like '%" + keyWord + "%'";
    	}
    	
    	ArrayList<ReservationDTO> list = new ArrayList<>();
    	
    	try {
    		context = new InitialContext();
    		dataSource = (DataSource)context.lookup("java:comp/env/jdbc/acorn");
    		connection = dataSource.getConnection();
    		

    		statement = connection.prepareStatement(sql);
    		resultSet = statement.executeQuery();
    		
    		while(resultSet.next()) {
    			ReservationDTO reservationDTO = new ReservationDTO();
    			reservationDTO.setReservation_no(resultSet.getInt("reservation_no"));
    			reservationDTO.setService_name(resultSet.getString("service_name"));
    			reservationDTO.setReservation_date(resultSet.getString("reservation_date"));
    			reservationDTO.setReservation_time(resultSet.getString("reservation_time"));
    			reservationDTO.setCustomer_name(resultSet.getString("customer_name"));
    			reservationDTO.setReservation_comm(resultSet.getString("reservation_comm"));
    			
    			list.add(reservationDTO);
    		}
    		
    	}
    	catch(Exception e) {
    		System.out.println("[getReservationDTOList] Message : " + e.getMessage());
            System.out.println("[getReservationDTOList] Class   : " + e.getClass().getSimpleName());
    	}
    	finally {
    		freeConnection();
    	}
		return list;
    }
	*/
    /*
    public List<ReservationDTO> getReservationDTOList(String keyField, String keyWord, String startDate, String endDate){
    	String sql = "SELECT reservation_no, service_name, reservation_date, reservation_time, customer_name, reservation_comm FROM reservation res "
        		+ "INNER JOIN customer cus ON cus.customer_id = res.customer_id "
        		+ "INNER JOIN service ser ON ser.service_code = res.service_code";
    	
    	if(keyWord != null || !keyWord.isEmpty() || startDate != null || !startDate.isEmpty() || endDate != null || !endDate.isEmpty()) {
    		//기간 & 검색 조회
    		sql += " WHERE " + keyField + " like '%" + keyWord + "%'" + " WHERE reservation_date BETWEEN ? AND ? ORDER BY reservation_date DESC";
    	}
    	else if (keyWord != null || !keyWord.isEmpty() || startDate == null || startDate.isEmpty() || endDate == null || endDate.isEmpty()) {
    		//검색 조회
    		sql += " WHERE " + keyField + " like '%" + keyWord + "%'" + " ORDER BY reservation_date DESC";
    	}
    	else if (keyWord == null || keyWord.isEmpty() || startDate != null || !startDate.isEmpty() || endDate != null || !endDate.isEmpty()) {
    		//기간 조회
    		sql += " WHERE reservation_date BETWEEN ? AND ? ORDER BY reservation_date DESC";
    	}
    	else {
    		//전체 조회
    		sql += " ORDER BY reservation_date DESC";
    	}
    		
    	
    	ArrayList<ReservationDTO> list = new ArrayList<>();
    	
    	try {
    		// 데이터베이스 연결
	        context = new InitialContext();
	        dataSource = (DataSource) context.lookup("java:comp/env/jdbc/acorn");
	        connection = dataSource.getConnection();

	        // PreparedStatement 준비
	        statement = connection.prepareStatement(sql);
	        
	        // 날짜가 주어졌다면, 변환 후 바인딩
	        if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
	            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	            java.sql.Date sqlStartDate = new java.sql.Date(format.parse(startDate).getTime());
	            java.sql.Date sqlEndDate = new java.sql.Date(format.parse(endDate).getTime());

	            statement.setDate(1, sqlStartDate);
	            statement.setDate(2, sqlEndDate);
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
	            reservationDTO.setReservation_comm(resultSet.getString("reservation_comm"));

	            list.add(reservationDTO);
    		}
    		
    	}
    	catch(Exception e) {
    		System.out.println("[getReservationDTOList] Message : " + e.getMessage());
            System.out.println("[getReservationDTOList] Class   : " + e.getClass().getSimpleName());
    	}
    	finally {
    		freeConnection();
    	}
		return list;
    }
*/

    
    
    
/*------------------------------제희 님 요깅~~~~~♥--------------------------------------*/
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
        	//int st = Integer.parseInt(startDate);
        	//int ed = Integer.parseInt(endDate);
        	// 날짜 형식 정의
//           DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
//        	
//        	LocalDate startDateStr = LocalDate.parse(startDate, formatter);
//            LocalDate endDateStr = LocalDate.parse(endDate, formatter);
//        	if(!startDateStr.isAfter(endDateStr)) {
//        		System.out.println("시작 날짜를 종료 날짜보다 이후로 설정해주세요");
//        	}
     
            freeConnection();
        }

        return list;
    }


/*--------------------제희 님 요깅~~~~~♥-----------------------------*/
    
    //reservationPostProc.jsp 
    public void setReservationDTO(ReservationDTO reservationDTO) throws SQLException, ClassNotFoundException {
        String sql = null;

        try { 
        	context = new InitialContext();
    		dataSource = (DataSource)context.lookup("java:comp/env/jdbc/acorn");
    		connection = dataSource.getConnection();
    		
    		// cus_id와 ser_code를 조회하는 쿼리
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
    //예약자명 조회
    public List<String> getAllCustomerNames() throws SQLException{
		List<String> customerNames = new ArrayList<>();
		String query = "SELECT customer_name FROM customer"; //'cus' 테이블에서 회원명 가져옴
    	
		try {
			connection = dataSource.getConnection();
			statement = connection.prepareStatement(query);
			
			//statement.setString(1, "customer_name");
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
    
    //예약 서비스명 조회
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
	        freeConnection(); // freeConnection을 finally 블록에서 호출하여 자원을 반환
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
            
            // res 테이블에서 기존 ser_code, member_id 조회
            sql = "SELECT service_code, member_id FROM reservation WHERE reservation_no = ?";
            statement = connection.prepareStatement(sql);
            statement.setInt(1, resDto.getReservation_no()); 
            resultSet = statement.executeQuery();
            
            String old_ser_code = null;
            String old_mem_id = null;
            if (resultSet.next()) {
                old_ser_code = resultSet.getString("service_code");
                old_mem_id = resultSet.getString("member_id");
            }
            
            // cus_id와 ser_code를 조회하는 쿼리
            sql = "SELECT c.customer_id, s.service_code, m.member_id FROM customer c, service s, member m"
            		+ " WHERE c.customer_name = ? AND s.service_name = ? AND m.member_name = ?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, resDto.getCustomer_name());
            statement.setString(2, resDto.getService_name());
            statement.setString(3, resDto.getMember_name());
            resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                int customer_id = resultSet.getInt("customer_id");
                String new_ser_code = resultSet.getString("service_code");
                String new_mem_id = resultSet.getString("member_id");

                // ser_code가 변경된 경우에만 ser_cnt 수정
                if (!old_ser_code.equals(new_ser_code)) {
                    // 기존 ser_code의 ser_cnt 감소
                    sql = "UPDATE service SET service_cnt = service_cnt - 1 WHERE service_code = ?";
                    statement = connection.prepareStatement(sql);
                    statement.setString(1, old_ser_code);
                    statement.executeUpdate();

                    // 새로운 ser_code의 ser_cnt 증가
                    sql = "UPDATE service SET service_cnt = service_cnt + 1 WHERE service_code = ?";
                    statement = connection.prepareStatement(sql);
                    statement.setString(1, new_ser_code);
                    statement.executeUpdate();
                }
                
                
                // mem_id가 변경된 경우에만 member_cnt 수정
                if (!old_mem_id.equals(new_mem_id)) {
                    // 기존 mem_id의 mem_cnt 감소
                    sql = "UPDATE member SET member_cnt = member_cnt - 1 WHERE member_id = ?";
                    statement = connection.prepareStatement(sql);
                    statement.setString(1, old_mem_id);
                    statement.executeUpdate();

                    // 새로운 ser_code의 ser_cnt 증가
                    sql = "UPDATE member SET member_cnt = member_cnt + 1 WHERE member_id = ?";
                    statement = connection.prepareStatement(sql);
                    statement.setString(1, new_mem_id);
                    statement.executeUpdate();
                }

                // res 테이블 수정
                sql = "UPDATE reservation SET customer_id = ?, service_code = ?, reservation_date = ?, reservation_time = ?, member_id = ?, reservation_comm = ? WHERE reservation_no = ?";
                statement = connection.prepareStatement(sql);
                statement.setInt(1, customer_id);
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
			sql = "SELECT service_code, member_id FROM reservation WHERE reservation_no=?";
			statement = connection.prepareStatement(sql);
			statement.setInt(1, reservation_no);
			resultSet = statement.executeQuery();

			// resultSet을 통해 ser_code를 가져옴
			String service_code = null;
			String member_id = null;
			if (resultSet.next()) {
				service_code = resultSet.getString("service_code");
				member_id = resultSet.getString("member_id");
			}

			// 예약 삭제하는 쿼리
			sql = "DELETE FROM reservation WHERE reservation_no=?";
			statement = connection.prepareStatement(sql);
			statement.setInt(1, reservation_no);
			statement.executeUpdate();

			// ser_cnt 감소하는 쿼리
			sql = "UPDATE service SET service_cnt = service_cnt - 1 WHERE service_code = ?";
			statement = connection.prepareStatement(sql);
			statement.setString(1, service_code);
			statement.executeUpdate();
			
			// member_cnt 감소하는 쿼리
			sql = "UPDATE member SET member_cnt = member_cnt - 1 WHERE member_id = ?";
			statement = connection.prepareStatement(sql);
			statement.setString(1, member_id);
			statement.executeUpdate();

		} catch(Exception e) {
    		System.out.println("[deleteReservationDTO] Message : " + e.getMessage());
            System.out.println("[deleteReservationDTO] Class   : " + e.getClass().getSimpleName());
    	} finally {
			freeConnection();
		}
	  }
	
	//날짜별 예약 조회
	/*
	public List<ReservationDTO> getReservationDateSearch(String startDate, String endDate) {
	    String sql = null;
	    ArrayList<ReservationDTO> dateList = new ArrayList<>();
	    
	    try {
	        // SQL 쿼리 설정
	        if (startDate == null || startDate.isEmpty() || endDate == null || endDate.isEmpty()) {
	            sql = "SELECT reservation_no, service_name, reservation_date, reservation_time, customer_name, reservation_comm FROM reservation res "
	                    + "INNER JOIN customer cus ON cus.customer_id = res.customer_id "
	                    + "INNER JOIN service ser ON ser.service_code = res.service_code "
	                    + "ORDER BY reservation_date DESC";
	        } else {
	            sql = "SELECT reservation_no, service_name, reservation_date, reservation_time, customer_name, reservation_comm FROM reservation res "
	                    + "INNER JOIN customer cus ON cus.customer_id = res.customer_id "
	                    + "INNER JOIN service ser ON ser.service_code = res.service_code "
	                    + "WHERE reservation_date BETWEEN ? AND ? "
	                    + "ORDER BY reservation_date DESC";
	        }

	        // 데이터베이스 연결
	        context = new InitialContext();
	        dataSource = (DataSource) context.lookup("java:comp/env/jdbc/acorn");
	        connection = dataSource.getConnection();

	        // PreparedStatement 준비
	        statement = connection.prepareStatement(sql);
	        
	        // 날짜가 주어졌다면, 변환 후 바인딩
	        if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
	            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	            java.sql.Date sqlStartDate = new java.sql.Date(format.parse(startDate).getTime());
	            java.sql.Date sqlEndDate = new java.sql.Date(format.parse(endDate).getTime());

	            statement.setDate(1, sqlStartDate);
	            statement.setDate(2, sqlEndDate);
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
	            reservationDTO.setReservation_comm(resultSet.getString("reservation_comm"));

	            dateList.add(reservationDTO);
	        }

	    } catch(Exception e) {
    		System.out.println("[getReservationDateSearch] Message : " + e.getMessage());
            System.out.println("[getReservationDateSearch] Class   : " + e.getClass().getSimpleName());
    	} finally {
	        freeConnection();
	    }
	    
	    return dateList;
	}
	*/
}
