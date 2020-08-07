<%@page import="models.users"%>

<%
try{	
	
	users newAccount = new users();
	String id = (String) session.getAttribute("userId");		
	String phoneNumber = request.getParameter("phoneNumber");
	String deliveryAddress = request.getParameter("deliveryAddress");
	String postalCode= request.getParameter("postalCode");
	String paymentType= request.getParameter("paymentType");
	String cardNumber = request.getParameter("cardNumber");
	
	newAccount.setUserId(id);
	newAccount.setPhoneNumber(phoneNumber);
	newAccount.setDeliveryAddress(deliveryAddress);
	newAccount.setPostalCode(postalCode);
	newAccount.setPaymentType(paymentType);
	newAccount.setCardNumber(cardNumber);
	
	request.setAttribute("updatedAccount",newAccount);
	
	
	request.getRequestDispatcher("../UpdateCustomerProfileSQL").include(request, response);	
	
	session.invalidate();
	response.sendRedirect("MainPage.jsp?logout=trues");
}catch(Exception e){
	System.out.println("Error updating Account");
	e.printStackTrace();
}
%>
