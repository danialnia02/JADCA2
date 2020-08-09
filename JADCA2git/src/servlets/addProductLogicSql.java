package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import dbaccess.database;
import models.product;

/**
 * Servlet implementation class addProductLogicSql
 */
@WebServlet("/addProductLogicSql")
public class addProductLogicSql extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public addProductLogicSql() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		product NewProduct = (product) request.getAttribute("NewProduct");
		database udatabase = new database();
		try {
			udatabase.addProductLogic(NewProduct.getProductName(), NewProduct.getDescription(),
					NewProduct.getDetailDescription(), NewProduct.getRetailPrice(), NewProduct.getStockQuantity(),
					NewProduct.getCategoryName(), NewProduct.getImageLocation());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
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
