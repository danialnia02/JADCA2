<%@page import="java.sql.*"%>
<%@page import="models.users"%>

<%
	try {
	users userInfo = (users) session.getAttribute("userData");
	String userid = userInfo.getUserId();
	String ccNumber = request.getParameter("ccNumber");
	String currency=request.getParameter("currency");	
	
	if(ccNumber.length() <16){
		response.sendRedirect("PaymentPage.jsp?errCode=not16");
	}
	boolean ccValid = creditCardCheck(ccNumber);
	

	if (ccValid == false) {		
		response.sendRedirect("PaymentPage.jsp?errCode=InvalidCard");
	} else {

 		//get the number of items buying
		request.setAttribute("userId", userid);
		request.getRequestDispatcher("../getBuyingItemIds").include(request, response);
		ResultSet getBuyingItemIds = (ResultSet) request.getAttribute("getBuyingItemIds");

		int count = 0;
		String cartId = "";
		while (getBuyingItemIds.next()) {
	//save the item id as ItemId	
	int productId = Integer.parseInt(getBuyingItemIds.getString("productId"));
	int itemQuantity = Integer.parseInt(getBuyingItemIds.getString("itemQuantity"));
	cartId = getBuyingItemIds.getString("cartId");

	request.setAttribute("itemId", Integer.toString(productId));

	//get the quantity for said item in product table		
	request.getRequestDispatcher("../EditProductSQL").include(request, response);
	ResultSet rest = (ResultSet) request.getAttribute("EditProductSQL");
	rest.next();
	int StockQuantity = (Integer.parseInt(rest.getString("StockQuantity")));

	//code to update the product table for new quantity
	if (itemQuantity < StockQuantity) {

		request.setAttribute("productId", productId);
		request.setAttribute("itemQuantity", itemQuantity);
		request.getRequestDispatcher("../minusItemSql").include(request, response);

	}
	count++;
		}
		;

		//code to change the cart of the user to bought
		request.setAttribute("userId", userid);
		request.setAttribute("cartId", cartId);
		request.getRequestDispatcher("../changeToBoughtSql").include(request, response);

		response.sendRedirect("MainPage.jsp"); 
	}
} catch (Exception e) {
	System.err.println("Error :" + e);
}
%>

<%!public static boolean creditCardCheck(String number) {
		int sum = 0;
		boolean alternate = false;
		for (int i = number.length() - 1; i >= 0; i--) {
			int n = Integer.parseInt(number.substring(i, i + 1));
			if (alternate) {
				n *= 2;
				if (n > 9) {
					n = (n % 10) + 1;
				}
			}
			sum += n;
			alternate = !alternate;
		}

		return (sum % 10 == 0);
	}%>