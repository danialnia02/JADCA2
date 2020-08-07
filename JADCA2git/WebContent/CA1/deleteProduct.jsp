
<%@page import="java.sql.*"%>

<%
	String itemId = request.getParameter("itemId");
request.setAttribute("productId", itemId);
request.getRequestDispatcher("../deleteProductSql").include(request, response);
response.sendRedirect("MainPage.jsp");
%>