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
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		// 입력받은 정보 추출
		String name = req.getParameter("name");
		String branchcode = req.getParameter("branchcode");
		String tel = req.getParameter("tel");
		String email = req.getParameter("email");
		
		MypageDTO dto = new MypageDTO();
		dto.setBranch_code(branchcode);
		dto.setManager_name(name);
		dto.setManager_tel(tel);
		dto.setManager_mail(email);
		
		MypageDAO dao = new MypageDAO();
		dao.updateManager(dto);
		
		// 페이지 이동
		resp.sendRedirect("/TeamProject/views/mypage_update_view.jsp");
//		
	}
}
