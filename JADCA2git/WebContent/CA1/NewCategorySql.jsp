<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>New Category SQL</title>
</head>
<link
	href="https://fonts.googleapis.com/css?family=Montserrat&display=swap"
	rel="stylesheet" />
<body style="background: #27282E">
	<%@include file="./Header.jsp"%>
	<%
	try{		
		Connection conn = DriverManager.getConnection(connURL);
		
		String newCategoryName= request.getParameter("CategoryName");
		String categoryNameid= request.getParameter("editCategoryID");
		String categoryName = request.getParameter("editCategoryName");
		String insertSql="", type="",categoryId="";		
		if(newCategoryName==null){
			type="Update";
			insertSql=categoryName;
			categoryId=categoryNameid;
			System.out.println("here"+categoryId);
		}else{
			type="Insert";
			insertSql=newCategoryName;
		}
		System.out.println(categoryId);
		CategorySql(out,type,insertSql,categoryId,conn);
		conn.close();
		response.sendRedirect("RootPage.jsp");
	}catch(Exception e){
		System.err.println("Error :" + e);
	}	
	%>
</html>