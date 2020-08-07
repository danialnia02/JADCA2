<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="models.product"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Product Backend</title>
</head>
<body>
	<%@page import="java.sql.*"%>
	<%
		try {
		String productName = request.getParameter("productName");
		String description = request.getParameter("description");
		String DetailDescription = request.getParameter("DetailDescription");
		String Price = request.getParameter("Price");
		String Stock = request.getParameter("stock");
		String CategoryName= request.getParameter("CategoryName");
		String itemId = (String) session.getAttribute("itemId");
		String imgLocation = request.getParameter("image");
		System.out.println(CategoryName);
		
		product NewProduct = new product();
		NewProduct.setProductName(productName);
		NewProduct.setDescription(description);
		NewProduct.setDetailDescription(DetailDescription);
		NewProduct.setRetailPrice(Price);
		NewProduct.setStockQuantity(Stock);
		NewProduct.setCategoryName(CategoryName);
		NewProduct.setImageLocation(imgLocation);
		
		request.setAttribute("NewProduct",NewProduct);
		
		request.getRequestDispatcher("../addProductLogicSql").include(request, response);
				
		response.sendRedirect("MainPage.jsp");
	} catch (Exception e) {
		System.err.println("Err :" + e);
	}
	%>

</body>
</html>
