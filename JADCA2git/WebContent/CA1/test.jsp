<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	
<%@ page import="models.exchangeRates"%>
<!DOCTYPE html>

<%
exchangeRates test = new exchangeRates();
System.out.println(test.exchangeRates("USD"));

%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html>