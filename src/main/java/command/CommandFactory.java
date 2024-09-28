package command;

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
			default:
				return null;
		}
	}
}
