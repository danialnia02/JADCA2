<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="models.users"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.net.URL"%>

<!DOCTYPE html>
<html>
<link rel="stylesheet" type="text/css" href="./css/Cart.css">
<head>
<meta charset="ISO-8859-1">
<title>Payment Page</title>
</head>
<body>
	<h1 class=backButton>
		<a href="MainPage.jsp" style="color: white; text-decoration: none;">
			<svg xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="26"
				height="26" viewBox="0 0 172 172" style="fill: #000000;">
	<g fill="none" fill-rule="nonzero" stroke="none" stroke-width="1"
					stroke-linecap="butt" stroke-linejoin="miter"
					stroke-miterlimit="10" stroke-dasharray="" stroke-dashoffset="0"
					font-family="none" font-weight="none" font-size="none"
					text-anchor="none" style="mix-blend-mode: normal">
				<path d="M0,172v-172h172v172z" fill="none"></path>
				<g fill="#ffffff">
				<path
					d="M70.08173,86l56.79928,-57.98798c2.53245,-2.58413 2.50661,-6.71875 -0.05169,-9.30288l-10.15565,-10.15565c-2.60997,-2.58413 -6.79628,-2.58413 -9.38041,0.02584l-72.27824,72.74339c-1.29207,1.29206 -1.9381,2.97176 -1.9381,4.67728c0,1.70553 0.64603,3.38522 1.9381,4.67728l72.27824,72.74339c2.58413,2.60997 6.77044,2.60997 9.38041,0.02584l10.15565,-10.15565c2.55829,-2.58413 2.58413,-6.71875 0.05169,-9.30288z"></path></g></g></svg>
			Back
		</a>
	</h1>

	<%
		users userData = (users) session.getAttribute("userData");
	session.setAttribute("userData", userData);

	try {
		if (userData.getRole() == null || !userData.getRole().equals("customer")) {

			response.sendRedirect("MainPage.jsp");
		}
	} catch (Exception e) {
		response.sendRedirect("MainPage.jsp");
	}
	String username = userData.getUsername();
	;
	String role = userData.getRole();
	;
	String id = userData.getUserId();

	request.setAttribute("userId", id);

	String thisquantity = (String) session.getAttribute("thisquantity");
	String currentQuantity = (String) session.getAttribute("currentQuantity");
	//
	request.getRequestDispatcher("../currentCartCountSql").include(request, response);
	ResultSet currentCartCountSql = (ResultSet) request.getAttribute("currentCartCountSql");
	request.setAttribute("userId", id);

	request.getRequestDispatcher("../currentCartSql").include(request, response);
	ResultSet currentCartSql = (ResultSet) request.getAttribute("currentCartSql");
	request.setAttribute("userId", id);

	request.getRequestDispatcher("../currentCartSql").include(request, response);
	ResultSet currentCartSql3 = (ResultSet) request.getAttribute("currentCartSql");
	request.setAttribute("userId", id);

	request.getRequestDispatcher("../currentCartSql").include(request, response);
	ResultSet currentCartSql4 = (ResultSet) request.getAttribute("currentCartSql");
	request.setAttribute("userId", id);

	request.getRequestDispatcher("../currentCartSql2").include(request, response);
	ResultSet currentCartSql2 = (ResultSet) request.getAttribute("currentCartSql2");
	request.setAttribute("userId", id);

	int itemsBuying = ItemsBuying(out, currentCartSql, currentCartSql2);
	
	System.out.println("Euro/US Dollar: " + convertExchangeRate("EUR", "USD", 1000));
	
	%>

	<div style="margin: auto">
		<div id="productCol">
			<%
				itemCart(out, currentCartSql);
			%>
			
			<div class="container">
			<div class="cartHeader">Cart Summary</div>
			<%
				totalPrice(out, currentCartSql3, currentCartSql4);
			%>
			<form action="" style="text-align: center;" method="get">

  			<ul class="form-style-1">
    <li><label>Full Name <span class="required">*</span></label><input type="text" name="field1" class="field-divided" placeholder="First" /> <input type="text" name="field2" class="field-divided" placeholder="Last" /></li>
    <li>
        <label>Credit Card Number <span class="required">*</span></label>
        <input type="email" name="field3" class="field-long" />
    </li>
    <li>
        <label>Subject</label>
        <select name="field4" class="field-select">
        <option value="Advertise">Advertise</option>
        <option value="Partnership">Partnership</option>
        <option value="General Question">General</option>
        </select>
    </li>
    
</ul>
  			
			</form>
			<div style="display: block; width: 100%;">
				<a href="BuyItem.jsp" class="checkoutBtn"><b>Checkout</b></a>
			</div>
		</div>
			

		</div>

		
	</div>

</body>

<!-- return the total number of items in the cart -->
<%!public int CartNumberItems(JspWriter out, ResultSet rs) throws java.io.IOException {
	//currentCartSql

	try {
		int totalproducts = 0;
		rs.next();
		do {
			//System.out.println(totalproducts + " counting");
			totalproducts += (Integer.parseInt(rs.getString("itemQuantity")));
		} while (rs.next());
		return totalproducts;
	} catch (Exception e) {
		System.out.println("here1");
		e.printStackTrace();
	}
	return 0;
}%>
<!--  Get the total number of id of buying items -->
<%!public int ItemsBuying(JspWriter out, ResultSet rs, ResultSet rs2) throws java.io.IOException {
		//currentCartSql2
		try {

			//ItemsBuying
			//ResultSet rs = ItemsBuying(out, userId, conn);
			int itemsBuying = 0;
			rs2.next();
			itemsBuying = Integer.parseInt(rs2.getString("count"));
			//System.out.println(itemsBuying + " total nubmer of items");
			return itemsBuying;
		} catch (Exception e) {
			System.out.println("here2");
			//e.printStackTrace();
		}
		return 0;
	}%>

<%!public void totalPrice(JspWriter out, ResultSet rs, ResultSet rs2) throws java.io.IOException {
		//currentCartSql
		try {
			//rs.next();
			double totalPrice = 0;
			int totalProducts = CartNumberItems(out, rs);

			while (rs2.next()) {
				totalPrice += (Double.parseDouble(rs2.getString("RetailPrice"))
						* Double.parseDouble(rs2.getString("itemQuantity")));
			}
			double deliveryFee = (totalProducts * 2);
			double GST = Math.round(((totalPrice + deliveryFee) * 1.07) - totalPrice);
			double finalPrice = totalPrice + deliveryFee + GST;
			out.print("<div class=totalQuantityRow>");
			out.print("<h3 class=totalQuantityText>Total Quantity</h3>");
			out.print("<div class=totalQuantity>" + totalProducts + "</div>");
			out.print("</div>");

			out.print("<div class=totalQuantityRow>");
			out.print("<h3 class=priceText>Total Product Price</h3>");
			out.print("<div class='price'>$" + totalPrice + "</div>");
			out.print("</div>");
			
			out.print("<div class=totalQuantityRow>");
			out.print("<h3 class=priceText>Delivery fee</h3>");
			out.print("<div class='price'>$" + (totalProducts * 2) + "</div>");
			out.print("</div>");
			
			out.print("<div class=priceRow>");
			out.print("<h3 class=priceText>GST</h3>");
			out.print("<div class='price'>$" + GST + "</div>");
			out.print("</div>");
			
			out.print("<div class=priceRow style='margin-bottom:0.25rem;'>");
			out.print("<h3 class=priceText>Total Price</h3>");
			out.print("<div class='price'>$" + finalPrice + "</div>");
			out.print("</div>");

		} catch (Exception e) {
			System.out.println("here3");
			e.printStackTrace();
		}
	}%>

<%!public void itemCart(JspWriter out, ResultSet rs) throws java.io.IOException {
		//currentCartSql
		try {

			float totalprice = 0;
			int totalproducts = 0;
			rs.next();
			do {

				out.print("<div id='productContainer'>" + "<img src='" + rs.getString("ImageLocation") + "'>"
						+ "<div style='flex-basis: 25%; margin: 2%;'>" + rs.getString("ProductName") + "</div>"
						+ "<div style='flex-basis: 5%; margin: 5%;'>" + "Qty:" + rs.getString("itemQuantity") + "</div>"
						+ "<div style='flex-basis: 20%; align-content: flex-end;'>Price:$"
						+ (Double.parseDouble(rs.getString("RetailPrice"))
								* Double.parseDouble(rs.getString("itemQuantity")))
						+ "</div>" + "</div>");

			} while (rs.next());
		} catch (Exception e) {
			System.out.println("here4");
			//e.printStackTrace();
		}

	}%>

<style>
body {
	margin: 0;
	padding: 0;
	font-family: 'Montserrat', sans-serif;
	background: #27282e;
}

input{
	width:80%
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
	align-items: center;
	width: 100%;
	display: flex;
	flex-direction: column;
	margin-top: 4%;
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
	align-items: center;
	width: 70%;
	display: block;
	margin: 5%;
	background-color: #161618;
}

.totalQuantityRow {
	display: flex;
	justify-content: space-between;
	margin: 10px;
}

.totalQuantityText {
	color: white;
	margin: 0;
}

.totalQuantity {
	color: white;
}

.cartHeader {
	padding: 10px;
	background: #494A4F;
	color: #E3DBD2;
	font-size: 1.5rem;
}

.price {
	color: white;
}

.priceText {
	color: white;
	margin: 0;
}

.priceRow {
	display: flex;
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
	width: 75%;
	padding: 10px;
}

.form-style-1 {
	margin:10px auto;
	max-width: 550px;
	padding: 20px 12px 10px 20px;
	font: 13px "Lucida Sans Unicode", "Lucida Grande", sans-serif;
}
.form-style-1 li {
	padding: 0;
	display: block;
	list-style: none;
	margin: 10px 0 0 0;
}
.form-style-1 label{
	color:white;
	margin:0 0 3px 0;
	padding:0px;
	display:block;
	font-weight: bold;
}
.form-style-1 input[type=text], 
.form-style-1 input[type=date],
.form-style-1 input[type=datetime],
.form-style-1 input[type=number],
.form-style-1 input[type=search],
.form-style-1 input[type=time],
.form-style-1 input[type=url],
.form-style-1 input[type=email],
textarea, 
select{
	box-sizing: border-box;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	border:1px solid #BEBEBE;
	padding: 7px;
	margin:0px;
	-webkit-transition: all 0.30s ease-in-out;
	-moz-transition: all 0.30s ease-in-out;
	-ms-transition: all 0.30s ease-in-out;
	-o-transition: all 0.30s ease-in-out;
	outline: none;	
}
.form-style-1 input[type=text]:focus, 
.form-style-1 input[type=date]:focus,
.form-style-1 input[type=datetime]:focus,
.form-style-1 input[type=number]:focus,
.form-style-1 input[type=search]:focus,
.form-style-1 input[type=time]:focus,
.form-style-1 input[type=url]:focus,
.form-style-1 input[type=email]:focus,
.form-style-1 textarea:focus, 
.form-style-1 select:focus{
	-moz-box-shadow: 0 0 8px #88D5E9;
	-webkit-box-shadow: 0 0 8px #88D5E9;
	box-shadow: 0 0 8px #88D5E9;
	border: 1px solid #88D5E9;
}
.form-style-1 .field-divided{
	width: 49%;
}

.form-style-1 .field-long{
	width: 100%;
}
.form-style-1 .field-select{
	width: 100%;
}
.form-style-1 .field-textarea{
	height: 100px;
}
.form-style-1 input[type=submit], .form-style-1 input[type=button]{
	background: #4B99AD;
	padding: 8px 15px 8px 15px;
	border: none;
	color: #fff;
}
.form-style-1 input[type=submit]:hover, .form-style-1 input[type=button]:hover{
	background: #4691A4;
	box-shadow:none;
	-moz-box-shadow:none;
	-webkit-box-shadow:none;
}
.form-style-1 .required{
	color:red;
}
</style>
</html>

