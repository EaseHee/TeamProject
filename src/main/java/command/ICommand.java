package command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Controller에 해당하는 서블릿 내에 직접 로직 코드를 넣으면 각 커맨드마다의 로직 코드가 존재하기에 
 * 결국 서블릿 내 코드가 너무 방대해질 것이다. 이를 방지하기 위해 로직 코드를 메서드화시키고 각각의 
 * 클래스 파일로 분류하여 모듈화시킨다. 
 * 커멘드 메서드의 표준화를 위해 인터페이스를 다음과 같이 정의한다. 
 */
public interface ICommand {
	Object processCommand(
			HttpServletRequest req, 
			HttpServletResponse resp)
		throws ServletException, IOException;
}
