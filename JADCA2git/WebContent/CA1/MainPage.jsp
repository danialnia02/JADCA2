<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="dbaccess.product"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home</title>
<link
	href="https://fonts.googleapis.com/css?family=Montserrat&display=swap"
	rel="stylesheet" />


</head>
<body>

	<%@ include file="Header.jsp"%>
	<%!public void MainPage(JspWriter out, String categoryNames, ArrayList<product> allProducts, String role) {

		try {
			//ResultSet rs = MainPageSql(out, category, conn);
			int count = 0;

			out.print("<h1> " + categoryNames + "</h1>");
			out.print("<form action=ListProduct.jsp  method=post>" + "<input type= hidden name = category value ="
					+ categoryNames + ">"
					+ "<input id = btn value = 'View more' type = submit></form>");
			out.print("<div class='flex-container'>");
			int counter = 0;
			for (count = 0; count < allProducts.size(); count++) {
				if (allProducts.get(count).getCategoryName().equals(categoryNames) && (counter < 4)) {
					//loop

					if (role == null || !role.equals("admin")) {
						out.print("<div class='card'> <div>" + "<img src= " + allProducts.get(count).getImageLocation()
								+ " alt='" + allProducts.get(count).getProductName()
								+ "' style='width:100%; vertical-align: middle; height:100%; min-height:200px;'>"
								+ "</div>" 
								+ "<div class='container'>"

								+ "<p style='margin:0;'><b>" + allProducts.get(count).getProductName() + "</b></p>"
								+ "<p id = price style =margin:0; color: #14AE0B;>$"+ allProducts.get(count).getRetailPrice() + "</p>" 
								+ "</div>"

								+ "<form method = POST action= ProductDetail.jsp > "
								+ "<input type = hidden name = item value = " + allProducts.get(count).getProductId()
								+ ">" + "<input id = detailBtn type = submit value = Details></form>"

								+ "</div>");
					} else {
						out.print("<div class='card'> <div>" + "<img src= '" + allProducts.get(count).getImageLocation()
								+ "' alt='" + allProducts.get(count).getProductName()
								+ "' style='width:100%; vertical-align: middle;  min-height:200px;'>" + "</div>"
								+ "<div class='container'>"

								+ "<p style='margin:0;'><b>" + allProducts.get(count).getProductName() + "</b></p>"
								+ "<p id = price style = margin:0; color: #14AE0B;>$"
								+ allProducts.get(count).getRetailPrice() + "</p>" + "</div>"

								+ "<form action = 'EditProduct.jsp?' > "
								+ "<input type = hidden name = 'editProduct' value = "
								+ allProducts.get(count).getProductId() + ">"
								+ "<input id = detailBtn type = submit value = Edit></form>"
								
								+ "</div>");
					}

					//loop	

					
				}
			}
			out.print("</div>");
		} catch (Exception e) {
			System.out.println("here");
			e.printStackTrace();
		}
	}%>

	<%!public void GetAllCategories(JspWriter out, String role, ArrayList<String> categoryNames,
			ArrayList<product> allProducts) {
		try {
			for (int i = 0; i < categoryNames.size(); i++) {
				out.println("<div>");				
				MainPage(out, categoryNames.get(i), allProducts, role);
				out.println("/<div>");
			}
		} catch (Exception e) {
			System.out.println("here2");
			e.printStackTrace();
		}
	}%>


	<header>
		<img src="img/logo.png" class="logo">
		<h2>Welcome to gamer shop</h2>
	</header>


	<%		
	product product = null;
	try {
		users uBean = (users) session.getAttribute("userData");		

		request.setAttribute("username", username);
		request.setAttribute("role", role);
		request.setAttribute("id", id);
	} catch (Exception e) {
		System.out.println("here3");
		e.printStackTrace();
	}

	//get category names	
	request.getRequestDispatcher("../GetAllCategories").include(request, response);
	ResultSet categoriesName = (ResultSet) request.getAttribute("GetAllCategories");

	ArrayList<String> categoryNames = new ArrayList<String>();

	try {
		while (categoriesName.next()) {
			categoryNames.add((String) categoriesName.getString("categoryName"));
		}
	} catch (Exception e) {
		System.out.println("here4");
		e.printStackTrace();
	}

	//get product based on category	
	request.getRequestDispatcher("../MainPageSql").include(request, response);
	ResultSet MainPageSql = (ResultSet) request.getAttribute("MainPageSql");

	ArrayList<product> allProducts = new ArrayList<product>();
	try {
		while (MainPageSql.next()) {
			allProducts.add(new product((String) MainPageSql.getString("productId"),
			(String) MainPageSql.getString("productName"), (String) MainPageSql.getString("description"),
			(String) MainPageSql.getString("detailDescription"), (String) MainPageSql.getString("costPrice"),
			(String) MainPageSql.getString("retailPrice"), (String) MainPageSql.getString("discountPrice"),
			(String) MainPageSql.getString("stockQuantity"), (String) MainPageSql.getString("categoryName"),
			(String) MainPageSql.getString("imageLocation")));
		}
	} catch (Exception e) {
		System.out.println("here5");
		e.printStackTrace();
	}	
	GetAllCategories(out, (String) session.getAttribute("role"), categoryNames, allProducts);
	%>

</body>

<style>
body {
	background-color: #27282e;
}

.flex-container {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	margin-right: 20px;
	margin-left: 20px;
	margin-top: 0;
}

.flex-container>div {
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	background-color: #f1f1f1;
	min-width: 20%;
	max-width: 20%;
	min-height: 300px;
	margin: 10px;
	text-align: center;
	/* line-height: 75px; */
	font-size: 30px;
}

.card {
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
	transition: 0.3s;
}

/* On mouse-over, add a deeper shadow */
.card:hover {
	box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.2);
}

.container {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	background: #161618;
	color: white;
	height: 100%;
}

#btn {
	background-color: #27282E;
	border: none;
	padding: 16px 32px;
	text-decoration: none;
	display: block;
	margin: auto;
	cursor: pointer;
	font-size: 1.5rem;
	transition: 0.2s;
}

#btn:hover {
	color: #00E205;
	transition: 0.2s;
}

#detailBtn {
	background: #494A4F;
	border: none;
	width: 100%;
	cursor: pointer;
	transition: 0.2s;
	text-decoration: none;
	align-items: bottom;
	height: 50px;
	font-size: 1.2rem;
	color: white;
}

#detailBtn:hover {
	background: rgb(0, 226, 5);
	color: black;
}

#price {
	color: #14AE0B;
}

h1 {
	color: white;
	margin-bottom: 0;
	text-align: center;
}
</style>

</html>