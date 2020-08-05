<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add New Product</title>
</head>
<link
	href="https://fonts.googleapis.com/css?family=Montserrat&display=swap"
	rel="stylesheet" />
<body style="background: #27282E">
	<%@include file="./Header.jsp"%>

	<section>
		<h1>
			Add product
		</h1>

		<div class="contact-form">
			<form action="addProductLogic.jsp" method="post">
				<div id="imgContainer">
					<img src="img/ramenlogo.jpeg">
				</div>
				<div class="txtb">
					<label>Product Name :</label> <input type="text" name="productName"
						placeholder="Enter product name"
						required>
				</div>

				<div class="txtb">
					<label>Description :</label> <input type="text" name="description"						
						placeholder="Enter a description" 
						required>
				</div>

				<div class="txtb">
					<label>Detailed description :</label> <input type="text"
						name="DetailDescription" placeholder="Enter a detailed description" required>
				</div>

				<div class="txtb">
					<label>Cost price :</label> <input type="number" name="Price" min=0
						placeholder="Enter a price" required>
				</div>

				<div class="txtb">
					<%GetCategories(out); %>
				</div>
				
				<div class="txtb">
					<label>Stock quantity :</label> <input type="number" name="stock" min=0
						placeholder="Enter the stock quantity" required>
				</div>
				
				<div class="txtb">
					<label>Image location :</label> <input type="text"
						name="image" placeholder="Enter an image" value="img/noImg.jpg" required>
				</div>
				<input class="btn" type="submit" value="Send">
			</form>
		</div>

	</section>


</body>
<%!public void GetCategories(JspWriter out) throws java.io.IOException {

		try {
			Connection conn = DriverManager.getConnection(connURL);
			ResultSet rs = HeaderSql(out, conn);
			rs.next();
			
			out.print("<select name='ProductCategory' class='select-css' size='1'>");
			do{
				out.print("<option value='"+ rs.getString("categoryName")+"'>"+rs.getString("categoryName")+"</option>");
				
			}while(rs.next());	
			out.print("</select>");

			//String[] ProductCategories = { rs.getString("ProductName"), rs.getString("Description"),
				//	rs.getString("DetailDescription"), rs.getString("RetailPrice"), rs.getString("StockQuantity"),
				//	rs.getString("ProductCategory"),rs.getString("ImageLocation") };
			conn.close();			
		} catch (Exception e) {
			System.err.println("Error :" + e);
		}	
	}%>
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
	margin-left: auto;
	background-color: #161618;
	min-width: 20%;
	max-height: 400px;
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

.contact-form {
	width: 85%;
	max-width: 600px;
	padding: 30px 40px;
	box-sizing: border-box;
	border-radius: 8px;
	text-align: center;
	box-shadow: 0 0 20px #000000b3;
	font-family: "Montserrat", sans-serif;
	margin: auto;
}

.contact-form h1 {
	margin-top: 0;
	font-weight: 200;
}

.txtb {
	border: 2px solid gray;
	margin: 8px 0;
	padding: 12px 18px;
	border-radius: 8px;
	background: #505050;
}

.txtb label {
	display: block;
	text-align: left;
	color: #B4E5C3;
	text-transform: uppercase;
	font-size: 14px;
}

.txtb input, .txtb textarea {
	width: 100%;
	border: none;
	background: none;
	outline: none;
	font-size: 18px;
	margin-top: 6px;
	color: white;
}

.btn {
	display: inline-block;
	background: #9b59b6;
	padding: 14px 0;
	color: white;
	text-transform: uppercase;
	cursor: pointer;
	margin-top: 8px;
	width: 100%;
}

.select-css {
	display: block;
	font-size: 16px;
	font-family: sans-serif;
	font-weight: 700;
	color: #444;
	line-height: 1.3;
	padding: .6em 1.4em .5em .8em;
	width: 100%;
	max-width: 100%;
	box-sizing: border-box;
	margin: 0;
	margin-top:10px;
	border: 1px solid #aaa;
	box-shadow: 0 1px 0 1px rgba(0,0,0,.04);
	border-radius: .5em;
	-moz-appearance: none;
	-webkit-appearance: none;
	appearance: none;
	background-color: #fff;
	background-image: url('data:image/svg+xml;charset=US-ASCII,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%22292.4%22%20height%3D%22292.4%22%3E%3Cpath%20fill%3D%22%23007CB2%22%20d%3D%22M287%2069.4a17.6%2017.6%200%200%200-13-5.4H18.4c-5%200-9.3%201.8-12.9%205.4A17.6%2017.6%200%200%200%200%2082.2c0%205%201.8%209.3%205.4%2012.9l128%20127.9c3.6%203.6%207.8%205.4%2012.8%205.4s9.2-1.8%2012.8-5.4L287%2095c3.5-3.5%205.4-7.8%205.4-12.8%200-5-1.9-9.2-5.5-12.8z%22%2F%3E%3C%2Fsvg%3E'),
	  linear-gradient(to bottom, #ffffff 0%,#e5e5e5 100%);
	background-repeat: no-repeat, repeat;
	background-position: right .7em top 50%, 0 0;
	background-size: .65em auto, 100%;
}
.select-css::-ms-expand {
	display: none;
}
.select-css:hover {
	border-color: #888;
}
.select-css:focus {
	border-color: #aaa;
	box-shadow: 0 0 1px 3px rgba(59, 153, 252, .7);
	box-shadow: 0 0 0 3px -moz-mac-focusring;
	color: #222;
	outline: none;
}
.select-css option {
	font-weight:normal;
}
</style>
</html>