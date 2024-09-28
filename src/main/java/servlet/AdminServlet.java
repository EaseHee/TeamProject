package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.AdminDAO;
import bean.AdminDTO;

@WebServlet("/signup")
public class AdminServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 한글 인코딩
		req.setCharacterEncoding("UTF-8");
		
		String command = req.getParameter("command");
		String url = "";
		
		// 입력받은 정보 추출
		String name = req.getParameter("name");
		String birth = req.getParameter("birth");
		String ph = req.getParameter("ph");
		String mail = req.getParameter("mail");
		String id = req.getParameter("id");
		String pw = req.getParameter("pw");
		String pwcheck = req.getParameter("pwcheck");
		String[] terms = req.getParameterValues("terms");
		
		// DB 연동
		AdminDTO dto = new AdminDTO();
		dto.setAd_name(name);
		dto.setAd_ph(ph);
		dto.setAd_mail(mail);
		dto.setAd_id(id);
		dto.setAd_pw(pw);
		
		AdminDAO dao = new AdminDAO();
		dao.insertAdmin(dto);
		
		// 페이지 이동
		resp.sendRedirect("/TeamProject/views/login.jsp");
		
		
//		if(command.equals("LOGIN")) {
//			url = "/views/login.jsp";
//		}
//		
//		RequestDispatcher dispatcher = req.getRequestDispatcher(url);
//		dispatcher.forward(req, resp);
	}
}
