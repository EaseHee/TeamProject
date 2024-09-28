package command;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import bean.DashboardDAO;
import bean.DashboardDTO;

/**
 * 사용자가 대시보드의 달력 칸을 눌렀을 때 해당 칸의 날짜에 해당하는 
 * 예약 시간과 예약 서비스명 데이터를 json 형태로 응답한다. 
 * 
 * 연관 소스들
 * - java.command.CommandFactory
 * - java.bean.DashboardDAO;
 * - java.bean.DashboardDTO;
 * - webapp/views/assets/js/calendarWithReservation.js
 * - webapp/views/dashboard.jsp
 * - webapp/views/tests/dashboard/*
 */
public class CalendarReservationCommand implements ICommand {

	@Override
	public Object processCommand(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String selectedDate = req.getParameter("date");
		DashboardDAO dashboard = new DashboardDAO();
		dashboard.setSelectedDate(selectedDate);
		List<DashboardDTO> records = dashboard.getReservationByDate();
		
		PrintWriter out = resp.getWriter();
		JSONObject responseJson = new JSONObject();
		
		if (records == null) {
			out.print("{}");
			out.flush();
			return null;
		}
		
		int[] counter = {1}; // 메서드 내부에서 메서드 바깥에 있는 필드 값 변경을 위함.
		records.forEach(oneRecord -> {
			JSONArray arrayJson = new JSONArray();
			arrayJson.add(oneRecord.getReservation_time());
			arrayJson.add(oneRecord.getService_name());
			responseJson.put(counter[0], arrayJson);
			counter[0]++;
		});
		
		out.print(responseJson.toJSONString());
		out.flush();
		
		return null;
	}
	
}
