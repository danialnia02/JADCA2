<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="dbaccess.users"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link href="./css/scroll.css" rel="stylesheet" type="text/css" />
<link href="./css/header.css" rel="stylesheet" type="text/css" />
<link
	href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"
	rel="stylesheet">

<link
	href="https://fonts.googleapis.com/css?family=Montserrat&display=swap"
	rel="stylesheet" />

</head>

<style>
@import url(https://fonts.googleapis.com/css?family=Open+Sans);

body {
	margin: 0;
	padding: 0;
	font-family: 'Montserrat', sans-serif;
	background: 3030FE;
}

ul {
	list-style-type: none;
	margin: 0;
	padding: 0;
}

a {
	color: currentColor;
	text-decoration: none;
}

.navbar {
	height: 70px;
	width: 100%;
	background: #161618;
	color: white;
}

.navbar-nav {
	display: flex;
	align-items: center;
	justify-content: space-evenly;
	height: 100%;
}

.dropdown {
	width: auto;
	position: absolute;
	opacity: 0;
	z-index: 2;
	background: #161618;
	border-top: 2px solid white;
	border-bottom-right-radius: 8px;
	border-bottom-left-radius: 8px;
	display: flex;
	align-items: center;
	justify-content: space-around;
	height: 3rem;
	margin-top: 1.58rem;
	padding: 0.5rem;
	box-shadow: rgba(2, 8, 20, 0.1) 0px 0.175em 0.5em;
	transform: translateX(-40%);
	transition: opacity .15s ease-out;
}

.has-dropdown:focus-within .dropdown {
	opacity: 1;
	pointer-events: auto;
}

.dropdown-item input {
	width: 100%;
	height: 100%;
	font-size: 1.3rem;
	padding-left: 10px;
	background-color: #161618;
	text-decoration: none;
	cursor: pointer;
	border: none;
	color: currentColor;
	font-family: 'Montserrat', sans-serif;
	text-transform: uppercase;
}

.dropdown-item input:hover {
	color: #00E205;
	transition: color 0.3s;
}

header {
	padding: 1em;
	background: #dc191b;
	margin-bottom: 1em;
	padding-bottom: 3.5em;
	text-align: center;
	clip-path: polygon(50% 0%, 100% 0, 100% 65%, 50% 100%, 0 65%, 0 0);
}

.search {
	width: 100%;
	display: flex;
}

.searchTerm {
	width: 100%;
	border-right: none;
	padding: 5px;
	height: 26px;
	outline: none;
	color: #686666;
	border: none;
	background-color: #E8E5E0;
}

.searchButton {
	border: none;
	width: 40px;
	height: 36px;
	background: rgb(0, 226, 5);
	text-align: center;
	color: #fff;
	border-radius: 0 5px 5px 0;
	cursor: pointer;
	font-size: 20px;
	outline: none;
}

.searchButton:active {
	background: rgb(0, 139, 3);
	outline: none;
}
</style>
<body>

	<nav class="navbar">
		<ul class="navbar-nav">
			<li class="nav-item"><a href="MainPage.jsp">Home</a></li>
			<li class="nav-item"><a href="ListProduct.jsp?category=all">View
					products</a></li>
			<li class="nav-item has-dropdown"><a href="#">Categories</a>
				<ul class="dropdown">
					<%
						String username = null;
					String role = null;
					String id = null;
					String phoneNumber = null;
					String deliveryAddress = null;
					String postalCode = null;
					String cardNumber = null;
					String userid = null;
					String paymentType = null;
					try {
						users uBean = (users) session.getAttribute("userData");
						;
						// all of userInfo
						username = uBean.getUsername();
						role = uBean.getRole();
						id = uBean.getUserId();
						phoneNumber = uBean.getPhoneNumber();
						deliveryAddress = uBean.getDeliveryAddress();
						postalCode = uBean.getPostalCode();
						paymentType = uBean.getPaymentType();
						cardNumber = uBean.getCardNumber();
						userid = (String) session.getAttribute("id");
						session.setAttribute("userid", userid);
						
						session.setAttribute("userData",uBean);

					} catch (Exception e) {
						System.out.println("idiot");
						e.printStackTrace();
					}

					request.getRequestDispatcher("../HeaderSql").include(request, response);

					ResultSet rs = (ResultSet) request.getAttribute("HeadersSql");

					Header(out, rs);
					%>
				</ul></li>


			<%
				if (username == null || role == null) {
				out.print("<li class =nav-item><a href=Login.jsp>Login</a></li>"
				+ "<li class = nav-item><a href=Register.jsp>Register</a></li>");
			} else if (role.equals("customer")) {
				out.print("<li class =nav-item><a href=Cart.jsp>Cart</a>");
				out.print("<li class =nav-item><a href=Profile.jsp>Profile</a></li>");
				out.print("<li class =nav-item><a href=Logout.jsp>Log out</a></li>");
			} else if (role.equals("admin")) {

				out.print("<li class =nav-item><a href=addProduct.jsp>Add Product</a></li>");
				out.print("<li class =nav-item><a href=Logout.jsp >Log out</a></li>");
			}
			else if ((Boolean) session.getAttribute("role").equals("root")) {
			response.sendRedirect("RootPage.jsp");
			}
			%>
			<li>
				<form method=POST action=ListProduct.jsp>
					<div class="search">

						<input name='searchName' type="text" class="searchTerm"
							placeholder="What are you looking for?">
						<button type="submit" class="searchButton">
							<i class="fa fa-search"></i>
						</button>

					</div>
				</form>
			</li>
		</ul>
	</nav>


</body>
<%!public ResultSet Header(JspWriter out, ResultSet rs) {

		try {
			rs.next();
			do {
				out.print("<li class='dropdown-item'><form action='ListProduct.jsp?category="
						+ rs.getString("CategoryName") + "' method=post>" + "<input value="
						+ rs.getString("CategoryName") + " type=submit name=category></form></li>");
			} while (rs.next());
		} catch (Exception e) {
			System.err.println("Error :" + e);
		}
		return null;
	}%>








































</html>
