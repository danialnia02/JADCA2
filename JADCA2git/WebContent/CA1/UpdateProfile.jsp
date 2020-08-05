
<%@include file="./sqlQueries.jsp"%>

<%
try{
	Connection conn = DriverManager.getConnection(connURL);
	String id = (String)session.getAttribute("userid");	
	String username = request.getParameter("username");
	String email = request.getParameter("email");
	System.out.println("here "+id);
	
	UpdateCustomerProfile(out,id,username,email,conn);
	conn.close();
	response.sendRedirect("MainPage.jsp");
}catch(Exception e){
	System.err.println("Error :" + e);
}
%>
