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

	request.getRequestDispatcher("../CustomerDetails").include(request, response);
	ResultSet customerDetails = (ResultSet) request.getAttribute("customerDetails");
	
	request.getRequestDispatcher("../customerSpending").include(request, response);
	ResultSet customerSpending = (ResultSet) request.getAttribute("CustomerSpending");
	
	
%>
<%! public void displayCustomerDetails(JspWriter out, ResultSet customerDetail, ResultSet customerSpending) throws java.io.IOException {

	try {
		while(customerDetail.next()) {
			String role = customerDetail.getString("role");
			if(role.equals("customer")) {
				out.print("<button class='accordion'>"+customerDetail.getString("username")+"</button>");
				out.print("<div class='panel'>");
				out.print("<div> test </div>");
				out.print("<div style='display:flex;'>");
				out.print("<div style='width:40%'>");
				out.print("<div style='border-bottom:1px solid gray'><b>Customer details </b></div>");
				out.print("<div>Phone number: "+customerDetail.getString("phoneNumber")+" </div>");
				out.print("<div>Delivery address: "+ customerDetail.getString("deliveryAddress")+" </div>");
				out.print("<div>Postal code: "+ customerDetail.getString("postalCode") +"</div>");		
				out.print("<div>Payment type: " + customerDetail.getString("paymentType") + "</div>");	
				out.print("</div>");
				
				out.print("<div style='width:60%'>");
				out.print("test");
				out.print("</div>");
				out.print("</div>");
				out.print("</div>");
			}
		}
		
		
	} catch(Exception e) {
		e.printStackTrace();
		
	}
}

%>
	
 <%!public List<Map<Object,Object>> spendingStats(JspWriter out, int customerID, double totalSpending, ResultSet customerSpending) throws java.io.IOException {
	Map<Object,Object> map = null;
	List<Map<Object,Object>> list = new ArrayList<Map<Object,Object>>();
	double totalSales = 0;
	
	try {
		customerSpending.beforeFirst();
		while(customerSpending.next()) {
			int userID = Integer.parseInt(customerSpending.getString("userId"));
			if(userID == customerID){
				
				 	String category = customerSpending.getString("categoryName");
					double salesFromCategory = Double.parseDouble(customerSpending.getString("TotalAmountSpent"));
					int salesPercentage = (int)Math.round((salesFromCategory/totalSpending)*100);
					
					map = new HashMap<Object,Object>(); 
					map.put("Label", category); 
					map.put("y", salesPercentage); 
					list.add(map);			
					}
		
		}
	} catch(Exception e){
		e.printStackTrace();
	}
	return list;
}
%>
<body>
	<% displayCustomerDetails(out,customerDetails,customerSpending); %>

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

.accordion {
  background-color: #eee;
  color: #444;
  cursor: pointer;
  padding: 18px;
  width: 100%;
  border: none;
  text-align: left;
  outline: none;
  font-size: 15px;
  transition: 0.4s;
}

.active, .accordion:hover {
  background-color: #ccc;
}

.accordion:after {
  content: '\002B';
  color: #777;
  font-weight: bold;
  float: right;
  margin-left: 5px;
}

.active:after {
  content: "\2212";
}

.panel {
  padding: 0 18px;
  background-color: white;
  max-height: 0;
  overflow: hidden;
  transition: max-height 0.2s ease-out;
}


</style>


<script type="text/javascript">

	
var acc = document.getElementsByClassName("accordion");
var i;

for (i = 0; i < acc.length; i++) {
  acc[i].addEventListener("click", function() {
    this.classList.toggle("active");
    var panel = this.nextElementSibling;
    if (panel.style.maxHeight) {
      panel.style.maxHeight = null;
    } else {
      panel.style.maxHeight = panel.scrollHeight + "px";
    } 
  });
}

</script>

</html>