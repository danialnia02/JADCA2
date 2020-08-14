<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ page import="models.exchangeRates"%>
<!DOCTYPE html>

<%
	/* String currency =request.getParameter("currency");
String cardNumber=request.getParameter("cardNumber");

System.out.println(currency);
System.out.println(cardNumber); */

 exchangeRates test = new exchangeRates();
System.out.println(test.exchangeRates("SGD"));
%>

<html>
<head>
<meta charset="ISO-8859-1">
<title>testing page</title>
</head>
<body>
	<form action="../FileUpload" method="post" enctype="multipart/form-data">
	
		<input type="file" name="file"/>
		<input type="submit">
	</form>
</body>
</html>