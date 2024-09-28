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

public class MemberDAO {
	private Connection conn;
	private PreparedStatement stmt;
	private ResultSet rs;
	private Context ctx;
	private DataSource ds;
	
	public MemberDAO() {
		try {
			ctx = new InitialContext();
			
			ds = (DataSource)ctx.lookup("java:comp/env/jdbc/acorn");
		} catch (NamingException e) {
			e.printStackTrace();
			System.out.println("memberDao 생성자 : " + e);
		}
	}
	public void freeConn() {
			try {
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("freeConn : " + e);
			}
	}
	
	//List.jsp
	public List<MemberDTO> getMemberList(String keyField, String keyWord) {
		String sql = null;
		
		if(keyWord == null || keyWord.isEmpty() ) {
			sql = "SELECT member_id, member_name, member_job, member_tel FROM member";
		}
		else {
			sql = "SELECT member_id, member_name, member_job, member_tel FROM member "
					+ "WHERE " + keyField + "Like '%" + keyWord + "%'";
		}
			
			ArrayList list = new ArrayList();
			
			
			try {
				conn = ds.getConnection();
				stmt = conn.prepareStatement(sql);
				rs = stmt.executeQuery();
				
				while(rs.next()) {
					MemberDTO member = new MemberDTO();
					member.setMember_id(rs.getString("member_id"));
					member.setMember_name(rs.getString("member_name"));
					member.setMember_job(rs.getString("member_job"));
					member.setMember_tel(rs.getString("member_tel"));
					
					list.add(member);
					}
				}
			 catch (Exception e) {
				e.printStackTrace();
				System.out.println("getMemberList : " + e);
			}
			finally {
				freeConn();
			}
			return list;
		}

		// Post.jsp
		public List<String> getAllMemberJobsNames() {
			List<String> memberJobs = new ArrayList<>();
			String sql = "SELECT member_job FROM member"; // 'member' 테이블에서 직책 명 가져옴

			try {
				conn = ds.getConnection();
				stmt = conn.prepareStatement(sql);
				rs = stmt.executeQuery(); // resultSet에 결과 할당

				while (rs.next()) {
					memberJobs.add(rs.getString("member_job"));
				}
			} catch (SQLException e) {
				System.out.println("[getAllMemberJobsName] Message : " + e.getMessage());
				System.out.println("[getAllMemberJobsName] Class   : " + e.getClass().getSimpleName());
			} finally {
				freeConn();
			}
			return memberJobs;
		}

	

		//PostProc.jsp 
		public void setMemberDTO(MemberDTO memberDto) {
			String sql = "INSERT INTO member(member_id, member_name, member_job, member_date, member_tel)"
					+ "VALUES(?,?,?,?,?)";

			try {
				conn = ds.getConnection();
				stmt = conn.prepareStatement(sql);
				
				stmt.setString(1, memberDto.getMember_id());
				stmt.setString(2, memberDto.getMember_name());
				stmt.setString(3, memberDto.getMember_job());
				stmt.setString(4, memberDto.getMember_date());
				stmt.setString(5, memberDto.getMember_tel());

				stmt.executeUpdate();
			} 
			catch (Exception e) {
				e.printStackTrace();
				System.out.println("setMemberDTO : " + e);
			}
			finally {
				freeConn();
			}
		}
		
		
		//read.jsp
		public MemberDTO getMemberDTO(String member_id) {
			String sql = "SELECT * FROM member WHERE member_id=?"; 
			MemberDTO memberDto = new MemberDTO();
			
			try {
				conn = ds.getConnection();
				stmt = conn.prepareStatement(sql);
				
				stmt.setString(1, member_id);
				rs = stmt.executeQuery();
				
				if(rs.next()) {
					memberDto.setMember_id(rs.getString("member_id"));
					memberDto.setMember_name(rs.getString("member_name"));
					memberDto.setMember_job(rs.getString("member_job"));
					memberDto.setMember_date(rs.getString("member_id"));
					memberDto.setMember_tel(rs.getString("member_tel"));
				}
			} 
			catch (Exception e) {
				e.printStackTrace();
				System.out.println("getMemberDTO" + e);
			}
			finally {
				freeConn();
			}
			return memberDto;
		}
	}

