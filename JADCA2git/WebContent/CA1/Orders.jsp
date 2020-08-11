<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
<body>

<button type="button" class="collapsible">Tracking id :134567</button>
<div class="content">
  <p>Lorem ipsum...</p>
  <p>Lorem ipsum...</p>
  <p>Lorem ipsum...</p>
</div>

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
</script>
</html>