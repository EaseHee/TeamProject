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

    /*
    public List<ReservationDTO> getReservationDTOList(String keyField, String keyWord) {
        String sql;
        if (keyWord == null || keyWord.isEmpty()) {
            sql = "SELECT reservation_no, service_name, reservation_date, reservation_time, customer_name, reservation_comm FROM reservation res "
                    + "INNER JOIN customer cus ON cus.customer_id = res.customer_id "
                    + "INNER JOIN service ser ON ser.service_code = res.service_code "
                    + "ORDER BY reservation_date DESC";
        } else {
            sql = "SELECT reservation_no, service_name, reservation_date, reservation_time, customer_name, reservation_comm FROM reservation res "
                    + "INNER JOIN customer cus ON cus.customer_id = res.customer_id "
                    + "INNER JOIN service ser ON ser.service_code = res.service_code "
                    + "WHERE " + keyField + " LIKE ?";
        }

        List<ReservationDTO> list = new ArrayList<>();
        
        try {
            context = new InitialContext();
            dataSource = (DataSource)context.lookup("java:comp/env/jdbc/acorn");
            connection = dataSource.getConnection();

            PreparedStatement statement = connection.prepareStatement(sql);
            
            if (keyWord != null && !keyWord.isEmpty()) {
                statement.setString(1, "%" + keyWord + "%");
            }

            ResultSet resultSet = statement.executeQuery();
            
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
        } catch (Exception e) {
            System.out.println("[getReservationDTOList] Message : " + e.getMessage());
            System.out.println("[getReservationDTOList] Class   : " + e.getClass().getSimpleName());
        } finally {
            freeConnection();
        }
        
        return list;
    }
    */
    /*
    public List<ReservationDTO> getReservationDTOList(String keyField, String keyWord, int beginPerPage, int numPerPage) {
        String sql;
        
        // 키워드가 없으면 모든 데이터 조회
        if (keyWord == null || keyWord.isEmpty()) {
            sql = "SELECT reservation_no, service_name, reservation_date, reservation_time, customer_name, reservation_comm FROM reservation res "
                + "INNER JOIN customer cus ON cus.customer_id = res.customer_id "
                + "INNER JOIN service ser ON ser.service_code = res.service_code "
                + "ORDER BY reservation_date DESC "
                + "LIMIT ? OFFSET ?";
        } else {
            sql = "SELECT reservation_no, service_name, reservation_date, reservation_time, customer_name, reservation_comm FROM reservation res "
                + "INNER JOIN customer cus ON cus.customer_id = res.customer_id "
                + "INNER JOIN service ser ON ser.service_code = res.service_code "
                + "WHERE " + keyField + " LIKE ? "
                + "ORDER BY reservation_date DESC "
                + "LIMIT ? OFFSET ?";
        }

        List<ReservationDTO> list = new ArrayList<>();

        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
             
            if (keyWord != null && !keyWord.isEmpty()) {
                statement.setString(1, "%" + keyWord + "%");
                statement.setInt(2, numPerPage);
                statement.setInt(3, beginPerPage);
            } else {
                statement.setInt(1, numPerPage);
                statement.setInt(2, beginPerPage);
            }

            try (ResultSet resultSet = statement.executeQuery()) {
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
        } catch (Exception e) {
            System.out.println("[getReservationDTOList] 메시지: " + e.getMessage());
            System.out.println("[getReservationDTOList] 클래스: " + e.getClass().getSimpleName());
        }

        return list;
    }
	*/
    

    
    //reservationPostProc.jsp 
    public void setReservationDTO(ReservationDTO reservationDTO) throws SQLException, ClassNotFoundException {
        String sql = null;

        try { 
        	context = new InitialContext();
    		dataSource = (DataSource)context.lookup("java:comp/env/jdbc/acorn");
    		connection = dataSource.getConnection();
    		
    		// cus_id와 ser_code를 조회하는 쿼리
    		sql = "SELECT c.customer_id, s.service_code FROM customer c, service s WHERE c.customer_name = ? AND s.service_name = ?";
    		statement = connection.prepareStatement(sql);
    		statement.setString(1, reservationDTO.getCustomer_name());
    		statement.setString(2, reservationDTO.getService_name());

    		resultSet = statement.executeQuery();

    		if(resultSet.next()) {
    		    int customer_id = resultSet.getInt("customer_id");
    		    String service_code = resultSet.getString("service_code");

    		    // res 테이블에 삽입하는 쿼리
    		    sql = "INSERT INTO reservation (customer_id, service_code, reservation_date, reservation_time, reservation_comm) VALUES (?, ?, ?, ?, ?)";
    		    statement = connection.prepareStatement(sql);
    		    statement.setInt(1, customer_id);
    		    statement.setString(2, service_code);
    		    statement.setString(3, reservationDTO.getReservation_date());
    		    statement.setString(4, reservationDTO.getReservation_time());
    		    statement.setString(5, reservationDTO.getReservation_comm());
    		    statement.executeUpdate();
    		    
    		    //ser_cnt 증가
    		    sql = "UPDATE service SET service_cnt = service_cnt + 1 WHERE service_code = ?";
    		    statement = connection.prepareStatement(sql);
    		    statement.setString(1, service_code);
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
    
    
    //reservationRead.jsp , reservationUpdate.jsp
    public ReservationDTO getReservationDTO(int reservation_no) {
    	String sql = null;
    	ReservationDTO dto = new ReservationDTO();
    	
    	try {
    		context = new InitialContext();
            dataSource = (DataSource) context.lookup("java:comp/env/jdbc/acorn");
            connection = dataSource.getConnection();
            
            sql = "SELECT * FROM reservation res "
            		+ "INNER JOIN customer cus ON cus.customer_id = res.customer_id INNER JOIN service ser ON ser.service_code = res.service_code "
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
            
            // res 테이블에서 기존 ser_code 조회
            sql = "SELECT service_code FROM reservation WHERE reservation_no = ?";
            statement = connection.prepareStatement(sql);
            statement.setInt(1, resDto.getReservation_no()); 
            resultSet = statement.executeQuery();
            
            String old_ser_code = null;
            if (resultSet.next()) {
                old_ser_code = resultSet.getString("service_code");
            }
            
            // cus_id와 ser_code를 조회하는 쿼리
            sql = "SELECT c.customer_id, s.service_code FROM customer c, service s WHERE c.customer_name = ? AND s.service_name = ?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, resDto.getCustomer_name());
            statement.setString(2, resDto.getService_name());
            resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                int customer_id = resultSet.getInt("customer_id");
                String new_ser_code = resultSet.getString("service_code");

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

                // res 테이블 수정
                sql = "UPDATE reservation SET customer_id = ?, service_code = ?, reservation_date = ?, reservation_time = ?, reservation_comm = ? WHERE reservation_no = ?";
                statement = connection.prepareStatement(sql);
                statement.setInt(1, customer_id);
                statement.setString(2, new_ser_code);
                statement.setString(3, resDto.getReservation_date());
                statement.setString(4, resDto.getReservation_time());
                statement.setString(5, resDto.getReservation_comm());
                statement.setInt(6, resDto.getReservation_no());
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

			// res 테이블에서 ser_code 조회
			sql = "SELECT service_code FROM reservation WHERE reservation_no=?";
			statement = connection.prepareStatement(sql);
			statement.setInt(1, reservation_no);
			resultSet = statement.executeQuery();

			// resultSet을 통해 ser_code를 가져옴
			String service_code = null;
			if (resultSet.next()) {
				service_code = resultSet.getString("service_code");
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

		} catch(Exception e) {
    		System.out.println("[deleteReservationDTO] Message : " + e.getMessage());
            System.out.println("[deleteReservationDTO] Class   : " + e.getClass().getSimpleName());
    	} finally {
			freeConnection();
		}
	  }
	
	//날짜별 예약 조회
	/*
	public List<ReservationDTO> getReservationByregdate(String startDate, String endDate) {
	    String sql;
	    ArrayList<ReservationDTO> dateList = new ArrayList<>();

	    try {
	        context = new InitialContext();
	        dataSource = (DataSource) context.lookup("java:comp/env/jdbc/acorn");
	        connection = dataSource.getConnection();

	        if (startDate == null || startDate.isEmpty() || endDate == null || endDate.isEmpty()) {
	            // 날짜가 없을 경우 모든 예약 조회
	            sql = "SELECT * FROM res "
	                + "INNER JOIN cus ON cus.cus_id = res.cus_id "
	                + "INNER JOIN ser ON ser.ser_code = res.ser_code";
	        } else {
	            // 날짜가 있을 경우 해당 기간 내의 예약 조회
	            sql = "SELECT * FROM res "
	                + "INNER JOIN cus ON cus.cus_id = res.cus_id "
	                + "INNER JOIN ser ON ser.ser_code = res.ser_code "
	                + "WHERE res_date BETWEEN ? AND ?";
	        }

	        statement = connection.prepareStatement(sql);

	        // 날짜가 있을 경우 파라미터 설정
	        if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
	            statement.setString(1, startDate);
	            statement.setString(2, endDate);
	        }

	        resultSet = statement.executeQuery();

	        while (resultSet.next()) {
	            ReservationDTO resDto = new ReservationDTO();
	            resDto.setCus_id(resultSet.getInt("cus_id"));
	            resDto.setRes_comm(resultSet.getString("res_comm"));
	            resDto.setRes_date(resultSet.getString("res_date"));
	            resDto.setRes_no(resultSet.getInt("res_no"));
	            resDto.setRes_time(resultSet.getString("res_time"));
	            resDto.setSer_code(resultSet.getString("ser_code"));

	            dateList.add(resDto);
	        }
	    } catch (Exception err) {
	        System.out.println("Error : " + err);
	    } finally {
	        freeConnection();
	    }
	    return dateList;
	}
	*/
	/*
	public List<ReservationDTO> getReservationDateSearch(String startDate, String endDate) {
	    String sql= "SELECT res_no, ser_name, res_date, res_time, cus_name, res_comm FROM res "
		            + "INNER JOIN cus ON cus.cus_id = res.cus_id "
		            + "INNER JOIN ser ON ser.ser_code = res.ser_code "
		            + "WHERE res_date BETWEEN ? AND ?";

	    ArrayList<ReservationDTO> dateList = new ArrayList<>();
	    
	    	System.out.println("Start Date: " + startDate);
	        System.out.println("End Date: " + endDate);
	    try {
	        context = new InitialContext();
	        dataSource = (DataSource) context.lookup("java:comp/env/jdbc/acorn");
	        connection = dataSource.getConnection();
	                
	        statement = connection.prepareStatement(sql);
	        statement.setString(1, startDate); // 첫 번째 '?'에 startDate 설정
	        statement.setString(2, endDate);   // 두 번째 '?'에 endDate 설정   
	        resultSet = statement.executeQuery();

	        while (resultSet.next()) {
	            ReservationDTO reservationDTO = new ReservationDTO();
	            reservationDTO.setRes_no(resultSet.getInt("res_no"));
	            reservationDTO.setSer_name(resultSet.getString("ser_name"));
	            reservationDTO.setRes_date(resultSet.getString("res_date"));
	            reservationDTO.setRes_time(resultSet.getString("res_time"));
	            reservationDTO.setCus_name(resultSet.getString("cus_name"));
	            reservationDTO.setRes_comm(resultSet.getString("res_comm"));

	            dateList.add(reservationDTO);
	        }

	    } catch (Exception err) {
	    	err.printStackTrace();
	    	
	    } finally {
	        freeConnection();
	    }
	    return dateList;
	}
	*/
	
	/*
	public List<ReservationDTO> getReservationDateSearch(String startDate, String endDate) {
		
		String sql = null;
	    
	    if (startDate == null || startDate.isEmpty() || endDate == null || endDate.isEmpty()) {
	        sql = "SELECT res_no, ser_name, res_date, res_time, cus_name, res_comm From res "
	                + "INNER JOIN cus ON cus.cus_id = res.cus_id "
	                + "INNER JOIN ser ON ser.ser_code = res.ser_code";    
	    } else {
	        sql = "SELECT res_no, ser_name, res_date, res_time, cus_name, res_comm FROM res "
	                + "INNER JOIN cus ON cus.cus_id = res.cus_id "
	                + "INNER JOIN ser ON ser.ser_code = res.ser_code "
	                + "WHERE res_date BETWEEN ? AND ?";
	    }
	    
	    ArrayList<ReservationDTO> dateList = new ArrayList<>();
	    
	    try {
	        context = new InitialContext();
	        dataSource = (DataSource) context.lookup("java:comp/env/jdbc/acorn");
	        connection = dataSource.getConnection();
	                
	        statement = connection.prepareStatement(sql);
	        
	        if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
	            statement.setString(1, startDate);
	            statement.setString(2, endDate);
	        }
	        
	        resultSet = statement.executeQuery();

	        while (resultSet.next()) {
	            ReservationDTO reservationDTO = new ReservationDTO();
	            reservationDTO.setRes_no(resultSet.getInt("res_no"));
	            reservationDTO.setSer_name(resultSet.getString("ser_name"));
	            reservationDTO.setRes_date(resultSet.getString("res_date"));
	            reservationDTO.setRes_time(resultSet.getString("res_time"));
	            reservationDTO.setCus_name(resultSet.getString("cus_name"));
	            reservationDTO.setRes_comm(resultSet.getString("res_comm"));

	            dateList.add(reservationDTO);
	        }

	    } catch (Exception err) {
	        err.printStackTrace();
	    } finally {
	        freeConnection();
	    }
	    return dateList;
	}
	*/
	
	/*
	public ArrayList<ReservationDTO> getReservationDateSearch(String startDate, String endDate) {
    	String sql = "SELECT * FROM res WHERE res_date BETWEEN ? AND ?";
    	ArrayList<ReservationDTO> reservationList = new ArrayList<>();
        
        try {
        	connection = dataSource.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, startDate);
            statement.setString(2, endDate);


            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                ReservationDTO reservation = new ReservationDTO();
                reservation.setCus_id(resultSet.getInt("cus_id"));
                reservation.setCus_name(resultSet.getString("cus_name"));
                reservation.setSer_name(resultSet.getString("ser_name"));
                reservation.setSer_code(resultSet.getString("ser_code"));
                reservation.setRes_no(resultSet.getInt("res_no"));
                reservation.setRes_date(resultSet.getString("res_date"));
                reservation.setRes_time(resultSet.getString("res_time"));
                reservation.setRes_comm(resultSet.getString("res_comm"));
                

                reservationList.add(reservation);
            }
        } catch (SQLException e) {
            System.out.println("[getCustomerByregdate] Message : " + e.getMessage());
            System.out.println("[getCustomerByregdate] Class   : " + e.getClass().getSimpleName());
        } finally {
            freeConnection();
        }
        return reservationList;
    }
	*/
	
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

}
