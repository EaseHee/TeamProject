package command;

/**
 * 커맨드 객체 생성 로직을 서블릿에 직접 작성하면 커맨드 종류가 많아질수록 객체 생성 로직 코드도 
 * 방대해질 것이다. 이를 방지하기 위해 커맨드 객체 생성을 "커맨드 팩토리"가 대신 수행하도록 함. 
 * 커맨드 팩토리 자체는 하나만 필요하므로 싱글톤으로 구현함.
 */
public class CommandFactory {
	private static CommandFactory cmdFact = new CommandFactory();
	private CommandFactory() {}
	public static CommandFactory newInstance() {
		return cmdFact;
	}
	
	public ICommand createCommandInstance(String command) {
		if (command == null) return null;
		switch (command) {
			case "CALENDAR_RESERVATION":
				return new CalendarReservationCommand(); // return null
			case "CHART_SERVICE":
				return new ChartServiceCommand(); // return null
			default:
				return null;
		}
	}
}
