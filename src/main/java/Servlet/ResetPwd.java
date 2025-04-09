package Servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.UserDAO;


@WebServlet("/resetPwd")
public class ResetPwd extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("userId");
		String pwd = request.getParameter("newPassword");
		
		UserDAO userDao = new UserDAO();
		userDao.updatePwd(id, pwd);
		
		response.sendRedirect("login.jsp");
	}

}
