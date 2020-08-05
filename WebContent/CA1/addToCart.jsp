<%@page import="java.sql.*"%>
<%@ include file="sqlQueries.jsp"%>

<%
String id=(String)session.getAttribute("id");
String itemId=request.getParameter("itemId");
String thisquantity=request.getParameter("quantity");

if ((String) session.getAttribute("username") == null || (String) session.getAttribute("role") == null) {
	response.sendRedirect("Login.jsp");
}else{
try{
	Connection conn = DriverManager.getConnection(connURL);
	
	//check cart if item has already been added
	System.out.println(id +" "+ itemId);
	int currentQuantity=checkCart(out,id,itemId,conn);	
	
	System.out.println("here here"+currentQuantity);
	//add/update to the cart
	addToCartSql(out,currentQuantity,id,itemId,thisquantity,conn);	

	session.setAttribute("thisquantity",thisquantity);
	session.setAttribute("currentQuantity",Integer.toString(currentQuantity));	
	
	conn.close();
	response.sendRedirect("Cart.jsp");
}catch(Exception e){
	System.err.println("Error :" + e);
}
}

%>
