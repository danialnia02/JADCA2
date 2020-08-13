<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
<link
	href="https://fonts.googleapis.com/css?family=Montserrat&display=swap"
	rel="stylesheet" />
<link href="./css/login.css" type="text/css" rel="stylesheet">

<body>
	<%
		String number = request.getParameter("number");
	%>

	<script>
		function test() {
			console.log("here!");
			if (
	<%=number%>
		== "1") {
				alert("Account Created!")
			} else if (
	<%=number%>
		== "0") {
				alert("Error while creating your account!")
			}

		}
		test();
	</script>


	<header
		style="background-color: #303030; display: flex; flex-direction: row; min-height: 40px;">

		<img src="img/logo.png" class="logo" style="margin: auto;">
	</header>

	<h1>
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

	<form class="loginBox" action="loginValidation.jsp" method="post">
		<h1>Login</h1>
		<input type="text" name="username" placeholder="Username" required>
		<input type="password" name="password" placeholder="Password" required>
		<input type="submit" value="Login">
	</form>

	<form class="registerBox" action="Register.jsp">
		<h1>New user? Register here!</h1>
		<input type="submit" value="Register">
	</form>

</body>

<style>
body {
	background: #27282e;
	margin: 0;
	padding: 0;
}

.loginBox {
	width: 300px;
	padding: 40px;
	margin: auto;
	margin-top: 5%;
	justify-content: center;
	background: #191919;
	text-align: center;
	border-radius: 5px;
}

.loginBox h1 {
	color: white;
	text-transform: uppercase;
	font-weight: 500;
}

.loginBox input[type="text"], .loginBox input[type="password"] {
	border: 0;
	background: none;
	display: block;
	margin: 20px auto;
	text-align: center;
	border: 2px solid #3498db;
	padding: 14px 10px;
	width: 200px;
	outline: none;
	color: white;
	border-radius: 24px;
	transition: 0.25s;
}

.loginBox input[type="text"]:focus, .loginBox input[type="password"]:focus
	{
	width: 280px;
	border-color: #2ecc71;
}

.loginBox input[type="submit"] {
	border: 0;
	background: none;
	display: block;
	margin: 20px auto;
	text-align: center;
	border: 2px solid #2ecc71;
	padding: 14px 40px;
	outline: none;
	color: white;
	border-radius: 24px;
	transition: 0.25s;
	cursor: pointer;
}

.loginBox input[type="submit"]:hover {
	background: #2ecc71;
}

.registerBox {
	width: 300px;
	padding: 40px;
	margin: auto;
	margin-top: 1%;
	background: #191919;
	text-align: center;
	border-radius: 10px;
}

.registerBox input[type="submit"] {
	border: 0;
	background: none;
	display: block;
	margin: 20px auto;
	text-align: center;
	border: 2px solid #2ecc71;
	padding: 14px 40px;
	outline: none;
	color: white;
	border-radius: 24px;
	transition: 0.25s;
	cursor: pointer;
}

.registerBox input[type="submit"]:hover {
	background: #2ecc71;
}

.registerBox h1 {
	color: white;
	text-transform: uppercase;
	font-weight: 500;
}
</style>
</html>