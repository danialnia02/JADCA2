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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

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

	request.getRequestDispatcher("../TrackingOrderID").include(request, response);
	ResultSet trackingOrder = (ResultSet) request.getAttribute("TrackingOrder");
	orders(out,trackingOrder);
	
%>
<%!
	public void orders(JspWriter out, ResultSet rs) throws java.io.IOException {
	try{
		ArrayList<ArrayList<String>> listOfCartItems = new ArrayList<ArrayList<String>>();
		int index = 0;
		while(rs.next()){
			listOfCartItems.add(new ArrayList<String>());
			listOfCartItems.get(index).add(rs.getString("cartId"));
			listOfCartItems.get(index).add(rs.getString("trackingId"));
			listOfCartItems.get(index).add(rs.getString("createdDate"));
			listOfCartItems.get(index).add(rs.getString("productName"));
			listOfCartItems.get(index).add(rs.getString("priceEach"));
			listOfCartItems.get(index).add(rs.getString("totalPrice"));
			listOfCartItems.get(index).add(rs.getString("userId"));
			listOfCartItems.get(index).add(rs.getString("itemQuantity"));
			index++;
		}
		out.print("<ul id='orders'>");
		for(int i = 0; i<listOfCartItems.size(); i++) {
			double totalPrice = 0;
			if(i == 0) {
				out.print("<li class='trackingID' value='"+listOfCartItems.get(i).get(1)+"'>");
				out.print("<button type='button' class='collapsible'>Tracking id :"+ listOfCartItems.get(i).get(1)+"</button>");
				out.print("<div class='content'>");
				out.print("<p>Customer ID: "+listOfCartItems.get(i).get(6)+"</p>");
				out.print("<p class='datePurchased'>Date of purchase: "+listOfCartItems.get(i).get(2)+"</p>");
				out.print("	<ul class='productList'> Product List");
					for(int y = 0; y<listOfCartItems.size(); y++){
							if(listOfCartItems.get(i).get(1).equals(listOfCartItems.get(y).get(1))){
								out.print("<li class=product>" +listOfCartItems.get(y).get(3) +" </li>");
								totalPrice += Double.parseDouble(listOfCartItems.get(y).get(5));
							}
						}
				out.print("</ul>");
				out.print("Total payment: $" + totalPrice);
				out.print("</div>");
				out.print("</li>");

			} else if(!listOfCartItems.get(i).get(1).equals(listOfCartItems.get(i-1).get(1))){
				out.print("<li class='trackingID' value='"+listOfCartItems.get(i).get(1)+"'>");

				out.print("<button type='button' class='collapsible'>Tracking id :"+ listOfCartItems.get(i).get(1)+"</button>");
				out.print("<div class='content'>");
				out.print("<p>Customer ID: "+listOfCartItems.get(i).get(6)+"</p>");
				out.print("<p class='datePurchased'>Date of purchase: "+listOfCartItems.get(i).get(2)+"</p>");
				out.print("	<ul class='productList'>Product List ");
					for(int y = 0; y<listOfCartItems.size(); y++){
							if(listOfCartItems.get(i).get(1).equals(listOfCartItems.get(y).get(1))){
								out.print("<li>" +listOfCartItems.get(y).get(3) +" </li>");
								totalPrice += Double.parseDouble(listOfCartItems.get(y).get(5));
							}
						}
				out.print("</ul>");
				out.print("Total payment: $" + totalPrice);
				out.print("</div>");
				out.print("</li>");
			}
		}
		out.print("</ul>");
	} catch(Exception e) {
		e.printStackTrace();
	}
}
%>
<body>


<button id="sortID" onclick="sortByTrackingID()">Sort ID in descending order</button>
<button id="sortDate" onclick="sortByDate()">Sort Date in descending order</button>
<button> test3 </button>
<input type="text" id="myInput" onkeyup="filterByProduct()" placeholder="Search for products">

</body>

<style>
/* Style the button that is used to open and close the collapsible content */
.collapsible {
  background-color: #eee;
  color: #444;
  cursor: pointer;
  padding: 18px;
  width: 100%;
  border: none;
  text-align: left;
  outline: none;
  font-size: 15px;
}

.collapsible:after {
  content: '\02795'; /* Unicode character for "plus" sign (+) */
  font-size: 13px;
  color: white;
  float: right;
  margin-left: 5px;
}

.active:after {
  content: "\2796"; /* Unicode character for "minus" sign (-) */
}

/* Add a background color to the button if it is clicked on (add the .active class with JS), and when you move the mouse over it (hover) */
.active, .collapsible:hover {
  background-color: #ccc;
}

/* Style the collapsible content. Note: hidden by default */
.content {
  padding: 0 18px;
  background-color: white;
  max-height: 0;
  overflow: hidden;
  transition: max-height 0.2s ease-out;
}
</style>

<script>
var coll = document.getElementsByClassName("collapsible");
var i;

for (i = 0; i < coll.length; i++) {
  coll[i].addEventListener("click", function() {
    this.classList.toggle("active");
    var content = this.nextElementSibling;
    if (content.style.maxHeight){
      content.style.maxHeight = null;
    } else {
      content.style.maxHeight = content.scrollHeight + "px";
    }
  });
}

function filterByProduct() {
	input = document.getElementById("myInput");

	let filter = input.value.toUpperCase();
	let productList = document.getElementsByClassName("productList");
	let list = document.getElementById("orders");
	let order = list.getElementsByClassName("trackingID");
	
	for(let i = 0; i < productList.length; i++){
		for(let f = 0; f < productList[i].children.length; f++){
			if(productList[i].children[f].textContent.toUpperCase().indexOf(filter) > -1){

				order[i].style.display = "";
				break;
			} else {
				order[i].style.display = "none";
			}
		}
		
	}
}

function convertToMiliseconds(purchasedDate) {
	var temp = purchasedDate.replace("Date of purchase: ",'');
	var date = new Date(temp);
	var milliseconds = date.getTime();
	return milliseconds;
}

function sortByDate() {
	var list, switching, shouldSwitch, temp;

	list = document.getElementById("orders");
	temp = list.getElementsByClassName("trackingID");
	var sortType = document.getElementById("sortDate").textContent;
	switching = true;
		
	
	if(sortType==="Sort Date in descending order") {
		 while (switching) {
			    // start by saying: no switching is done:
			   	b = list.getElementsByClassName("datePurchased");
			    switching = false;
			    for (i = 0; i < (b.length - 1); i++) {
			      // start by saying there should be no switching:
			      shouldSwitch = false;
			      /* check if the next item should
			      switch place with the current item: */
			      
			      if (convertToMiliseconds(b[i].textContent) < convertToMiliseconds(b[i + 1].textContent)) {
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
		 document.getElementById("sortDate").textContent = "Sort Date in ascending order"
		} else {
			 while (switching) {
				    // start by saying: no switching is done:
				   	b = list.getElementsByClassName("datePurchased");
				    switching = false;
				    for (i = 0; i < (b.length - 1); i++) {
				      // start by saying there should be no switching:
				      shouldSwitch = false;
				      /* check if the next item should
				      switch place with the current item: */
				      
				      if (convertToMiliseconds(b[i].textContent) > convertToMiliseconds(b[i + 1].textContent)) {
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
			 document.getElementById("sortDate").textContent = "Sort Date in descending order"
		}
	
}

function sortByTrackingID() {
	var list, switching, shouldSwitch,b;
	list = document.getElementById("orders");
	b = list.getElementsByClassName("trackingID");
	var sortType = document.getElementById("sortID").textContent;
	switching = true;
	if(sortType==="Sort ID in descending order"){
	 while (switching) {
		    // start by saying: no switching is done:
		    switching = false;
		    b = list.getElementsByClassName("trackingID");
		    // Loop through all list-items:
		    for (i = 0; i < (b.length - 1); i++) {
		      // start by saying there should be no switching:
		      shouldSwitch = false;
		      /* check if the next item should
		      switch place with the current item: */
		      
		      if (Number(b[i].value) < Number(b[i + 1].value)) {
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
		      b[i].parentNode.insertBefore(b[i + 1], b[i]);
		      switching = true;
		    }
		  }
	 document.getElementById("sortID").textContent = "Sort ID by ascending order"
	} else {
		 while (switching) {
			    // start by saying: no switching is done:
			    switching = false;
			    b = list.getElementsByClassName("trackingID");
			    // Loop through all list-items:
			    for (i = 0; i < (b.length - 1); i++) {
			      // start by saying there should be no switching:
			      shouldSwitch = false;
			      /* check if the next item should
			      switch place with the current item: */
			      
			      if (Number(b[i].value) > Number(b[i + 1].value)) {
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
			      b[i].parentNode.insertBefore(b[i + 1], b[i]);
			      console.log(b[i].parentNode)

			      switching = true;
			    }
			  }
		 document.getElementById("sortID").textContent = "Sort ID in descending order"
	}
	
}
</script>
</html>