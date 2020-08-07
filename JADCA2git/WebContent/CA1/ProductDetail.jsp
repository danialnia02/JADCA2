<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="models.users"%>

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

	<%try{
		String userId= null;
		users userInfo = (users) session.getAttribute("userInfo");		
		
		//check if user exists
		try{
			userInfo.getUserId();
		}catch(Exception e){
			userId="0";
			e.printStackTrace();
		}
		
		String itemId= request.getParameter("item");		
		request.setAttribute("itemId",itemId);
		
		//get the information of the selected Item
		request.getRequestDispatcher("../EditProductSQL").include(request,response);		
		ResultSet EditProductSql =(ResultSet) request.getAttribute("EditProductSQL");
		EditProductSql.next();			
		
		//check stock quantity against the number in user's cart
		int StockQuantity = Integer.parseInt(EditProductSql.getString("StockQuantity"));
		System.out.println(StockQuantity);
		request.getRequestDispatcher("../getQuantityInCartSql").include(request,response);		
		int quantityInCart = (int) request.getAttribute("quantityInCart");
		System.out.println(quantityInCart);
		if (quantityInCart != 0){
			StockQuantity = StockQuantity - quantityInCart;			
		}
		
	
	%>

	<section>		
		<h1> <%=EditProductSql.getString("ProductName")%></h1>		
		<div style="display: flex;">

			<div>
				<div id="imgContainer">
					<img src=" <%=EditProductSql.getString("ImageLocation")%> ">
				</div>

				<div id="descriptionTitle">PRODUCT DESCRIPTION</div>
				<div id="description">
					<%=EditProductSql.getString("DetailDescription")%>

				</div>
			</div>
			<div class="container">

				<h1>
					$ <%=EditProductSql.getString("RetailPrice")%> </h1>

				<div>
					Stock:<%=EditProductSql.getString("StockQuantity")%> </div>

				<div>
					<form action="addToCart.jsp">
						<label for="quantity">Quantity:</label> <input type="number"
							id="quantity" name="quantity" value="1" min="1"
							max="<%=showOutput(out, StockQuantity)%>"> <input
							type=hidden name=itemId
							value='<%=EditProductSql.getString("productId")%> '> <input
							type="submit" id="submit" value="Add to cart">
					</form>
				</div>

			</div>

		</div>
	</section>
	<%
	}catch(Exception e){
		System.out.println("error");
		e.printStackTrace();
	}
	%>

	<%!public int showOutput(JspWriter out, int number) throws java.io.IOException {
		System.out.println(number);
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
