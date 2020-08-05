
<%@include file="./sqlQueries.jsp"%>

<%
try{
	Connection conn = DriverManager.getConnection(connURL);
	String id =(String) session.getAttribute("userId");
	String password = request.getParameter("username");
	String email= request.getParameter("email");
	
	String phoneNumber= request.getParameter("phoneNumber");
	String deliveryAddress= request.getParameter("deliveryAddress");
	String email= request.getParameter("email");
	String email= request.getParameter("email");	
	String email= request.getParameter("email");
	
	
	String role = request.getParameter("role");		
	String test = request.getParameter("test");
	
	if(test.equals("Delete")){		
		DeleteAccount(out,id,conn);		
	}else{
		
		UpdateAccount(out,id,role,conn);	
	}	
	conn.close();
	response.sendRedirect("RootPage.jsp");
}catch(Exception e){
	System.err.println("Error :" + e);
}
%>
