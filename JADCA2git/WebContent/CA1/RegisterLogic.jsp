<%@page import ="java.sql.*"%>
<%@include file="./sqlQueries.jsp" %>
<%
try{
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(connURL);


	String name =  request.getParameter("username") ;
	String email = request.getParameter("email");
	String password= request.getParameter("password");
	
	
	try{
		int number=RegisterLogic(out,name,email,password,conn);
		System.out.println(number);
		
		response.sendRedirect("Login.jsp?number="+ number);		
	}catch(Exception e){		
		System.out.println("Error :" + e);
		response.sendRedirect("Login.jsp?errCode=invalidLogin");
	}	
	
	conn.close();
 } catch (Exception e) {
 out.println("Error :" + e);
 }

%>