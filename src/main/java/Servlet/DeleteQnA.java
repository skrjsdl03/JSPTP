package Servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.QnaDAO;

/**
 * Servlet implementation class DeleteQnA
 */
@WebServlet("/deleteQna")
public class DeleteQnA extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			String i_id = request.getParameter("i_id");
			
			QnaDAO qDao = new QnaDAO();
			
			qDao.deleteQna(Integer.parseInt(i_id));
			
			response.sendRedirect("Q&A.jsp");
	}


}
