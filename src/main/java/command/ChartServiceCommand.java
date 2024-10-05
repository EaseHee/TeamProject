package command;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import bean.DashboardDAO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.*;

import bean.DashboardDTO;

/**
 * 월별 매출 통계의 이전 달, 다음 달 조회 버튼 클릭 시 호출
 * 연관 소스들
 * - java.command.CommandFactory
 * - java.servlet.DashboardServlet
 * - java.bean.DashboardDAO _ getServiceList(), getMonthRevenueList()
 * - webapp/views/assets/js/pages/chartMonthRevenue.js
 * - webapp/views/dashboard.jsp 
 */
    
/**
 * ========================= 관련 파일 및 속성 =========================
 * chartMonthRevenue.js _ barOptions _ series 속성에 저장할 데이터 (JSONArray)
 * JSONArary : [
 *      JSONObejct : {
 *          KEY : ${커트}, 
 *          VALUE: JSONArray : ["서비스별 월 수익"])
 *      }, {
 *      JSONObejct : {
 *          KEY : ${파마}, 
 *          VALUE: JSONArray : ["서비스별 월 수익"])
 *      }, {
 *      JSONObejct : {
 *          KEY : ${염색}, 
 *          VALUE: JSONArray : ["서비스별 월 수익"])
 *      }, {
 *      JSONObejct : {
 *          KEY : ${영양}, 
 *          VALUE: JSONArray : ["서비스별 월 수익"])
 *      }, {
 * ]
 */
public class ChartServiceCommand implements ICommand {

	@Override
	public Object processCommand(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// fetch 전달용 객체 PrintWriter
        PrintWriter writer = resp.getWriter();
        DashboardDAO dashboard = new DashboardDAO();
        List<DashboardDTO> serviceList = dashboard.getServiceList(); // 서비스(DTO) 리스트

        JSONArray jsonArray = new JSONArray();
        for (DashboardDTO service : serviceList) { // 반복 횟수 4회 (= 단일 서비스 개수)
            // JSONObject에 (KEY : VALUE) 형식으로 (name : service_name), (data : revenueList)을 JSONArray에 저장
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("name", service.getService_name());
            jsonObject.put("data", dashboard.getMonthRevenueList(service)); // 수익 금액 리스트 | JSONObject에 Collection 저장 시 JSONArray로 자동 변환
            jsonArray.put(jsonObject);
        }
        writer.print(jsonArray); // JSON형식 전달 : [chartMonthRevenue.js] fetch()의 return 값
        writer.flush();
        
		return null;
	}
}