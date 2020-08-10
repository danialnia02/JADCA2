<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>

<%
users userData = (users) session.getAttribute("userData");
session.setAttribute("userData", userData);

try {
if (userData.getRole() == null || userData.getRole().equals("customer")) {

	response.sendRedirect("MainPage.jsp");
} else if(userData.getRole().equals("admin")) {
	%> <%@ include file="Header.jsp"%> <% 
} else {
	%> <%@ include file="RootHeader.jsp"%> <% 
}
} catch (Exception e) {
response.sendRedirect("MainPage.jsp");
}
%>
<body>

</body>
</html>