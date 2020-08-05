<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import= "java.util.ArrayList" %>
<%@ page import= "java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Root Page</title>
</head>
<body style="background: #27282E">
	<%@include file="./sqlQueries.jsp"%>
	<% if((String)session.getAttribute("role")==null
	        ||!(Boolean)session.getAttribute("role").equals("root")){

	        response.sendRedirect("MainPage.jsp");
	    }%>
	
		response.sendRedirect("MainPage.jsp");
	}
	%>
	<a href="Logout.jsp"><button style="background:grey;">Logout</button></a>

	<div class="container">
		<table>
			<tr>
				<th>id</th>
				<th>Username</th>
				<th>Role</th>
				<th>Change Role</th>
				<th colspan="3"><img src="img/deleteButton.png" class="logo" alt="add_new_account">
				<a href="addAccount.jsp" value=""></a></img></th>
			<%IndividualAccount(out); %>
		</table>		
	</div>	
	
	<div class="container">
		<table>
			<tr>
				<%getColumnNames(out); %>				
				<%getIndivdualProduct(out); %>
				
		</table>
		
	</div>
	
	<div class="container">
		<table>
			<tr>
			<th>Existing Categories</th>
			<th><form action ='NewCategory.jsp'><input type='submit' class='updatebtn' value='New Category'></form></th>
				<%getCategoryNames(out); %>				
				
		</table>
		
	</div>
</body>

<!--  get all existing column names -->
<%!public void getCategoryNames(JspWriter out) throws java.io.IOException {
		try {			
			Connection conn = DriverManager.getConnection(connURL);
			ResultSet rs = getCategoryNames(out,conn);			
			while(rs.next()){
				out.print("<tr><th>"+rs.getString("categoryName")+"</th>"+
				"<th><form action='editCategory.jsp?'>"+
				" <input type='hidden' name='editCategoryID' value="+rs.getString("categoryID")+">"+
				" <input type='hidden' name='editCategory' value="+rs.getString("categoryName")+">"+
				"<input type='submit' class='updatebtn' value='Edit'>"+
				"</form></th>"
			);
			}					
			conn.close();
		} catch (Exception e) {
			System.err.println("Error :" + e);
		}
		;
	}%>
<!--  get all existing column names -->
<%!public void getColumnNames(JspWriter out) throws java.io.IOException {
		try {			
			Connection conn = DriverManager.getConnection(connURL);		
									
			

			ResultSet rs = getColumnNames(out,conn);	

				while(rs.next()){
				
					out.print("<th>"+rs.getString("Column")+"</th>");
			}
		} catch (Exception e) {
			System.err.println("Error :" + e);
		}
		
	}%>
<!--  appending code for individual products -->
<%!public void getIndivdualProduct(JspWriter out) throws java.io.IOException {
		try {			
			Connection conn = DriverManager.getConnection(connURL);
			//code to get all existing products
			ResultSet rs = ListProductSql(out,"nothing", conn);			
			while(rs.next()){
				out.print("<tr><th>"+rs.getString("productId")+"</th>"+
						"<th>"+rs.getString("ProductName")+"</th>"+
						"<th>"+rs.getString("Description")+"</th>"+
						"<th>"+rs.getString("Detaildescription")+"</th>"+
						"<th>"+rs.getString("CostPrice")+"</th>"+
						"<th>"+rs.getString("RetailPrice")+"</th>"+
						"<th>"+rs.getString("StockQuantity")+"</th>"+
						"<th>"+rs.getString("ProductCategory")+"</th>"+
						"<th>"+rs.getString("ImageLocation")+"</th>"+
						"<th><form action='deleteProduct.jsp?'>"+
						" <input type='hidden' name='itemId' value="+rs.getString("productId")+">"+
						"<input type='submit' class='deleteBtn' value='Delete'>"+
						"</form>"+
						"<th><form action='EditProduct.jsp?'>"+
						" <input type='hidden' name='editProduct' value="+rs.getString("productId")+">"+
						"<input type='submit' class='updatebtn' value='Edit'>"+
						"</form>"
						
						);
			}					
			conn.close();
		} catch (Exception e) {
			System.err.println("Error :" + e);
		}
		;
	}%>

<!-- code to get the information of all existing users -->
<%!public void IndividualAccount(JspWriter out) throws java.io.IOException {
		try {			
			Connection conn = DriverManager.getConnection(connURL);
			ResultSet rs = IndividualAccount(out, conn);			
			while(rs.next()){
				out.print("<tr><form action='updateAccount.jsp' method='post'>"
						+"<td><input type='text' name='id' placeholder='id' value="+rs.getString("id")+" readonly>"+"</td>"
						+"<td><input type='text' name='username' placeholder='username' value="+rs.getString("username")+" readonly>"+"</td>"
						+"<td><input type='text' name='currentRole' placeholder='currentRole' value="+rs.getString("role")+" readonly>"+"</td>"
						+"<td>");GetRoles(out);out.print("</td>"
							+"<td><input type='submit' class='deleteBtn' name='test' value='Delete'></td>"
							+"<td><input type='submit' name='test' class='updatebtn' value='Update'></td></form>"
						);
			}		
			conn.close();
		} catch (Exception e) {
			System.err.println("Error :" + e);
		}
		;
	}%>
<!-- code to get all possible and existing roles -->
<%!public void GetRoles(JspWriter out) throws java.io.IOException {

		try {
			
			Connection conn = DriverManager.getConnection(connURL);
			ResultSet rs = GetRoles(out, conn);
			out.print("<select name='role' id= test size='1'>");
			ResultSet rs2 = getNoOfDistinctRoles(out, conn);
			
			rs2.next();
			int countToRepeat=Integer.parseInt(rs2.getString("total_no_of_rows"));
			String[] stringArray= new String[10];
			int count=0;
			while(rs.next()==true){				
				stringArray[count]=rs.getString("role");				
				count++;				
			}
						
			count=0;			
			for(int i=0;i<countToRepeat;i++){
				out.print("<option class='select-css' value='" + stringArray[i] + "'>" + stringArray[i]
						+ "</option>");										
			}
			while(count<countToRepeat){				
				
				count++;
			}
			out.print("</select>");				
			conn.close();
			
		} catch (Exception e) {
			System.err.println("Error :" + e);
		}		
	}%>
<style>
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

input[type="text"]{
  border:0;
  background: none;
  display: block;
  font-size:20px;
  margin: 20px auto;
  text-align: center;
  padding: 14px 10px;
  width: 200px;
  outline: none;
  color: white;
  transition: 0.25s;
</style>
</html>
