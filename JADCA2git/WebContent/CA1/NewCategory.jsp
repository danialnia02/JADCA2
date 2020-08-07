<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import=" models.users"%>

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

	<%
		 try {
		users userData = (users) session.getAttribute("userData");

		if (userData.getRole() == null || !userData.getRole().equals("root")) {			
			response.sendRedirect("MainPage.jsp");
		}

	} catch (Exception e) {
		System.out.println("here");
		e.printStackTrace();
		response.sendRedirect("MainPage.jsp");
	} 
	%>

	<section>
		<h1>Create a new Category!</h1>


		<div class="addCategory-form">
			<form action="NewCategorySql.jsp" method="post">
				<label>CategoryName :</label> <input type="text" name="CategoryName"
					value="" placeholder="Enter a name" required> <input
					class="btn" type="submit" value="Send">
			</form>
		</div>
	</section>


</body>
<style>
h1 {
	margin: 5% auto;
	display: flex;
	justify-content: center;
	color: white;
}

.addCategory-form {
	width: 300px;
	padding: 40px;
	margin: auto;
	margin-top: 5%;
	justify-content: center;
	background: #191919;
	text-align: center;
	border-radius: 5px;
}

.addCategory-form label {
	color: white;
	text-transform: uppercase;
	font-weight: 500;
}

.addCategory-form input[type="text"] {
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

.addCategory-form input[type="text"]:focus {
	width: 280px;
	border-color: #2ecc71;
}

.addCategory-form input[type="submit"] {
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

.addCategory-form input[type="submit"]:hover {
	background: #2ecc71;
}
</style>
</html>