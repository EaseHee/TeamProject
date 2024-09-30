package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class NoticeDAO {
	private Context context = null;
    private DataSource dataSource = null;

    private Connection connection = null;
    private PreparedStatement statement = null;
    private ResultSet resultSet = null;

    public NoticeDAO() {
        try {
            context = new InitialContext();
            dataSource = (DataSource) context.lookup("java:comp/env/jdbc/acorn");
        } catch (NamingException e) {
            System.out.println("[NoticeDAO] Message : " + e.getMessage());
            System.out.println("[NoticeDAO] Class   : " + e.getClass().getSimpleName());
        }
    }
        
    // DB 연결 해제
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
    // 공지사항 목록 조회
    public List<NoticeDTO> getNormalNoticeList(String keyWord) {
		String sql = "";
		ArrayList<NoticeDTO> list = new ArrayList<>();
	    
	    if(keyWord == null || keyWord.isEmpty()) { // 일반 공지사항 반환
	    	sql = "SELECT notice_no, notice_title, notice_reg FROM notice WHERE notice_check = 0 ORDER BY notice_no DESC";
	    } else { // 검색어와 일치하는 일반/중요 공지사항 반환
	    	sql = "SELECT notice_no, notice_title, notice_reg FROM notice WHERE notice_title like '%" + keyWord + "%' ORDER BY notice_no DESC";
	    }
	
	    try {
	        connection = dataSource.getConnection();
	        statement = connection.prepareStatement(sql);
	        resultSet = statement.executeQuery();
	
	        while(resultSet.next()) {
	            NoticeDTO noticeDTO = new NoticeDTO();
	            noticeDTO.setNotice_no(resultSet.getInt("notice_no"));
	            noticeDTO.setNotice_title(resultSet.getString("notice_title"));
	            noticeDTO.setNotice_reg(resultSet.getString("notice_reg"));
	
	            list.add(noticeDTO);
	        }
	    } catch (Exception e) {
	        System.out.println("[getNormalNoticeList] Message : " + e.getMessage());
	        System.out.println("[getNormalNoticeList] Class   : " + e.getClass().getSimpleName());
	    } finally {
	        freeConnection();
	    }
	    
	    return list;
	}
    
    // 중요 공지사항 표시 (검색어를 입력하지 않았을 때에만 보이도록)
    public List<NoticeDTO> getCheckedNoticeList(String keyWord) {
    	ArrayList<NoticeDTO> list = new ArrayList<>();
    	if(keyWord == null || keyWord.isEmpty()) {
	    	String sql = "SELECT notice_no, notice_title, notice_reg FROM notice WHERE notice_check = 1 ORDER BY notice_no DESC";
		    try {
		        connection = dataSource.getConnection();
		        statement = connection.prepareStatement(sql);
		        resultSet = statement.executeQuery();
		
		        while(resultSet.next()) {
		            NoticeDTO noticeDTO = new NoticeDTO();
		            noticeDTO.setNotice_no(resultSet.getInt("notice_no"));
		            noticeDTO.setNotice_title(resultSet.getString("notice_title"));
		            noticeDTO.setNotice_reg(resultSet.getString("notice_reg"));
		
		            list.add(noticeDTO);
		        }
		    } catch (Exception e) {
		        System.out.println("[getCheckedNoticeList] Message : " + e.getMessage());
		        System.out.println("[getCheckedNoticeList] Class   : " + e.getClass().getSimpleName());
		    } finally {
		        freeConnection();
		    }
    	}
	    return list;
	}
    
    // 공지사항 글 상세페이지
    public NoticeDTO getNoticeDetail(int no) {
        NoticeDTO noticeDTO = new NoticeDTO();
        String sql = "SELECT notice_no, notice_title, notice_reg, notice_content FROM notice WHERE notice_no=?";

        try {
            connection = dataSource.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, no);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                noticeDTO.setNotice_no(resultSet.getInt("notice_no"));
                noticeDTO.setNotice_title(resultSet.getString("notice_title"));
                noticeDTO.setNotice_reg(resultSet.getString("notice_reg"));
                noticeDTO.setNotice_content(resultSet.getString("notice_content"));
            }
        } catch (SQLException e) {
            System.out.println("[getNoticeDetail] Message : " + e.getMessage());
            System.out.println("[getNOticeDetail] Class   : " + e.getClass().getSimpleName());
        } finally {
            freeConnection();
        }

        return noticeDTO;
    }
    
    // 이전 공지사항 조회
    public NoticeDTO getPreviousNotice(int no) {
        NoticeDTO noticeDTO = new NoticeDTO();
        String sql = "SELECT notice_no, notice_title, notice_reg, notice_content FROM notice WHERE notice_no < ? ORDER BY notice_no DESC LIMIT 1";

        try {
            connection = dataSource.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, no);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                noticeDTO.setNotice_no(resultSet.getInt("notice_no"));
                noticeDTO.setNotice_title(resultSet.getString("notice_title"));
                noticeDTO.setNotice_reg(resultSet.getString("notice_reg"));
                noticeDTO.setNotice_content(resultSet.getString("notice_content"));
            }
        } catch (SQLException e) {
            System.out.println("[getNoticeDetail] Message : " + e.getMessage());
            System.out.println("[getNOticeDetail] Class   : " + e.getClass().getSimpleName());
        } finally {
            freeConnection();
        }

        return noticeDTO;
    }
    
    // 다음 공지사항 조회
    public NoticeDTO getNextNotice(int no) {
        NoticeDTO noticeDTO = new NoticeDTO();
        String sql = "SELECT notice_no, notice_title, notice_reg, notice_content FROM notice WHERE notice_no > ? ORDER BY notice_no ASC LIMIT 1";

        try {
            connection = dataSource.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, no);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                noticeDTO.setNotice_no(resultSet.getInt("notice_no"));
                noticeDTO.setNotice_title(resultSet.getString("notice_title"));
                noticeDTO.setNotice_reg(resultSet.getString("notice_reg"));
                noticeDTO.setNotice_content(resultSet.getString("notice_content"));
            }
        } catch (SQLException e) {
            System.out.println("[getNoticeDetail] Message : " + e.getMessage());
            System.out.println("[getNOticeDetail] Class   : " + e.getClass().getSimpleName());
        } finally {
            freeConnection();
        }

        return noticeDTO;
    }
}