<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@include file="./sqlConnection.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>This page will hold all of the sql queries</title>
</head>
<body>
	<!-- Code for loginValidation Page -->
	<%
		Class.forName("com.mysql.jdbc.Driver");
	%>
	<%!public ResultSet loginValidation(JspWriter out, String username, String password, Connection conn)
				throws java.io.IOException {
			try {

				Statement stmt = conn.createStatement();
				
				
				PreparedStatement pstmt = conn
						.prepareStatement("SELECT * FROM jaeproject.user WHERE username=? AND password=?");
				pstmt.setString(1, username);
				pstmt.setString(2, password);
				
				ResultSet rs = pstmt.executeQuery();
				
				String sql="{call loginValidation(?,?)}";
				CallableStatement cs=conn.prepareCall(sql);
				cs.setString(1,username);
				cs.setString(2,password);

				ResultSet rs2 = cs.executeQuery();

				return rs;
			} catch (Exception e) {
				System.err.println("Error :" + e);
			}
			return null;
		}%>


	<!--  Code for MainPage -->
	<%!public ResultSet MainPageSql(JspWriter out, String category, Connection conn) throws java.io.IOException {

			try {

				Statement stmt = conn.createStatement();
				PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM product WHERE `productCategory` = ? ");
				pstmt.setString(1, category);

				ResultSet rs = pstmt.executeQuery();
				
				
				return rs;
			} catch (Exception e) {
				System.err.println("Error :" + e);
			}
			return null;
		}%>
	<!-- Code for cartFunction -->

	<%!public ResultSet cartFunctionSql(JspWriter out, String category, Connection conn) throws java.io.IOException {

	try {

		Statement stmt = conn.createStatement();
		PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM product WHERE `productCategory` = ? ");
		pstmt.setString(1, category);
		category = "Viewing " + category + " products";

		ResultSet rs = pstmt.executeQuery();
		return rs;
	} catch (Exception e) {
		System.err.println("Error :" + e);
	}
	return null;
}%>
<!-- Code for cart -->

	<%!public ResultSet ItemsBuying(JspWriter out, String userId, Connection conn) throws java.io.IOException {

	try {

		Statement stmt = conn.createStatement();
		PreparedStatement pstmt = conn.prepareStatement("select count(*) as 'itemsBuying' from cart where buyerId=? ");
		pstmt.setString(1, userId);		

		ResultSet rs = pstmt.executeQuery();
		return rs;
	} catch (Exception e) {
		System.err.println("Error :" + e);
	}
	return null;
}%>
	<!-- Code for ListProduct -->
	<%!public ResultSet ListProductSql(JspWriter out, String category, Connection conn) throws java.io.IOException {
		
		try {

			PreparedStatement ptsmt = null;
			if (category.equals("nothing")) {
				ptsmt = conn.prepareStatement("SELECT * FROM product");
			} else {

				ptsmt = conn.prepareStatement("SELECT * FROM product WHERE `productCategory` = ? ");
				ptsmt.setString(1, category);
			}
						
			ResultSet rs = ptsmt.executeQuery();
			return rs;
		} catch (Exception e) {
			System.err.println("Error :" + e);
		}
		return null;
	}%>		
	<!-- Code for Header -->
	<%!public ResultSet HeaderSql(JspWriter out, Connection conn) throws java.io.IOException {

		try {

			Statement stmt = conn.createStatement();
			PreparedStatement ptsmt;
			ptsmt = conn.prepareStatement("SELECT DISTINCT CategoryName FROM productcategory");

			ResultSet rs = ptsmt.executeQuery();
			return rs;
		} catch (Exception e) {
			System.err.println("Error :" + e);
		}
		return null;
	}%>
	
	<!-- Code for Search -->
	<%!public ResultSet Search(JspWriter out, String input, Connection conn) throws java.io.IOException {

		try {
			
			Statement stmt = conn.createStatement();
			PreparedStatement ptsmt;
			ptsmt = conn.prepareStatement("SELECT * FROM product WHERE ProductName like ? ");
			ptsmt.setString(1, "%" + input + "%");

			

			ResultSet rs = ptsmt.executeQuery();
			return rs;
		} catch (Exception e) {
			System.err.println("here Error :" + e);
		}
		return null;
	}%>
	<!-- Code for Cart Page -->
	<%!public ResultSet CartSql(JspWriter out, String id, Connection conn) throws java.io.IOException {
		int ids = Integer.parseInt(id);

		try {

			Statement stmt = conn.createStatement();
			PreparedStatement ptsmt;
			ptsmt = conn.prepareStatement("SELECT p.ImageLocation, p.productID,p.ProductName,p.Retailprice, c.itemQuantity from product p inner join "
					+ "cart c on p.productId=c.productId where c.buyerId = ? ");
			ptsmt.setInt(1, ids);
			ResultSet rs = ptsmt.executeQuery();
			return rs;
		} catch (Exception e) {
			System.err.println("Error :" + e);
		}
		return null;
	}%>	
	<!-- Code for EditProduct Page -->
	<%!public ResultSet EditProduct(JspWriter out, int id, Connection conn) throws java.io.IOException {		

		try {
			
			Statement stmt = conn.createStatement();
			PreparedStatement ptsmt;
			ptsmt = conn.prepareStatement("SELECT * from product where `productId` = ? ");
			ptsmt.setInt(1, id);			
			ResultSet rs = ptsmt.executeQuery();
			return rs;
		} catch (Exception e) {
			System.err.println("Error: " + e);
		}
		return null;
	}%>
	<!-- Code for EditProduct2 Page -->
	<%!public ResultSet EditProduct2(JspWriter out, String productName, String Description, String DetailDescription,
			String price, String Stock, String ProductCategory, String ImageLocation, String itemId, Connection conn)
			throws java.io.IOException {

		try {
			Statement stmt = conn.createStatement();
			PreparedStatement ptsmt;
			ptsmt = conn.prepareStatement(
					"Update product set ProductName= ?,Description =?,DetailDescription =?,CostPrice =?,RetailPrice =?,StockQuantity =?,ProductCategory =?,ImageLocation =? where productId=?");
			ptsmt.setString(1, productName);
			ptsmt.setString(2, Description);
			ptsmt.setString(3, DetailDescription);
			ptsmt.setFloat(4, Float.parseFloat(price));
			ptsmt.setFloat(5, Float.parseFloat(price));
			ptsmt.setInt(6, Integer.parseInt(Stock));
			ptsmt.setString(7, ProductCategory);
			ptsmt.setString(8, ImageLocation);
			ptsmt.setInt(9, Integer.parseInt(itemId));
			int number = ptsmt.executeUpdate();
			
			if (number > 0)
				out.println(number + " records updated!");

		} catch (Exception e) {
			System.err.println("Error :" + e);
		}
		return null;
	}%>
	<!-- Code for InsertProduct Page -->
	<%!public void InsertProduct2(JspWriter out, String productName, String Description, String DetailDescription,
			String price, String Stock, String ProductCategory, String ImageLocation, Connection conn)
			throws java.io.IOException {

		try {
			Statement stmt = conn.createStatement();
			PreparedStatement ptsmt;
			ptsmt = conn.prepareStatement(
					"INSERT INTO product (ProductName,Description,DetailDescription,CostPrice,RetailPrice,StockQuantity,ProductCategory,ImageLocation) values(?,?,?,?,?,?,?,?)");
			ptsmt.setString(1, productName);
			ptsmt.setString(2, Description);
			ptsmt.setString(3, DetailDescription);
			ptsmt.setFloat(4, Float.parseFloat(price));
			ptsmt.setFloat(5, Float.parseFloat(price));
			ptsmt.setInt(6, Integer.parseInt(Stock));
			ptsmt.setString(7, ProductCategory);
			ptsmt.setString(8, ImageLocation);
			int number = ptsmt.executeUpdate();
			if (number > 0)
				out.println(number + " records inserted");

		} catch (Exception e) {
			System.err.println("Error :" + e);
		}
	}%>	
	
	<!-- Code for insertIntoCart -->

	<%!public int checkCart(JspWriter out,String id,String itemId, Connection conn) throws java.io.IOException {
	try {
		Statement stmt = conn.createStatement();
		PreparedStatement pstmt = conn.prepareStatement("Select * from cart where buyerId=? and productId=?");			
		pstmt.setInt(1, Integer.parseInt(id));
		pstmt.setInt(2, Integer.parseInt(itemId));		
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		int quantity= Integer.parseInt(rs.getString("itemQuantity"));

		if(quantity>0){
			return quantity;
		}		
		
	} catch (Exception e) {
		System.err.println("Error :" + e);
	}	
	return 0;
}%>
<!-- Code for insertIntoCart -->

	<%!public void addToCartSql(JspWriter out,int currentQuantity,String id,String itemId,String quantity, Connection conn) throws java.io.IOException {
	try {
		Statement stmt = conn.createStatement();
		PreparedStatement pstmt=null;
		if(currentQuantity>0){
			pstmt = conn.prepareStatement("update cart set itemQuantity= itemQuantity + ? where buyerId=? and productId=?");		
			pstmt.setInt(1, Integer.parseInt(quantity));
			pstmt.setInt(2, Integer.parseInt(id));
			pstmt.setInt(3, Integer.parseInt(itemId));
			
		}else{
			pstmt = conn.prepareStatement("Insert into cart (buyerId,productId,itemQuantity) values(?,?,?)");		
			pstmt.setString(1, id);
			pstmt.setInt(2, Integer.parseInt(itemId));
			pstmt.setInt(3, Integer.parseInt(quantity));
		}
		
		int number = pstmt.executeUpdate();
		if (number > 0)
			out.println(number + " records updated!");
	} catch (Exception e) {
		System.err.println("Error :" + e);
	}	
}%>
	<!-- Code for RootPage Page -->
	<%!public ResultSet updateRole(JspWriter out, String username, String email, String password, String role,
			Connection conn) throws java.io.IOException {

		try {
			Statement stmt = conn.createStatement();
			PreparedStatement ptsmt;
			ptsmt = conn.prepareStatement("UPDATE user set username=?, email=?, password=? , role=?");
			ptsmt.setString(1, username);
			ptsmt.setString(2, email);
			ptsmt.setString(3, password);
			ptsmt.setString(4, role);
			ResultSet rs = ptsmt.executeQuery();
			return rs;
		} catch (Exception e) {
			System.err.println("Error :" + e);
		}
		return null;
	}%>
	<!-- Code for RootPage -->
	<%!public ResultSet GetRoles(JspWriter out, Connection conn) throws java.io.IOException {

		try {

			Statement stmt = conn.createStatement();
			PreparedStatement ptsmt;
			ptsmt = conn.prepareStatement("SELECT DISTINCT role FROM user");
			ResultSet rs = ptsmt.executeQuery();
			return rs;
		} catch (Exception e) {
			System.err.println("Error :" + e);
		}
		return null;
	}%>
	<!-- Code for RootPage -->
	<%!public ResultSet IndividualAccount(JspWriter out, Connection conn) throws java.io.IOException {

		try {

			Statement stmt = conn.createStatement();
			PreparedStatement ptsmt;
			ptsmt = conn.prepareStatement("SELECT * FROM user");
			ResultSet rs = ptsmt.executeQuery();
			return rs;
		} catch (Exception e) {
			System.err.println("Error :" + e);
		}
		return null;
	}%>
	<!-- Code for Profile -->
	<%!public ResultSet getAccountInfo(JspWriter out,String userId, Connection conn) throws java.io.IOException {

		try {

			Statement stmt = conn.createStatement();
			PreparedStatement ptsmt;
			ptsmt = conn.prepareStatement("SELECT * FROM user where id=?");
			ptsmt.setInt(1,Integer.parseInt(userId));
			ResultSet rs = ptsmt.executeQuery();
			return rs;
		} catch (Exception e) {
			System.err.println("Error :" + e);
		}
		return null;
	}%>
	<!-- Code for RootPage -->
	<%!public void UpdateAccount(JspWriter out,String id, String role, Connection conn) throws java.io.IOException {		
		try {

			Statement stmt = conn.createStatement();
			PreparedStatement ptsmt;
			ptsmt = conn.prepareStatement("Update user set role=? where id=?");
			ptsmt.setString(1,role);
			ptsmt.setInt(2,Integer.parseInt(id));			
			int number = ptsmt.executeUpdate();
			if (number > 0)
				out.println(number + " records updated!");			
		} catch (Exception e) {
			System.err.println("Error :" + e);
		}		
		//select count(distinct role) as 'total_no_of_rows' from user
	}%>
	<!-- Code for UpdateProfile -->
	<%!public void UpdateCustomerProfile(JspWriter out,String id,String username, String email, Connection conn) throws java.io.IOException {		
		try {

			Statement stmt = conn.createStatement();
			PreparedStatement ptsmt;
			ptsmt = conn.prepareStatement("Update user set username=?, email=? where id=?");
			ptsmt.setString(1,username);
			ptsmt.setString(2,email);
			ptsmt.setInt(3,Integer.parseInt(id));	
			System.out.println(ptsmt);
			int number = ptsmt.executeUpdate();
			if (number > 0)
				out.println(number + " records updated!");			
		} catch (Exception e) {
			System.err.println("Error :" + e);
		}		
		//select count(distinct role) as 'total_no_of_rows' from user
	}%>
	<!-- Code for RootPage -->
	<%!public ResultSet getNoOfDistinctRoles(JspWriter out, Connection conn) throws java.io.IOException {		
		try {

			Statement stmt = conn.createStatement();
			PreparedStatement ptsmt;
			ptsmt = conn.prepareStatement("select count(distinct role) as 'total_no_of_rows' from user");						
			ResultSet rs = ptsmt.executeQuery();
			return rs;
		} catch (Exception e) {
			System.err.println("Error :" + e);
		}		
		return null;		
	}%>
	<!-- Code for RootPage -->
	<%!public void DeleteAccount(JspWriter out,String id, Connection conn) throws java.io.IOException {		
		try {

			Statement stmt = conn.createStatement();
			PreparedStatement ptsmt;
			ptsmt = conn.prepareStatement("Delete from user where id=?");			
			ptsmt.setInt(1,Integer.parseInt(id));			
			int number = ptsmt.executeUpdate();
			if (number > 0)
				out.println(number + " records updated!");			
		} catch (Exception e) {
			System.err.println("Error :" + e);
		}				
	}%>	
	<!-- Code for RootPage -->
	<%!public ResultSet getColumnNames(JspWriter out, Connection conn) throws java.io.IOException {		
		try {

			Statement stmt = conn.createStatement();
			PreparedStatement ptsmt;
			ptsmt = conn.prepareStatement("SELECT COLUMN_NAME 'Column' FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA ='jaeproject' AND TABLE_NAME = 'product' ORDER BY ORDINAL_POSITION");			
			ResultSet rs = ptsmt.executeQuery();
			return rs;
		} catch (Exception e) {
			System.err.println("Error :" + e);
		}		
		return null;	
	}%>	
	<!-- Code for RootPage -->
	<%!public ResultSet getCategoryNames(JspWriter out, Connection conn) throws java.io.IOException {		
		try {

			Statement stmt = conn.createStatement();
			PreparedStatement ptsmt;
			ptsmt = conn.prepareStatement("select * from productcategory");	
			ResultSet rs = ptsmt.executeQuery();	
			
			String sql="{call getAllCategory()}";
			CallableStatement cs=conn.prepareCall(sql);

			ResultSet rs2 = cs.executeQuery();
			
			return rs2;
		} catch (Exception e) {
			System.err.println("Error :" + e);
		}		
		return null;	
	}%>		
		<!-- Code for RootPage Page -->
	<%!public void CategorySql(JspWriter out,String type, String categoryName,String categoryId, Connection conn)
			throws java.io.IOException {

		try {
			Statement stmt = conn.createStatement();
			
			String sqlQuery="";
			if(type=="Insert"){
				sqlQuery = "INSERT INTO productcategory(CategoryName) values('"+categoryName+"') ";				
			}else if(type=="Update"){				
				sqlQuery ="UPDATE productcategory set CategoryName= '"+categoryName+"' where categoryID="+categoryId;				
			}
			PreparedStatement ptsmt=conn.prepareStatement(sqlQuery);
			System.out.println(ptsmt);
			int number = ptsmt.executeUpdate();
			if (number > 0)
				out.println(number + " records inserted");

		} catch (Exception e) {
			System.err.println("Error :" + e);
		}
	}%>	
	<!-- Code for BuyItem -->

	<%!public void minusItem(JspWriter out,int quantity,int itemId, Connection conn) throws java.io.IOException {
	try {
		Statement stmt = conn.createStatement();
		PreparedStatement pstmt = conn.prepareStatement("update product set StockQuantity= StockQuantity - ? where productId=?");			
		pstmt.setInt(1, quantity);
		pstmt.setInt(2, itemId);		
		int number = pstmt.executeUpdate();
		if (number > 0)
			out.println(number + " records updated!");
		
	} catch (Exception e) {
		System.err.println("Error :" + e);
	}		
}%>
<!-- Code for BuyItem -->

	<%!public ResultSet getBuyingItemIds(JspWriter out,String id,Connection conn) throws java.io.IOException {
	try {
		Statement stmt = conn.createStatement();
		PreparedStatement pstmt = conn.prepareStatement("Select * from cart where buyerId=?");			
		pstmt.setInt(1, Integer.parseInt(id));			
		ResultSet rs = pstmt.executeQuery();		
		return rs;
	} catch (Exception e) {
		System.err.println("Error :" + e);
	}	
	return null;
}%>
	<!-- Code for ProductDetail -->
	<%!public ResultSet getQuantityInCart(JspWriter out,String id,String itemId, Connection conn) throws java.io.IOException {		
		try {

			Statement stmt = conn.createStatement();
			PreparedStatement ptsmt;
			ptsmt = conn.prepareStatement("Select itemQuantity from cart where productId=? and buyerId=?");			
			ptsmt.setInt(1,Integer.parseInt(itemId));
			ptsmt.setInt(2,Integer.parseInt(id));						
			ResultSet rs = ptsmt.executeQuery();
			return rs;
				
		} catch (Exception e) {
			System.err.println("Error :" + e);
		}		
		return null;
	}%>
	<!-- Code for RegisterLogic Page -->
	<%!public int RegisterLogic(JspWriter out,String username, String email,String password, Connection conn)
			throws java.io.IOException {	

		try {			
			PreparedStatement pstmt;
			pstmt = conn.prepareStatement("Insert into user (username,email,password,role) values(?,?,?,'customer')");		
			pstmt.setString(1, username);			
			pstmt.setString(2, email);
			pstmt.setString(3, password);
			
		int number = pstmt.executeUpdate();
		if (number > 0) 
			out.println(number + " records updated!");
		return number;
		} catch (Exception e) {
			System.err.println("Error :" + e);
		}
		return 0;
	}%>	
		
</body>
</html>
