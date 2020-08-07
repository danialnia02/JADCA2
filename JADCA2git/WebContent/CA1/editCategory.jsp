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
	<%
		users userData = (users) session.getAttribute("userData");
	session.setAttribute("userData", userData);
	try {
		if (userData.getRole() == null || !userData.getRole().equals("root")) {

			response.sendRedirect("MainPage.jsp");
		}
	} catch (Exception e) {
		response.sendRedirect("MainPage.jsp");
	}

	String categoryName = request.getParameter("editCategory");
	session.setAttribute("update","update");

	%>

	<section>
		<h1>
			Edit
			<%=categoryName%>
			category
		</h1>

		<div class="editCategory-form">
			<form action="NewCategorySql.jsp" method="post">
				<div class="txtb">
					<label>CategoryName :</label> <input type='hidden'
						name='OldCategoryName' value='<%=categoryName%>'> <input
						type='hidden' name='editCategory' value=''> <input
						type="text" name="CategoryName" value=<%=categoryName%>
						placeholder="Enter new category Name">
				</div>

				<input class="btn" type="submit" value="Update category">
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

.editCategory-form {
	width: 300px;
	padding: 40px;
	margin: auto;
	margin-top: 5%;
	justify-content: center;
	background: #191919;
	text-align: center;
	border-radius: 5px;
}

.editCategory-form label {
	color: white;
	text-transform: uppercase;
	font-weight: 500;
}

.editCategory-form input[type="text"] {
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

.editCategory-form input[type="text"]:focus {
	width: 280px;
	border-color: #2ecc71;
}

.editCategory-form input[type="submit"] {
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

.editCategory-form input[type="submit"]:hover {
	background: #2ecc71;
}
</style>
<%!public void getIndivCategoryName(JspWriter out) throws java.io.IOException {

		try {
			ResultSet rs = null;
			//ResultSet rs = HeaderSql(out);
			rs.next();
			rs.next();
			out.print("<select class='select-css' name='ProductCategory' size='1'>");
			do {
				out.print("<option value='" + rs.getString("ProductCategory") + "'>" + rs.getString("ProductCategory")
						+ "</option>");

			} while (rs.next());
			out.print("</select>");
		} catch (Exception e) {
			System.err.println("Error :" + e);
		}
	}%>
</html>