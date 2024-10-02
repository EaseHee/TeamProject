package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.MypageDAO;
import bean.MypageDTO;

@WebServlet("/mypage")
public class MypageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        // 세션에서 branchCode 가져오기
        String branchCode = (String) session.getAttribute("branchCode");

        if (branchCode == null) {
            System.out.println("지점코드 null login 페이지로");
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        // DB에서 관리자 정보 가져오기
        MypageDAO dao = new MypageDAO();
        MypageDTO manager = dao.getManagerInfo(branchCode);

        if (manager == null) {
            System.out.println("매니저 null branchCode: " + branchCode);
            req.setAttribute("error", "관리자 정보를 찾을 수 없습니다.");
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
            return;
        }

        // manager 객체를 세션에 저장
        session.setAttribute("manager", manager);

        // JSP로 포워딩 (mypage_view.jsp로 이동)
        req.getRequestDispatcher("/views/mypage_view.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();

        // 세션에서 branchCode 가져오기
        String branchCode = (String) session.getAttribute("branchCode");

        // 사용자로부터 입력받은 수정된 값 가져오기
        String name = req.getParameter("name");
        String tel = req.getParameter("tel");
        String mail = req.getParameter("mail");

        // DTO에 값 설정
        MypageDTO dto = new MypageDTO();
        dto.setBranch_code(branchCode);
        dto.setManager_name(name);
        dto.setManager_tel(tel);
        dto.setManager_mail(mail);

        // DB 업데이트 처리
        MypageDAO dao = new MypageDAO();
        dao.updateManager(dto);

        // branchcode를 포함하여 mypage_view.jsp로 리다이렉트
        resp.sendRedirect(req.getContextPath() + "/views/mypage_view.jsp?branchCode=" + branchCode);
    }
}
