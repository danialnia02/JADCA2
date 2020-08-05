<%
try{	
	String id = (String)session.getAttribute("userid");	
	String username = request.getParameter("username");
	String email = request.getParameter("email");
	String phoneNumber = request.getParameter("phoneNumber");
	String deliveryAddress = request.getParameter("deliveryAddress");
	String postalCode= request.getParameter("postalCode");
	String paymentType= request.getParameter("paymentType");
	String cardNumber = request.getParameter("cardNumber");
	
	request.setAttribute("id",id);
	request.setAttribute("username",username);
	request.setAttribute("email",email);
	request.setAttribute("phoneNumber",phoneNumber);
	request.setAttribute("deliveryAddress",deliveryAddress);
	request.setAttribute("postalCode",postalCode);
	request.setAttribute("paymentType",paymentType);
	request.setAttribute("cardNumber",cardNumber);	
	
	
	System.out.println("here "+id);
	
	//UpdateCustomerProfile(out,id,username,email,conn);	
	response.sendRedirect("MainPage.jsp");
}catch(Exception e){
	System.err.println("Error :" + e);
}
%>
