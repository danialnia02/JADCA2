<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title></title>
</head>
<body>
<nav class="navbar">
		<ul class="navbar-nav">
			<li class="nav-item"><a href=Sales.jsp>Sales</a></li>
			<li class="nav-item"><a href=Customers.jsp>Customers</a></li>
			<li class="nav-item"><a href=Orders.jsp>Orders</a></li>
			<li class="nav-item"><a href=Roles.jsp>Roles</a></li>
			<li class =nav-item><a href=Logout.jsp >Log out</a></li>

		</ul>
	</nav>

</body>

<style>
body {
	margin: 0;
	padding: 0;
	font-family: 'Montserrat', sans-serif;
	background: #27282E;
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

header {
	padding: 1em;
	background: #dc191b;
	margin-bottom: 1em;
	padding-bottom: 3.5em;
	text-align: center;
	clip-path: polygon(50% 0%, 100% 0, 100% 65%, 50% 100%, 0 65%, 0 0);
}

</style>
</html>