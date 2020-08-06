package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dbaccess.database;
import dbaccess.users;

/**
 * Servlet implementation class UpdateCustomerProfileSQL
 */
@WebServlet("/UpdateCustomerProfileSQL")
public class UpdateCustomerProfileSQL extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateCustomerProfileSQL() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			users updatedAccount = (users) request.getAttribute("updatedAccount");			

			database udatabase = new database();

			udatabase.UpdateCustomerProfileSql(updatedAccount.getUserId(),updatedAccount.getPhoneNumber(), updatedAccount.getDeliveryAddress(), updatedAccount.getPostalCode(),
					updatedAccount.getPaymentType(), updatedAccount.getCardNumber());

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

