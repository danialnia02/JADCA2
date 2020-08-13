<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@page import=" models.users"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<%@ include file="RootHeader.jsp"%>

<%!public void IndividualAccount(JspWriter out, ResultSet rs, ResultSet GetRoles, ResultSet getNoOfDistinctRoles)
			throws java.io.IOException {
		try {
			while (rs.next()) {
				out.print("<tr><form action='updateAccount.jsp' method='post'>"
						+ "<td><input type='text' name='userId' placeholder='id' value=" + rs.getString("userId")
						+ " readonly>" + "</td>"
						+ "<td><input type='text' name='username' placeholder='username' value="
						+ rs.getString("username") + " readonly>" + "</td>"
						+ "<td><input type='text' name='currentRole' placeholder='currentRole' value="
						+ rs.getString("role") + " readonly>" + "</td>" + "<td>");
				GetRoles(out, GetRoles, getNoOfDistinctRoles);
				out.print("</td>" + "<td><input type='submit' class='deleteBtn' name='buttonType' value='Delete'></td>"
						+ "<td><input type='submit' name='buttonType' class='updatebtn' value='Update'></td></form>");
			}
		} catch (Exception e) {
			System.out.println("here4");
			e.printStackTrace();
		}
		;
	}%>
	
	<%!public void GetRoles(JspWriter out, ResultSet rs, ResultSet rs2) throws java.io.IOException {

		ArrayList<String> rolesArray = new ArrayList<String>();
		int countToRepeat = 0;
		int count = 0;
		try {
			 countToRepeat=Integer.parseInt(rs2.getString("total_no_of_rows"));
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		System.out.println(countToRepeat);
		try {
			while (rs.next()) {
				rolesArray.add(rs.getString("role"));
			}
			rs.beforeFirst();
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		try {
			out.print("<select name='role' id= test size='1'>");								

			System.out.println(rolesArray.size());
			for (int i = 0; i < rolesArray.size(); i++) {
				System.out.println(rolesArray.get(i));
				out.print("<option class='select-css' value='"+ rolesArray.get(i) +"'>" + rolesArray.get(i) + "</option>");
			}
			
			out.print("</select>");
			
			while(count<countToRepeat){				
				
				count++;
			}
			

		} catch (Exception e) {
			System.out.println("here5");
			
			e.printStackTrace();
		}
	}%>

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

	request.getRequestDispatcher("../IndividualAccountSql").include(request, response);
	ResultSet IndividualAccountSql = (ResultSet) request.getAttribute("IndividualAccountSql");

	request.getRequestDispatcher("../getNoOfDistinctRoles").include(request, response);
	ResultSet getNoOfDistinctRoles = (ResultSet) request.getAttribute("getNoOfDistinctRoles");

	request.getRequestDispatcher("../GetRolesSql").include(request, response);
	ResultSet GetRolesSql = (ResultSet) request.getAttribute("GetRolesSql");
	%>
<body>

	<div class="container">
		<table>
			<tr>
				<th>id</th>
				<th>Username</th>
				<th>Role</th>
				<th>Change Role</th>
				<th colspan="3"><img src="img/deleteButton.png" class="logo"
					alt="add_new_account"> <a href="addAccount.jsp" value=""></a></img></th>
				<%
					IndividualAccount(out, IndividualAccountSql, GetRolesSql, getNoOfDistinctRoles);
				%>
			
		</table>
	</div>

</body>

<style>

body{
	background: #27282E;
}

.container {
	border: 2px solid black;
	outline: #4CAF50 solid 10px;
	margin: 50px;
	padding: 50px;
}

#person {
	border: 2px solid black;
	outline: #4CAF50 solid 10px;
	margin: 50px;
	padding: 50px;
}

#text {
	color: white;
}

.logo {
	width: 50px;
	height: 50px;
}

table {
	font-family: arial, sans-serif;
	border-collapse: collapse;
	width: 100%;
}

tr, td {
	color: white
}

td, th {
	border: 1px solid #dddddd;
	text-align: left;
	padding: 8px;
}

.deleteBtn {
	background-color: #f44336;
	border: none;
	color: white;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin: 4px 2px;
	cursor: pointer;
}

.updatebtn {
	background-color: #4CAF50; /* Green */
	border: none;
	color: white;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin: 4px 2px;
	cursor: pointer;
}

input[type="text"] {
	border: 0;
	background: none;
	display: block;
	font-size: 20px;
	margin: 20px auto;
	text-align: center;
	padding: 14px 10px;
	width: 200px;
	outline: none;
	color: white;
	transition: 0.25s;
}
</style>
</html>