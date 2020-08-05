<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Product Backend</title>
</head>
<body>
	<%@page import="java.sql.*"%>
	<%@include file="./sqlQueries.jsp"%>
	<%
	try{
		String productName = request.getParameter("productName");
		String description = request.getParameter("description");
		String DetailDescription = request.getParameter("DetailDescription");
		String Price = request.getParameter("Price");
		String Stock = request.getParameter("stock");
		String ProductCategory = request.getParameter("ProductCategory");		
		String itemId= (String)session.getAttribute("itemId");
		String imgLocation =request.getParameter("image");
		
				
		Connection conn=DriverManager.getConnection(connURL);
		InsertProduct2(out,productName,description,DetailDescription,Price,Stock,ProductCategory,imgLocation,conn);
		conn.close();
		response.sendRedirect("MainPage.jsp");
	}catch(Exception e){
		System.err.println("Err :"+e);
	}
	%>

</body>
</html>
