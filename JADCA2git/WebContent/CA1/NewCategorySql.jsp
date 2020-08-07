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
		
		
		String newCategoryName= request.getParameter("CategoryName");
		String oldCategoryName= request.getParameter("OldCategoryName");				
		String type=(String) session.getAttribute("update");		
		System.out.println(type);
		
		request.setAttribute("newCategoryName",newCategoryName);
		request.setAttribute("type",type);
		request.setAttribute("oldCategoryName",oldCategoryName);
		request.getRequestDispatcher("../NewCategorySql").include(request, response);
		
		//response.sendRedirect("RootPage.jsp");
		
		
		
		
	}catch(Exception e){
		System.err.println("Error :" + e);
	}	
	%>
</html>