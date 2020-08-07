<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="models.users"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		try {
		String username = request.getParameter("username");
		String password = request.getParameter("password");		

		request.setAttribute("username", username);
		request.setAttribute("password", password);

		users uBean = new users();

		request.getRequestDispatcher("../loginValidation").include(request, response);
		uBean = (users) request.getAttribute("userData");

		if (uBean.getPassword() != null) {
			session.setAttribute("userData", uBean);
			response.sendRedirect("MainPage.jsp");
		} else {
			response.sendRedirect("Login.jsp");
		}
	} catch (Exception e) {
		response.sendRedirect("Login.jsp");
		e.printStackTrace();
	}
	%>
</body>
</html>
