<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@ include file="sqlQueries.jsp"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" type="text/css" href="./css/Cart.css">
<head>
<meta charset="ISO-8859-1">
<title>Cart</title>
</head>
<body>
	<h1 class=backButton><a href="MainPage.jsp" style="color:white; text-decoration:none;">
	<svg xmlns="http://www.w3.org/2000/svg" x="0px" y="0px"
	width="26" height="26" viewBox="0 0 172 172"style=" fill:#000000;">
	<g fill="none" fill-rule="nonzero" stroke="none" stroke-width="1" stroke-linecap="butt" stroke-linejoin="miter" stroke-miterlimit="10" stroke-dasharray="" stroke-dashoffset="0" font-family="none" font-weight="none" font-size="none" text-anchor="none" style="mix-blend-mode: normal"><path d="M0,172v-172h172v172z" fill="none"></path><g fill="#ffffff"><path d="M70.08173,86l56.79928,-57.98798c2.53245,-2.58413 2.50661,-6.71875 -0.05169,-9.30288l-10.15565,-10.15565c-2.60997,-2.58413 -6.79628,-2.58413 -9.38041,0.02584l-72.27824,72.74339c-1.29207,1.29206 -1.9381,2.97176 -1.9381,4.67728c0,1.70553 0.64603,3.38522 1.9381,4.67728l72.27824,72.74339c2.58413,2.60997 6.77044,2.60997 9.38041,0.02584l10.15565,-10.15565c2.55829,-2.58413 2.58413,-6.71875 0.05169,-9.30288z"></path></g></g></svg>
	Back</a></h1>

	<%
	
	if((String)session.getAttribute("role")==null
    ||(Boolean)session.getAttribute("role").equals("root")){

    response.sendRedirect("MainPage.jsp");
}
	
	String username = null;
	String role = null;	 
	username = (String) session.getAttribute("username");
	role = (String) session.getAttribute("role");
	String id = (String) session.getAttribute("userid");
	
	
	String thisquantity = (String) session.getAttribute("thisquantity");
	String currentQuantity = (String) session.getAttribute("currentQuantity");
	int itemsBuying=ItemsBuying(out,id);	
	session.setAttribute("noItemsBuying",Integer.toString(itemsBuying));
	session.setAttribute("id",id);	
	%>
	
	<div style="display: flex;">
		<div id="productCol">
			<% itemCart(out,id); %>
			
		</div>

		<div class="container">
			<div class="cartHeader">
				Cart Summary
			</div>
			<%
				totalPrice(out, id);
			%>
			<div style="display:block; width:100%;">
			<a href="BuyItem.jsp" class="checkoutBtn"><b>Checkout</b></a>
			</div>
		</div>
 
	</div>

</body>
<!-- return the total number -->
<%!public int CartNumberItems(JspWriter out, String id) throws java.io.IOException {
		try {
			Connection conn = DriverManager.getConnection(connURL);
			ResultSet rs = CartSql(out, id, conn);
			int totalproducts=0;
			rs.next();
			do{
				totalproducts+=(Integer.parseInt(rs.getString("itemQuantity")));
			}while(rs.next());
			conn.close();
			
			return totalproducts;
		} catch (Exception e) {
			System.err.println("Error : " + e);
		}
	return 0;
	}%>
<!--  Get the total number of id of buying items -->
<%!public int ItemsBuying(JspWriter out, String userId) throws java.io.IOException {
		try {
			Connection conn = DriverManager.getConnection(connURL);
			ResultSet rs = ItemsBuying(out, userId, conn);
			int itemsBuying=0;
			rs.next();		
			itemsBuying=Integer.parseInt(rs.getString("ItemsBuying"));
			conn.close();
			return itemsBuying;
		} catch (Exception e) {
			System.err.println("Error : " + e);
		}
	return 0;
	}%>
	
<%!public void totalPrice(JspWriter out, String id) throws java.io.IOException {
	try {
		Connection conn = DriverManager.getConnection(connURL);
		ResultSet rs = CartSql(out, id, conn);
		rs.next();
		double totalPrice = 0;
		int totalProducts=CartNumberItems(out,id);
		
		do {
			totalPrice += (Double.parseDouble(rs.getString("RetailPrice"))*Double.parseDouble(rs.getString("itemQuantity")));
			
		} while (rs.next());
			out.print("<div class=totalQuantityRow>");
			out.print("<h3 class=totalQuantityText>Total Quantity</h3>");
			out.print("<div class=totalQuantity>"+totalProducts+"</div>");
			out.print("</div>");
		
			out.print("<div class=priceRow>");
			out.print("<h3 class=priceText>Total Price</h3>");
			out.print("<div class='price'>$"+totalPrice+"</div>");
			out.print("</div>");
			
		conn.close();
	} catch (Exception e) {
		System.err.println("Error : " + e);
	}
}%>

<%!public void itemCart(JspWriter out, String id) throws java.io.IOException {
	try {
		Connection conn = DriverManager.getConnection(connURL);
		ResultSet rs = CartSql(out, id, conn);
		rs.next();
		float totalprice = 0;
		int totalproducts=0;
		
		do {
					
			out.print("<div id='productContainer'>"
						+"<img src='"+rs.getString("ImageLocation")+"'>"
						+ "<div style='flex-basis: 25%; margin: 2%;'>"+ rs.getString("ProductName") +"</div>"
						+ "<div style='flex-basis: 5%; margin: 5%;'>"
						+ "Qty:"+rs.getString("itemQuantity")
						+ "</div>"
						+ "<div style='flex-basis: 20%; align-content: flex-end;'>Price:$"+(Double.parseDouble(rs.getString("RetailPrice"))*Double.parseDouble(rs.getString("itemQuantity")))
						+"</div>"
						+ "</div>");
			
		} while (rs.next());
		conn.close();
		} catch (Exception e) {
			System.err.println("Error : " + e);
		}
	}%>
<style>
body {
    margin: 0;
    padding: 0;
    font-family: 'Montserrat', sans-serif;
    background: #27282e;
}
#productContainer {
    margin: 0 auto;
    height: 75px;
    width: 70%;
    display: flex;
    flex-direction: row;
    background: #494A4F;
    margin-top: 1%;
    align-items: center;
}

#productCol {
	width:100%;
	display:flex;
	flex-direction:column;
	margin-top:4%;
}
#productContainer div:last-child {
    margin-left: auto;
}
#productContainer div {
    color: white;
}
#productContainer img {
    max-width: 100%;
    max-height: 100%;
}
.row {
    display: -ms-flexbox; /* IE10 /
    display: flex;
    -ms-flex-wrap: wrap; / IE10 /
    flex-wrap: wrap;
    margin: 0 -16px;
}
.col-25 {
    -ms-flex: 25%; / IE10 */
    flex: 25%;
}
.col-25 {
    padding: 0 16px;
}
.container {
	width:30%;
    display: block;
    float: right;
    margin: 5%;
    background-color: #161618;

}

.totalQuantityRow{
	display:flex;
	justify-content: space-between;
	margin:10px;
}

.totalQuantityText{
	color:white;
	margin:0;
}

.totalQuantity{
	color:white;
}

.cartHeader{
	padding:10px;
	background:#494A4F;
	color:#E3DBD2;
	font-size:1.5rem;
}

.price{
	color:white;
}

.priceText{
	color:white;
	margin:0;
}

.priceRow{
	display:flex;
	justify-content: space-between;
	margin: 0 10px;
	border-bottom: 1px solid #DADADA;
}

.checkoutBtn {
	margin: 5% auto;
	background-color: #00E205;
  	border: none;
  	color: #161618;
  	text-align: center;
  	text-decoration: none;
  	display: block;
  	font-size: 20px;
  	cursor: pointer;
  	width:75%;
  	padding:10px;
}


</style>
</html>