
<%@include file="./sqlQueries.jsp"%>

<%
try{
	Connection conn = DriverManager.getConnection(connURL);
	String id = request.getParameter("id");
	String password = request.getParameter("username");
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
