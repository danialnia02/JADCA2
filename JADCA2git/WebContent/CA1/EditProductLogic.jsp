
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
		String imgLocation = request.getParameter("image");
				
		Connection conn=DriverManager.getConnection(connURL);
		ResultSet rs = EditProduct2(out,productName,description,DetailDescription,Price,Stock,ProductCategory,imgLocation,itemId,conn);
		
		conn.close();
		if((Boolean)session.getAttribute("role").equals("admin")){
			response.sendRedirect("MainPage.jsp"); 
		}else{
			response.sendRedirect("RootPage.jsp");
		}
		 
	}catch(Exception e){
		System.err.println("Err :"+e);
	}
	%>
