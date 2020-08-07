	<%@page import="java.sql.*"%>	
	<%@page import="models.product"%>
	<%
	try{
		String productName = request.getParameter("productName");
		String description = request.getParameter("description");
		String DetailDescription = request.getParameter("DetailDescription");
		String Price = request.getParameter("Price");
		String Stock = request.getParameter("stock");
		String categoryName = request.getParameter("categoryName");		
		String itemId= request.getParameter("itemId");
		String imgLocation = request.getParameter("image");		
		product updatedProduct= new product();
		
		updatedProduct.setProductId(itemId);
		updatedProduct.setProductName(productName);
		updatedProduct.setDescription(description);
		updatedProduct.setDetailDescription(DetailDescription);
		updatedProduct.setRetailPrice(Price);
		updatedProduct.setStockQuantity(Stock);
		updatedProduct.setCategoryName(categoryName);
		updatedProduct.setImageLocation(imgLocation);
		
		
		
		request.setAttribute("updatedProduct",updatedProduct);
		request.getRequestDispatcher("../EditProduct2Sql").include(request, response);		
		
		
		if((Boolean)session.getAttribute("role").equals("admin")){
			response.sendRedirect("MainPage.jsp"); 
		}else{
			response.sendRedirect("RootPage.jsp");
		}
		 
	}catch(Exception e){
		System.err.println("Err :"+e);
	}
	%>
