package command;

import java.io.IOException;
import java.io.PrintWriter;

import bean.DashboardDAO;
import bean.DashboardDTO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.*;

/**
 * 월별 매출 통계의 이전 달, 다음 달 조회 버튼 클릭 시 호출
 * 연관 소스들
 * - java.command.CommandFactory
 * - java.bean.DashboardDAO;
 * - java.bean.DashboardDTO;
 * - webapp/views/assets/js/pages/chartMonthRevenue.js
 * - webapp/views/dashboard.jsp 
 */
public class ChartServiceCommand implements ICommand {

	@Override
	public Object processCommand(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		int indexMonth = Integer.parseInt(req.getParameter("indexMonth"));
        DashboardDAO dashboard = new DashboardDAO();
        dashboard.setService(indexMonth);
        
        JSONObject json = new JSONObject();
        /* (반환 타입 : JSONArray) _ JSONObject에 담아서 데이터 전송 */
        json.put("service", dashboard.getService());
        json.put("revenue", dashboard.getRevenue());
        
        PrintWriter writer = resp.getWriter();
        writer.print(json);
        
		return "/TeamProject/dashboard.jsp";
	}

    

}