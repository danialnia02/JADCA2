<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<link
	href="https://fonts.googleapis.com/css?family=Montserrat&display=swap"
	rel="stylesheet" />

<body style="background: #27282E">
	<%@ include file="Header.jsp"%>

	<%
		try {			
		String itemId = request.getParameter("item");
		users userInfo = (users) session.getAttribute("userInfo");		
		String userId = userInfo.getUserId();		
		session.setAttribute("itemId",itemId);	
		
		//get the information of the selected Item
		ResultSet res = EditProduct(out, Integer.parseInt(itemId), conn);
		res.next();
		//System.out.println(res.getString("productId"));
		int outputNumber = 0;	
		try{
			//get quantity if the user has already inserted into the cart;
			ResultSet rs = getQuantityInCart(out, userId, itemId, conn);	
			rs.next();						
			
			outputNumber=Integer.parseInt(res.getString("StockQuantity"))- Integer.parseInt(rs.getString("itemQuantity"));
			
		}catch(Exception e){
			outputNumber=Integer.parseInt(res.getString("StockQuantity"));			
		} 
	%>

	<section>
		<h1><%=res.getString("ProductName")%></h1>
		<div style="display: flex;">

			<div>
				<div id="imgContainer">
					<img src="<%=res.getString("ImageLocation")%>">
				</div>

				<div id="descriptionTitle">PRODUCT DESCRIPTION</div>
				<div id="description">
					<%=res.getString("DetailDescription")%>

				</div>
			</div>
			<div class="container">

				<h1>
					$<%=res.getString("RetailPrice")%></h1>

				<div>Stock:<%=res.getString("StockQuantity")%></div>

				<div>
					<form action="addToCart.jsp">
						<label for="quantity">Quantity:</label> <input type="number"
							id="quantity" name="quantity" value="1" min="1" max='<%= showOutput(out,outputNumber) %>'>
							<input type=hidden name=itemId value='<%=res.getString("productId") %>'>
						<input type="submit" id="submit" value="Add to cart">
					</form>
				</div>

			</div>

		</div>
	</section>

	<%
		conn.close();
	} catch (Exception e) {
		System.err.println("Error here: " + e);
	}
	%>
	<%!public int showOutput(JspWriter out, int number) throws java.io.IOException {				
		return number;
	}%>


</body>

<style>
h1 {
	color: white;
	margin: 3% 10% 0;
}

div {
	color: #C9E5C3;
	margin: 3% 10% 0;
}

#description {
	margin-top: 2%;
}

#imgContainer {
	display: flex;
	margin: auto;
	margin-top: 4%;
	justify-content: center;
}

#descriptionTitle {
	display: flex;
	border-bottom: 1px solid white;
}

.col-25 {
	-ms-flex: 25%; /* IE10 */
	flex: 25%;
}

.col-25 {
	padding: 0 16px;
}

.container {
	display: block;
	align-items: center;
	margin-left: auto;
	background-color: #161618;
	min-width: 20%;
	max-height: 400px;;
}

#submit {
	background-color: #00E205;
	color: #000000;
	border: none;
	padding: 16px 32px;
	text-decoration: none;
	display: block;
	margin: auto;
	margin-top: 90%;
	cursor: pointer;
	font-size: 1.5rem;
	transition: 0.2s;
}

#submit:hover {
	background-color: #04BB09;
	transition: 0.2s;
}

img {
	width: 100%;
}
</style>
</html>
