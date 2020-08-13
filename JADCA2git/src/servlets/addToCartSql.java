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
		database udatabase= new database();
		try {
			//var to see if cart exists or not
			String addToCartBefore=(String)request.getAttribute("currentCartId");
			String productId=(String)request.getAttribute("itemId");
			String thisquantity=(String)request.getAttribute("thisquantity");
			String id=(String) request.getAttribute("id");
			String priceEach =(String) request.getAttribute("priceEach");
						
			if (addToCartBefore == "null") {
				//check is cart exists
				System.out.println("cart doesnt exists");
				udatabase.addToCartSql(id, productId, thisquantity, priceEach);
			}else {				
				//cart exists
				System.out.println("cart exists");
				//check if item exists in the cart
				 ResultSet rs2 = udatabase.checkItemInCart(productId,addToCartBefore);				 				 
				 rs2.next();
				 String currentCartId="";
				 String oldQuantity="";
				 try {
					 currentCartId =rs2.getString("cartId");					 					 
				 }catch(Exception e) {
					 currentCartId="null";					 					 
				 }
				 try {
					 oldQuantity = rs2.getString("itemQuantity");
				 }catch(Exception e) {
					 oldQuantity="null";					 
				 }
				 System.out.println(currentCartId);
				 if(currentCartId.equals("null")) {
					 //item doesnt exist in cart (insert)					 
					 udatabase.insertIntoCartNull(addToCartBefore,productId,thisquantity,priceEach);					 
				 }else {
					 //item exists in the cart (update)
					 int newQuantity = Integer.parseInt(thisquantity)+Integer.parseInt(oldQuantity);
					 udatabase.updateProductInCart(currentCartId,productId,newQuantity,priceEach);
				 }								
			}					

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
