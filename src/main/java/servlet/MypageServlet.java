package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.AdminDAO;
import bean.AdminDTO;
import bean.MypageDAO;
import bean.MypageDTO;

@WebServlet("/Mypage")
public class MypageServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		 String branchcode = req.getParameter("branchcode"); // 브랜치 코드 가져오기
	        
	        MypageDAO dao = new MypageDAO();
	        MypageDTO manager = dao.getManagerInfo(branchcode); // 관리자 정보 불러오기
	        
	        req.setAttribute("manager", manager); // JSP로 전달할 데이터 설정
	        
	        // JSP로 포워딩
	        req.getRequestDispatcher("/views/mypage_view.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		String branchcode = req.getParameter("branchcode");
	    String name = req.getParameter("name");
	    String tel = req.getParameter("tel");
	    String mail = req.getParameter("mail");
		
		MypageDTO dto = new MypageDTO();
		dto.setBranch_code(branchcode);
		dto.setManager_name(name);
		dto.setManager_tel(tel);
		dto.setManager_mail(mail);
		
		MypageDAO dao = new MypageDAO();
		dao.updateManager(dto);
		
		resp.sendRedirect(req.getContextPath() + "/Mypage?branchcode=" + branchcode);
//		
	}
}
