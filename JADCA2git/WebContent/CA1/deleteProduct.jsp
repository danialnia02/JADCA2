
    <%@page import="java.sql.*"%>
    <%@ include file="sqlQueries.jsp" %>

	<%  
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection(connURL);
		String number =request.getParameter("itemId");		
		

    	String sql = "DELETE FROM product where productId = ?";
    	PreparedStatement prest = conn.prepareStatement(sql);
    	prest.setInt(1, Integer.parseInt(number));
    	int del = prest.executeUpdate();
    	System.out.println("Number of deleted records: " + del);
    	conn.close();
    	if((Boolean)session.getAttribute("role").equals("root")){
			response.sendRedirect("RootPage.jsp");
		}else{
			response.sendRedirect("MainPage.jsp");	
		}
    	    	
    		

	%>
