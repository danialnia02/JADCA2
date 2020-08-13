<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@page import=" models.users"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>

<%
users userData = (users) session.getAttribute("userData");
session.setAttribute("userData", userData);

try {
if (userData.getRole() == null || userData.getRole().equals("customer")) {

	response.sendRedirect("MainPage.jsp");
} else if(userData.getRole().equals("admin")) {
	%> <%@ include file="Header.jsp"%> <% 
} else {
	%> <%@ include file="RootHeader.jsp"%> <% 
}
} catch (Exception e) {
response.sendRedirect("MainPage.jsp");
}
%>

<%!public List<Map<Object,Object>> productStats(JspWriter out, ResultSet rs, ResultSet rs2) throws java.io.IOException {
	Map<Object,Object> map = null;
	List<Map<Object,Object>> list = new ArrayList<Map<Object,Object>>();
	double totalStock = getOverallInventory(out,rs2);

	try {
		while(rs.next()) { 

			String category = rs.getString(1);
			double stockQuantity = Double.parseDouble(rs.getString(2));
			int stockPercentage = (int)Math.round((stockQuantity/totalStock)*100);
			map = new HashMap<Object,Object>(); 
			map.put("Label", category); 
			map.put("y", stockPercentage); 
			list.add(map);

		}
	} catch(Exception e){
		e.printStackTrace();
	}
	return list;
}
%>
	
<%!public double getOverallInventory(JspWriter out, ResultSet rs) throws java.io.IOException {
	double totalProduct = 0;
	try {
		while(rs.next()) {
			
			totalProduct = Double.parseDouble(rs.getString(2));
			
		}
}catch(Exception e){
		e.printStackTrace();
	}
	return totalProduct;
}
	%>

	
<%!public void getColumnNames(JspWriter out, ResultSet rs) throws java.io.IOException {
		try {
			int counter = 0;			
			
			out.print("<tr class='header'>");
			while (rs.next() && counter < 2) {
				
				out.print("<th>" + rs.getString("Column") + "</th>");
				counter++;
			}
		} catch (Exception e) {
			System.out.println("here2");
			e.printStackTrace();
		}
		out.print("</tr>");
	}%>
	
	<%!public void getIndivdualProduct(JspWriter out, ResultSet rs) throws java.io.IOException {
		try {
			//code to get all existing products			
			while (rs.next()) {
				int stockQuantity = Integer.parseInt(rs.getString("stockQuantity"));
				if(stockQuantity <= 5) {
					out.print("<tr class='low'><td>" + rs.getString("productId") + "</td>" + "<td>" + rs.getString("ProductName")
					+ "</td>"
					+ "<td><form action='deleteProduct.jsp?'>" + " <input type='hidden' name='itemId' value="
					+ rs.getString("productId") + ">" + "<input type='submit' class='deleteBtn' value='Delete'>"
					+ "</form>" + "<td><form action='EditProduct.jsp?'>"
					+ " <input type='hidden' name='editProduct' value=" + rs.getString("productId") + ">"
					+ "<input type='submit' class='updateBtn' value='Edit'>" + "</form>");
					
				} else {
					
					out.print("<tr><td>" + rs.getString("productId") + "</td>" + "<td>" + rs.getString("ProductName")
					+ "</td>"
					+ "<td><form action='deleteProduct.jsp?'>" + " <input type='hidden' name='itemId' value="
					+ rs.getString("productId") + ">" + "<input type='submit' class='deleteBtn' value='Delete'>"
					+ "</form>" + "<td><form action='EditProduct.jsp?'>"
					+ " <input type='hidden' name='editProduct' value=" + rs.getString("productId") + ">"
					+ "<input type='submit' class='updateBtn' value='Edit'>" + "</form>");
					
				}
				
				
			}
		} catch (Exception e) {
			System.out.println("here3");
			e.printStackTrace();
		}
		;
	}%>
<body>
  <input type="text" id="myInput" onkeyup="searchProduct()" placeholder="Search for products">
 <table id="myTable">
				
				
	</table>

</body>
<style>

#myInput {
  background-image: url('/css/searchicon.png'); /* Add a search icon to input */
  background-position: 10px 12px; /* Position tde search icon */
  background-repeat: no-repeat; /* Do not repeat the icon image */
  width: 100%; /* Full-width */
  font-size: 16px; /* Increase font-size */
  padding: 12px 20px 12px 40px; /* Add some padding */
  border: 1px solid #ddd; /* Add a grey border */
  margin-bottom: 12px; /* Add some space below the input */
}

#myTable {
	
  border-collapse: collapse; /* Collapse borders */
  width: 100%; /* Full-width */
  border: 1px solid #ddd; /* Add a grey border */
  font-size: 18px; /* Increase font-size */
}

#myTable th, #myTable td {
  text-align: left; /* Left-align text */
  padding: 12px; /* Add padding */
}

#myTable tr {
  /* Add a bottom border to all table rows */
  border-bottom: 1px solid #ddd;
}

#myTable tr.header, #myTable tr:hover {
  /* Add a grey background color to the table header and on hover */
  background-color: #f1f1f1;
}

</style>

<script>
<script>
function searchProduct() {
  var input, filter, table, tr, td, i, txtValue;
  input = document.getElementById("myInput");
  filter = input.value.toUpperCase();
  table = document.getElementById("myTable");
  tr = table.getElementsByTagName("tr");

  for (i = 0; i < tr.length; i++) {

    td = tr[i].getElementsByTagName("td")[1];
    if (td) {
      txtValue = td.textContent || td.innerText;
      if (txtValue.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      } else {
        tr[i].style.display = "none";
      }
    }
  }
}
document.addEventListener("DOMContentLoaded", searchProduct);
</script>
</script>

</html>