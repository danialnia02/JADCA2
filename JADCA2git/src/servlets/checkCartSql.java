package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import dbaccess.database;

/**
 * Servlet implementation class checkCartSql
 */
@WebServlet("/checkCartSql")
public class checkCartSql extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public checkCartSql() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			String id= (String) request.getAttribute("id");
			String itemId=(String) request.getAttribute("itemId");				
			database udatabase = new database();			
			ResultSet rs= udatabase.checkCartSql(id,itemId);				
			request.setAttribute("checkCartSql",rs);			
			
		}catch(Exception e) {
		System.out.println("here223223432");
		e.printStackTrace();		
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
