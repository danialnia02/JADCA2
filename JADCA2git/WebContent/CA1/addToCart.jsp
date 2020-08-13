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
	
	//check if the cart exists		
	
	request.getRequestDispatcher("../checkCartSql").include(request, response);
	ResultSet checkCartSql = (ResultSet) request.getAttribute("checkCartSql");	
	String currentCartId = "";

	try {
		checkCartSql.next();				
		currentCartId = checkCartSql.getString("cartId");
	} catch (Exception e) {
		//e.printStackTrace();				
		currentCartId = "null";
	}
	
	request.setAttribute("currentCartId",currentCartId);
	request.setAttribute("itemId",itemId);
	request.setAttribute("thisquantity",thisquantity);	
	request.setAttribute("priceEach",priceEach);	
	

	request.getRequestDispatcher("../addToCartSql").include(request, response);
	ResultSet addToCartSql = (ResultSet) request.getAttribute("addToCartSql");
	
	response.sendRedirect("MainPage.jsp");

} else {

}
%>

