<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.JsonObject"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@page import=" models.users"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>

<%

		Gson gsonObj = new Gson();
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

	request.getRequestDispatcher("../IndividualAccountSql").include(request, response);
	ResultSet IndividualAccountSql = (ResultSet) request.getAttribute("IndividualAccountSql");

	request.getRequestDispatcher("../getNoOfDistinctRoles").include(request, response);
	ResultSet getNoOfDistinctRoles = (ResultSet) request.getAttribute("getNoOfDistinctRoles");

	request.setAttribute("category", "nothing");
	request.getRequestDispatcher("../ListProductSql").include(request, response);
	ResultSet ListProductSql = (ResultSet) request.getAttribute("ListProductSql");

	request.getRequestDispatcher("../GetAllCategories").include(request, response);
	ResultSet GetAllCategories = (ResultSet) request.getAttribute("GetAllCategories");
	
	request.getRequestDispatcher("../GetColumnNamesSql").include(request, response);
	ResultSet getColumnNamesSql = (ResultSet) request.getAttribute("GetColumnNamesSql");	
	
	request.getRequestDispatcher("../OverallInventorySql").include(request, response);
	ResultSet OverallInventory = (ResultSet) request.getAttribute("OverallInventorySql");
	
	request.getRequestDispatcher("../TotalProductsInCategory").include(request, response);
	ResultSet totalProductsInCategory = (ResultSet) request.getAttribute("TotalProductsInCategory");
	
	request.getRequestDispatcher("../TotalSalesDistributionSql").include(request, response);
	ResultSet totalSalesDistribution = (ResultSet) request.getAttribute("TotalSalesDistribution");
	
	request.getRequestDispatcher("../Top4Products").include(request, response);
	ResultSet top4Products = (ResultSet) request.getAttribute("Top4Products");
	
	request.getRequestDispatcher("../Least4Products").include(request, response);
	ResultSet least4Products = (ResultSet) request.getAttribute("Least4Products");
	
	String stockData = gsonObj.toJson(productStats(out, totalProductsInCategory,OverallInventory));
	String salesData = gsonObj.toJson(salesStats(out,totalSalesDistribution));
	%>
	
<%!public void topFourProduct(JspWriter out, ResultSet rs)throws java.io.IOException {
	try {
		while(rs.next()) { 

			out.print("<div class='overviewcard'>");
			out.print("<div class='overviewcard__icon'><b>" + rs.getString("productName")+ "</b></div>");
			out.print("<div class='overviewcard__info'> Qty:" +rs.getString("count")+"</div>");
			out.print("</div>");

		}
	} catch(Exception e){
		e.printStackTrace();
	}
}
	%>
	
<%!public void leastFourProduct(JspWriter out, ResultSet rs)throws java.io.IOException {
	try {
		while(rs.next()) { 

			out.print("<div class='overviewcard'>");
			out.print("<div class='overviewcard__icon'><b>" + rs.getString("productName")+ "</b></div>");
			out.print("<div class='overviewcard__info'> Qty:" +rs.getString("count")+"</div>");
			out.print("</div>");

		}
	} catch(Exception e){
		e.printStackTrace();
	}
}
%>
	
<%!public List<Map<Object,Object>> salesStats(JspWriter out, ResultSet rs) throws java.io.IOException {
	Map<Object,Object> map = null;
	List<Map<Object,Object>> list = new ArrayList<Map<Object,Object>>();
	double totalSales = 0;
	
	try {
		while(rs.next()) { 

			totalSales += Double.parseDouble(rs.getString("totalProfitsFromCategory"));

		}
	} catch(Exception e){
		e.printStackTrace();
	}
	
	try {
		rs.beforeFirst();
		while(rs.next()) { 
			String category = rs.getString("categoryName");
			double salesFromCategory = Double.parseDouble(rs.getString("totalProfitsFromCategory"));
			System.out.println(salesFromCategory);
			int salesPercentage = (int)Math.round((salesFromCategory/totalSales)*100);
			
			map = new HashMap<Object,Object>(); 
			map.put("Label", category); 
			map.put("y", salesPercentage); 
			list.add(map);

		}
	} catch(Exception e){
		e.printStackTrace();
	}
	return list;
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
<script type="text/javascript">
window.onload = function() { 
	 
	var chart = new CanvasJS.Chart("stockChart", {
		animationEnabled: true,
		title:{
			text: "Total stock distribution"
		},
		legend: {
			verticalAlign: "center",
			horizontalAlign: "right"
		},
		data: [{
			type: "pie",
			showInLegend: true,
			indexLabel: "{y}%",
			indexLabelPlacement: "inside",
			legendText: "{Label}: {y}%",
			toolTipContent: "<b>{Label}</b>: {y}%",
			dataPoints : <%out.print(stockData);%>
		}]
	});
	chart.render();
	
	var chart = new CanvasJS.Chart("salesChart", {
		animationEnabled: true,
		title:{
			text: "Total sales distribution"
		},
		legend: {
			verticalAlign: "center",
			horizontalAlign: "right"
		},
		data: [{
			type: "pie",
			showInLegend: true,
			indexLabel: "{y}%",
			indexLabelPlacement: "inside",
			legendText: "{Label}: {y}%",
			toolTipContent: "<b>{Label}</b>: {y}%",
			dataPoints : <%out.print(salesData);%>
		}]
	});
	chart.render();
	 
	}
</script>

<body>


<div class="grid-container">

  <main class="main">
  
  <h1 class="salesHeader">Top selling items</h1>

  
<div class="main-overview">
  <%  topFourProduct(out, top4Products); %>
</div>

<h1 class="salesHeader">Least selling items</h1>
<div class="main-overview">
    <%  leastFourProduct(out, least4Products); %>
  
</div>

<div class="main-cards">
  <div class="card" style="overflow-x:auto;">
  <input type="text" id="myInput" onkeyup="searchProduct()" placeholder="Search for products">
  <table id="myTable">
				<%
					getColumnNames(out,getColumnNamesSql);
				%>
				<%
					getIndivdualProduct(out, ListProductSql);
				%>
				<%
					getOverallInventory(out,OverallInventory );
				%>
				
	</table>
</div>

  <div class="card">
<div id="stockChart" style="height: 370px; width: 100%;"></div>  
  </div>
    <div class="card">
  
  <div id="salesChart" style="height: 370px; width: 100%;"></div>  

</div>

</main>
  <footer class="footer"></footer>
</div>

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

.salesHeader{
	color:white;
	text-align: center;
	font-size:24px;
}

th {
	width:40%;
}

.low {
	background:#DC191B;
}

.grid-container {
  display: grid;
  background:#DC191B;
  grid-template-columns: auto 1fr;
  grid-template-rows: 0 1fr 50px;
  grid-template-areas:
    "sidenav header"
    "sidenav main"
    "sidenav footer";
  height: 100vh;
}

/* Give every child element its grid name */
.header {
  grid-area: header;
  background-color: #648ca6;
}

.sidenav {
  grid-area: sidenav;
  background-color: #394263;
}

.main {
  grid-area: main;
  background-color: #27282E;
}

 .main-header {
    display: flex;
    justify-content: space-between;
    margin: 20px;
    padding: 20px;
    height: 150px; /* Force our height since we don't have actual content yet */
    background-color: #e3e4e6;
    color: slategray;
  }

.footer {
  grid-area: footer;
  background-color: #648ca6;
}

  .sidenav {
    display: flex; /* Will be hidden on mobile */
    flex-direction: column;
    grid-area: sidenav;
    background-color: #394263;
  }

  .sidenav__list {
    padding: 0;
    margin-top: 85px;
    list-style-type: none;
  }

  .sidenav__list-item {
    padding: 20px 20px 20px 40px;
    color: #ddd;
  }

  .sidenav__list-item:hover {
    background-color: rgba(255, 255, 255, 0.2);
    cursor: pointer;
  }
  
  .main-overview {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(265px, 1fr)); /* Where the magic happens */
    grid-auto-rows: 94px;
    grid-gap: 20px;
    margin: 20px;
  }
  
  .overviewcard {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 20px;
    background-color: #161618;
    color: white;
  }
  
   .main-cards {
    column-count: 2;
    column-gap: 20px;
    margin: 20px;
  }
  
  .card {
    display: flex;
    flex-direction: column;
    align-items: center;
    background-color: #D3D3D3;
    margin-bottom: 20px;
    -webkit-column-break-inside: avoid;
    padding: 24px;
    box-sizing: border-box;
  }

  /* Force varying heights to simulate dynamic content */
  .card:first-child {
    height: 485px;
  }

  .card:nth-child(2) {
    height: 200px;
  }

  .card:nth-child(3) {
    height: 265px;
  }

  
  .main-cards {
    column-count: 1;
    column-gap: 20px;
    margin: 20px;
  }
  
  /* Medium-sized screen breakpoint (tablet, 1050px) */
  @media only screen and (min-width: 65.625em) {
    /* Break out main cards into two columns */
    .main-cards {
      column-count: 2;
    }
  }
  
.deleteBtn {
	background: #F44336;
	cursor: pointer;
	border:none;
	border-style: outset;
	color:white;
}

.updateBtn {
	background: #4CAF50;
	cursor: pointer;
	border:none;
	border-style: outset;
	color:white;
}
</style>

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
</html>