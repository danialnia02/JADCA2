package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.*;
import dbaccess.database;
import java.sql.*;

/**
 * Servlet implementation class loginValidation
 */
@WebServlet("/loginValidation")
public class loginValidation extends HttpServlet {
	private static final long serialVersionUID = 1L;
	users uBean = null;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public loginValidation() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// HttpSession session = request.getSession();
		try {
			String username = request.getParameter("username");
			String password = request.getParameter("password");

			database udatabase = new database();
			uBean = udatabase.getUserDetails(username, password);

			request.setAttribute("userData", uBean);
//			session.setAttribute("username", uBean.getUsername());
//			session.setAttribute("role", uBean.getRole());
//			session.setAttribute("id", uBean.getUserId());

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);

	}

}
