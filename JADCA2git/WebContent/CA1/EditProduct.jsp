<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="models.product"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Product</title>
</head>
<link
	href="https://fonts.googleapis.com/css?family=Montserrat&display=swap"
	rel="stylesheet" />
<body style="background: #27282E">

	<%
		if ((String) session.getAttribute("role") == null || (Boolean) session.getAttribute("role").equals("customer")) {
		response.sendRedirect("MainPage.jsp");
	}

	if ((Boolean) session.getAttribute("role").equals("admin")) {
	%>
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
		} else if ((Boolean) session.getAttribute("role").equals("root")) {
	%>
	<h1 class=backButton>
		<a href="RootPage.jsp" style="color: white; text-decoration: none;">
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
		}

	String itemid = request.getParameter("editProduct");
	request.setAttribute("itemId", itemid);
	//get ItemInfo
	request.getRequestDispatcher("../EditProductSQL").include(request, response);
	ResultSet itemInfo = (ResultSet) request.getAttribute("EditProductSQL");
	product productInfo = new product();

	itemInfo.next();
	productInfo.setProductId(itemInfo.getString("productId"));
	productInfo.setProductName(itemInfo.getString("productName"));
	productInfo.setDescription(itemInfo.getString("description"));
	productInfo.setDetailDescription(itemInfo.getString("detailDescription"));
	productInfo.setCostPrice(itemInfo.getString("costPrice"));
	productInfo.setRetailPrice(itemInfo.getString("retailPrice"));
	productInfo.setDiscountPrice(itemInfo.getString("discountPrice"));
	productInfo.setStockQuantity(itemInfo.getString("stockQuantity"));
	productInfo.setCategoryName(itemInfo.getString("categoryName"));
	productInfo.setImageLocation(itemInfo.getString("imageLocation"));

	session.setAttribute("itemId", productInfo.getProductId());
	%>


	<section>
		<h1>Edit Product</h1>


		<div class="contact-form">
			<form action="../FileUploadSql" method="post"  enctype="multipart/form-data">
				<div id="imgContainer">
					<img src="<%=productInfo.getImageLocation()%>">
				</div>
				<div class="txtb">
					<label>Product Name :</label> <input type="text" name="productName"
						value="<%=productInfo.getProductName()%>"
						placeholder="Enter product name" required>
				</div>

				<div class="txtb">
					<label>Description :</label> <input type="text" name="description"
						value="<%=productInfo.getDescription()%>"
						placeholder="Enter a description" required>
				</div>

				<div class="txtb">
					<label>Detailed description :</label> <input type="text"
						name="DetailDescription"
						value="<%=productInfo.getDetailDescription()%>"
						placeholder="Enter a detailed description" required>
				</div>

				<div class="txtb">
					<label>Cost price :</label> <input type="number" name="Price"
						value="<%=productInfo.getCostPrice()%> " min=0
						placeholder="Enter a price" required>
				</div>

				<div class="txtb">
					<label>Product category: </label> <input type="text"
						name="categoryName" value="<%=productInfo.getCategoryName()%> "
						min=0 placeholder="Enter a new categoryName" required>
				</div>

				<div class="txtb">
					<label>Stock quantity :</label> <input type="number" name="stock"
						value="<%=productInfo.getStockQuantity()%>" min=0
						placeholder="Enter the stock quantity" required>
				</div>

				<div class="txtb">
					<label>Image :</label> <input type="file" name="image"
						required> <input type=hidden name=ProductId
						value=<%=productInfo.getProductId()%>>
						<input type = hidden name = function
						value ="update">
				</div>
				<input class="btn" type="submit" value="Update product">

			</form>
			<form action="deleteProduct.jsp" method="post">
				<input type=hidden name=itemId value=<%=productInfo.getProductId()%>>
				<input class="btn" type="submit" value="Delete Product">
			</form>
		</div>

	</section>


</body>

<style>
h1 .backButton {
	display: block;
	margin: 0;
}

h1 {
	color: white;
	display: flex;
	justify-content: center;
	margin: 5% auto;
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
	margin-top: 10px;
	border: 1px solid #aaa;
	box-shadow: 0 1px 0 1px rgba(0, 0, 0, .04);
	border-radius: .5em;
	-moz-appearance: none;
	-webkit-appearance: none;
	appearance: none;
	background-color: #fff;
	background-image:
		url('data:image/svg+xml;charset=US-ASCII,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%22292.4%22%20height%3D%22292.4%22%3E%3Cpath%20fill%3D%22%23007CB2%22%20d%3D%22M287%2069.4a17.6%2017.6%200%200%200-13-5.4H18.4c-5%200-9.3%201.8-12.9%205.4A17.6%2017.6%200%200%200%200%2082.2c0%205%201.8%209.3%205.4%2012.9l128%20127.9c3.6%203.6%207.8%205.4%2012.8%205.4s9.2-1.8%2012.8-5.4L287%2095c3.5-3.5%205.4-7.8%205.4-12.8%200-5-1.9-9.2-5.5-12.8z%22%2F%3E%3C%2Fsvg%3E'),
		linear-gradient(to bottom, #ffffff 0%, #e5e5e5 100%);
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
	font-weight: normal;
}
</style>

</html>
