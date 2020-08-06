package servlets;

import java.io.IOException;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dbaccess.database;
import dbaccess.product;

/**
 * Servlet implementation class EditProduct2Sql
 */
@WebServlet("/EditProduct2Sql")
public class EditProduct2Sql extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public EditProduct2Sql() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			product updatedProduct = (product) request.getAttribute("updatedProduct");
			database udatabase = new database();
			ResultSet rs = udatabase.EditProduct2(updatedProduct.getProductName(),updatedProduct.getDescription(),updatedProduct.getDetailDescription(),updatedProduct.getRetailPrice(),updatedProduct.getStockQuantity(),updatedProduct.getCategoryName(),updatedProduct.getImageLocation(),updatedProduct.getProductId());
			request.setAttribute("EditProduct2Sql", rs);
		}catch(Exception e) {
			System.out.println("here");
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
