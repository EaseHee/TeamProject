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
 * - java.servlet.DashboardServlet
 * - java.bean.DashboardDAO
 * - java.bean.DashboardDTO
 * - webapp/views/assets/js/pages/chartMonthRevenue.js
 * - webapp/views/dashboard.jsp 
 */
public class ChartServiceCommand implements ICommand {

	@Override
	public Object processCommand(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
        int indexMonth;
        if (req.getParameter("indexMonth") != null && !req.getParameter("indexMonth").isBlank()) {
            System.out.println("req.getParameter(indexMonth) : " + req.getParameter("indexMonth"));
            indexMonth = Integer.parseInt(req.getParameter("indexMonth"));
            // 당월 이후의 통계는 조회 불가
            if (indexMonth < 0) {
                indexMonth = 0;
            }
        } else {
            indexMonth = 0;
        }
        DashboardDAO dashboard = new DashboardDAO();
        dashboard.setService(indexMonth);
        
        /* getter() "반환 타입 : JSONArray" */
        JSONArray jsonServiceArray = dashboard.getService();
        JSONArray jsonRevenueArray = dashboard.getRevenue();
        
        /* 전달용 JSONObject */
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("service", jsonServiceArray);
        jsonObject.put("revenue", jsonRevenueArray);

        PrintWriter writer = resp.getWriter();
        writer.print(jsonObject);
        writer.flush();
        
		return null;
	}

    

}