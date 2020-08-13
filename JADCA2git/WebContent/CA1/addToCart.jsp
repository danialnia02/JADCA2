<%@page import="java.sql.*"%>
<%@page import="models.users"%>

<%
	String itemId = request.getParameter("itemId");
//quantity in the shop
String thisquantity = request.getParameter("quantity");
//price of each Item;
String priceEach = (String) session.getAttribute("priceEach");

users userInfo = new users();
try {
	userInfo = (users) session.getAttribute("userData");
} catch (Exception e) {
	//e.printStackTrace();
	response.sendRedirect("Login.jsp");
}
String id = userInfo.getUserId();
String role = userInfo.getRole();
if (id != null || role != "customer") {

	request.setAttribute("id", userInfo.getUserId());
	request.setAttribute("itemId", itemId);

	//check wheter the item exists in the user's cart	
	
	request.getRequestDispatcher("../checkCartSql").include(request, response);
	ResultSet checkCartSql = (ResultSet) request.getAttribute("checkCartSql");
	System.out.println("here");
	String quantity = "";
	String currentCartId = "";
	//if it is existing in the current cart

	try {
		checkCartSql.next();
		//quantity in the database
		quantity = checkCartSql.getString("itemQuantity");
		currentCartId = checkCartSql.getString("cartId");

	} catch (Exception e) {
		//e.printStackTrace();		
		quantity = "0";
		currentCartId = "null";

	}

	request.setAttribute("id", id);
	request.setAttribute("currentQuantity", quantity);
	request.setAttribute("itemId", itemId);
	request.setAttribute("thisQuantity", thisquantity);
	request.setAttribute("currentCartId", currentCartId);
	request.setAttribute("priceEach",priceEach);

	request.getRequestDispatcher("../addToCartSql").include(request, response);
	ResultSet addToCartSql = (ResultSet) request.getAttribute("addToCartSql");
	
	response.sendRedirect("MainPage.jsp");

} else {

}
%>

