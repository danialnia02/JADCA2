<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.JsonObject"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@page import=" models.users"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>

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
<%! public ArrayList<String> displayCustomerDetails(JspWriter out, ResultSet customerDetail, ResultSet customerSpending) throws java.io.IOException {
	Gson gsonObj = new Gson();
	int count = 1;
	ArrayList<String> spendingStats = new ArrayList<String>();
	out.print("<ul id=list>");
	try {
		while(customerDetail.next()) {
			String role = customerDetail.getString("role");
			if(role.equals("customer")) {
				out.print("<li class=items>");
				out.print("<button class='accordion'> Customer ID:"+customerDetail.getString("username")+"</button>");
				out.print("<div class='panel'>");
				out.print("<div style='display:flex;'>");
				out.print("<div style='width:40%'>");
				out.print("<div style='border-bottom:1px solid gray'><b>Customer details </b></div>");
				out.print("<div>Phone number: "+customerDetail.getString("phoneNumber")+" </div>");
				out.print("<div>Delivery address: "+ customerDetail.getString("deliveryAddress")+" </div>");
				out.print("<div class='postalCode'>Postal code: "+ customerDetail.getString("postalCode") +"</div>");		
				out.print("<div>Payment type: " + customerDetail.getString("paymentType") + "</div>");	
				out.print("<div class='totalSpent'>Total spent: $" + customerDetail.getString("TotalAmountSpent") + "</div>");	

				out.print("</div>");
				
				out.print("<div style='width:60%'>");
				spendingStats.add(gsonObj.toJson(spendingStats(out, Integer.parseInt(customerDetail.getString("userId")),Double.parseDouble(customerDetail.getString("TotalAmountSpent")),customerSpending)));
				out.print("<div id='spendingChart"+count+"' style='height: 370px; width: 100%;''></div>");
				out.print("</div>");
				out.print("</div>");
				out.print("</div>");
				out.print("</li>");
				count++;
			}
		}
		
	} catch(Exception e) {
		e.printStackTrace();
		
	}
	out.print("</ul>");
	return spendingStats;
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
<div style="color:white; display:flex; justify-content:center;"><h1><b>Customers</b></h1></div>
<div style="display:flex;justify-content:space-evenly; margin-bottom:0.5rem;">
</div>
	<div style="display:flex;"> 
		<div id ="customerList">
		<% ArrayList<String> test = displayCustomerDetails(out,customerDetails,customerSpending); %>
		
		</div>
		
		<div id="buttons"> 
			<label><b>Postal Code</b></label>
			<input type="number" id="searchCustomerPostalCode" onkeyup="searchByPostalCode()" placeholder="Search for postal code">
			<button id="sortSpending" onclick="sortByTotalSpent()">Sort spending in descending order</button>
			
		</div>
	</div>

</body>


<style>

#sortSpending {
	color: #fff !important;
	text-transform: uppercase;
	text-decoration: none;
	background: #ed3330;
	padding: 20px;
	border-radius: 5px;
	display: inline-block;
	border: none;
	transition: all 0.4s ease 0s;
	width:100%;
	margin-bottom:3%;
}

#sortSpending:hover{
	background: #434343;
	box-shadow: 5px 40px -10px rgba(0,0,0,0.57);
}

#customerList {
	width: 100%;
	display: flex;
	flex-direction: column;
	margin-top: 4%;
	margin-left: 2%;
}

#buttons {
	width: 35%;
	max-width: 35%;
	display: block;
	float: right;
	margin: 5%;
	color: white;
	max-height: 200px;
}

#searchCustomerPostalCode {
  width: 80%; /* Full-width */
  font-size: 16px; /* Increase font-size */
  padding: 12px 20px 12px 40px; /* Add some padding */
  border: 1px solid #ddd; /* Add a grey border */
  margin-bottom: 12px; /* Add some space below the input */
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

#fixedbutton {
    position: fixed;
    bottom: 2rem;
    right: 2rem; 
    text-decoration: none;
    border: none;
    border-radius: 50%;
    padding: 25px;
}


</style>


<script type="text/javascript">
window.onload = function() { 
	<% int length = test.size(); %>
	var length = <%= length %>
	var hi = <%=test %>
for(var i = 0; i < length; i++){
var chart = new CanvasJS.Chart("spendingChart" + (i+1), {
	animationEnabled: true,
	title:{
		text: "Total spending distribution"
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
		dataPoints : hi[i]
	}]
});
	chart.render();
}
}

function searchByPostalCode() {
	input = document.getElementById("searchCustomerPostalCode");

	let filter = input.value.toUpperCase();
	let productList = document.getElementsByClassName("items");
	let list = document.getElementsByClassName("postalCode");
	console.log(productList)
	
	for(let i = 0; i < list.length; i++){
			if(trimPostalCode(list[i].textContent.toUpperCase()).indexOf(filter) > -1){

				productList[i].style.display = "";
				break;
			} else {
				productList[i].style.display = "none";
			}
		
		
	}
}

function trimPostalCode(postalCode){
	let trimPostalCode = postalCode.replace("Postal code: ","");
	return trimPostalCode;
}

function trimSpending(spending) {
	let trimSpending = spending.replace("Total spent: $","");
	return trimSpending
}

function sortByTotalSpent() {
	let list = document.getElementById("list");
	let test = document.getElementsByClassName("totalSpent");
	switching = true;
	let temp = list.getElementsByClassName("items");
	var sortType = document.getElementById("sortSpending").textContent;

	if(sortType === "Sort spending in descending order") {
	 while (switching) {
			    // start by saying: no switching is done:
			   	
			    switching = false;
			    for (i = 0; i < (test.length - 1); i++) {
			      // start by saying there should be no switching:
			      shouldSwitch = false;
			      /* check if the next item should
			      switch place with the current item: */
			      
			      if (Number(trimSpending(test[i].innerHTML)) > Number(trimSpending(test[i+1].innerHTML))) {
			        /* if next item is numerically
			        lower than current item, mark as a switch
			        and break the loop: */
			        shouldSwitch = true;
			        break;
			      }
			    }
			    if (shouldSwitch) {
			      /* If a switch has been marked, make the switch
			      and mark the switch as done: */
			      
			      list.insertBefore(temp[i + 1], temp[i]);
			      switching = true;
			    }
			  }
	 	document.getElementById("sortSpending").textContent = "Sort spending in ascending order"

	} else {
		 while (switching) {
			    // start by saying: no switching is done:
			   	
			    switching = false;
			    for (i = 0; i < (test.length - 1); i++) {
			      // start by saying there should be no switching:
			      shouldSwitch = false;
			      /* check if the next item should
			      switch place with the current item: */
			      
			      if (Number(trimSpending(test[i].innerHTML)) < Number(trimSpending(test[i+1].innerHTML))) {
			        /* if next item is numerically
			        lower than current item, mark as a switch
			        and break the loop: */
			        shouldSwitch = true;
			        break;
			      }
			    }
			    if (shouldSwitch) {
			      /* If a switch has been marked, make the switch
			      and mark the switch as done: */
			      
			      list.insertBefore(temp[i + 1], temp[i]);
			      switching = true;
			    }
			  }
		 document.getElementById("sortSpending").textContent = "Sort spending in descending order"

	}
}
	

	
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