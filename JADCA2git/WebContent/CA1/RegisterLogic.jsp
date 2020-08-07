<%@page import ="java.sql.*"%>
<%@page import="models.users" %>
<%
try{
	Class.forName("com.mysql.jdbc.Driver");	


	String username =  request.getParameter("username") ;
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	String phoneNumber = request.getParameter("phoneNumber");
	String deliveryAddress= request.getParameter("deliveryAddress");
	String postalCode = request.getParameter("postalCode");
	String paymentType = request.getParameter("paymentType");
	String cardNumber = request.getParameter("cardNumber");
	
	users newAccount = new users();
	newAccount.setUsername(username);
	newAccount.setEmail(email);
	newAccount.setPassword(password);
	newAccount.setPhoneNumber(phoneNumber);
	newAccount.setDeliveryAddress(deliveryAddress);
	newAccount.setPostalCode(postalCode);
	newAccount.setPaymentType(paymentType);
	newAccount.setCardNumber(cardNumber);
	newAccount.setRole("customer");
	
	
	request.setAttribute("newAccount",newAccount);	
	
	request.getRequestDispatcher("../RegisterLogic").include(request,response);
	boolean accountCreated = (boolean) request.getAttribute("RegisterLogicSql");
	if(accountCreated == true){
		response.sendRedirect("Login.jsp?errCode=true");
	}else{
		response.sendRedirect("Login.jsp?errCode=invalidLogin");  
	}
	
	conn.close();
 } catch (Exception e) {
 out.println("Error :" + e);
 }

%>