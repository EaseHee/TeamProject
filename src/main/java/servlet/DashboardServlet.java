package servlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import command.CommandFactory;
import command.ICommand;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;


@WebServlet(urlPatterns="/dashboard")
public class DashboardServlet extends HttpServlet {

    @Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset:utf-8");
        
        String command = req.getParameter("command");
        System.out.println("command: " + command);
        System.out.println("date:" + req.getParameter("date"));
        
        CommandFactory cmdFact = CommandFactory.newInstance();
        ICommand iCmd = null;
        
        iCmd = cmdFact.createCommandInstance(command);
        Object cmdResult = iCmd.processCommand(req, resp);
        if (cmdResult != null && cmdResult instanceof String) {
        	String url = "";
        	url = (String) cmdResult;
        	RequestDispatcher dispatcher = req.getRequestDispatcher(url);
            dispatcher.forward(req, resp);
        }
    }
}
