<%@page import="java.sql.*"%>

<%
	try {	
	
	String noItemsBuying = (String) session.getAttribute("noItemsBuying");
	System.out.println(noItemsBuying);

	String userid = (String) session.getAttribute("id");
	System.out.println("userid: "+userid);
	
	//get the number of items buying
	ResultSet res=getBuyingItemIds(out,userid,conn);
	
	res.next();
	int count=0;
	do{
		//save the item id as ItemId	
		int itemId=Integer.parseInt(res.getString("productId"));
		int ItemQuantity=Integer.parseInt(res.getString("itemQuantity"));
		
		//get the quantity for said item
		ResultSet rest=EditProduct(out,itemId,conn);
		rest.next();
		int StockQuantity=(Integer.parseInt(rest.getString("StockQuantity")));
				
		//code to update the product table for new quantity
			if (ItemQuantity < StockQuantity) {
				minusItem(out, ItemQuantity, itemId, conn);
			}
		count++;
	}while(res.next());

	//code to clear the cart
	Statement stmt = conn.createStatement();
	PreparedStatement pstmt = conn.prepareStatement("DELETE from cart where buyerId=?");
	pstmt.setInt(1, Integer.parseInt(userid));
	int number = pstmt.executeUpdate();
	if (number > 0)
		out.println(number + " records updated!");

	response.sendRedirect("MainPage.jsp");
} catch (Exception e) {
	System.err.println("Error :" + e);
}
%>

