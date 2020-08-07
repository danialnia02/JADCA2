package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dbaccess.database;
import java.sql.*;
import models.users;

/**
 * Servlet implementation class RegisterLogic
 */
@WebServlet("/RegisterLogic")
public class RegisterLogic extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterLogic() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		users newAccount = (users)request.getAttribute("newAccount");
		try {
			String username = newAccount.getUsername();
			String email= newAccount.getEmail();
			String password = newAccount.getPassword();
			String phoneNumber = newAccount.getPhoneNumber();
			String deliveryAddress = newAccount.getDeliveryAddress();
			String postalCode = newAccount.getPostalCode();
			String paymentType = newAccount.getPaymentType();
			String cardNumber = newAccount.getCardNumber();
			
						
			database udatabase = new database();
			boolean accountCreated =udatabase.RegisterLogic(username,email,password,phoneNumber,deliveryAddress,postalCode,paymentType,cardNumber);			
			request.setAttribute("RegisterLogicSql",accountCreated);
			
		}catch(Exception e) {			
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
