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
 * Servlet implementation class addToCartSql
 */
@WebServlet("/addToCartSql")
public class addToCartSql extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public addToCartSql() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String id = (String) request.getAttribute("id");
			String currentQuantity = (String) request.getAttribute("currentQuantity");
			String itemId = (String) request.getAttribute("itemId");
			String thisQuantity = (String) request.getAttribute("thisQuantity");
			String currentCartId = (String) request.getAttribute("currentCartId");
			String priceEach=(String)request.getAttribute("priceEach");
			
			System.out.println("id " + id);
			System.out.println("currentQuantity " + currentQuantity);
			System.out.println("currentCartId " + currentCartId);
			System.out.println("itemId " + itemId);
			System.out.println("thisQuantity " + thisQuantity);
			System.out.println("priceEach " + priceEach);
			
			 database udatabase= new database();
			 udatabase.addToCartSql(currentQuantity,id,itemId,currentCartId,thisQuantity,priceEach);

		} catch (Exception e) {
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
