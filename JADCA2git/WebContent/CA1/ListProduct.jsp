<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="models.users"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Viewing individual categories</title>
<link
	href="https://fonts.googleapis.com/css?family=Montserrat&display=swap"
	rel="stylesheet" />
</head>
<body style="background: #27282e;">

	<%@include file="./Header.jsp"%>
	<Header> Viewing products based on cat or everything </Header>
	<%	
	if(request.getParameter("category") != null){		
		String category = request.getParameter("category");
		request.setAttribute("category",category);
		String input = "";
		if (category == null || category.equals("all")) {
			input = "nothing";
			out.print("<h1>Viewing all Products!</h1>");
		} else {
			input = category;
			out.print("<h1>Viewing " + category + " products!</h1>");
		};
		
		request.getRequestDispatcher("../ListProductSql").include(request,response);
		ResultSet ListProductSql = (ResultSet)request.getAttribute("ListProductSql");
		
		myFunction(out,ListProductSql,(String) session.getAttribute("role"));
		
	} else {		
		request.getRequestDispatcher("../SearchSql").include(request,response);
		ResultSet SearchSql = (ResultSet)request.getAttribute("SearchSql");
		
		searchInput(out,SearchSql,(String)session.getAttribute("role"));
	}
	%>

	<%!public void myFunction(JspWriter out, ResultSet ListProductSql, String role) throws java.io.IOException {
		
		
		try {			
			
			ListProductSql.next();

			//needs do while for category to work
			out.print("<div class='flex-container'>");
			do {
				out.print("<div class='card'> <div><img src= "+ListProductSql.getString("ImageLocation")+" alt='"
						+ ListProductSql.getString("ProductName")
						+ "' style='width:100%; vertical-align: middle; height:100%; min-height:200px;'>" + "</div>"
						+ "<div class='container'>" + "<p style='margin:0;'><b>" + ListProductSql.getString("ProductName")
						+ "</b></p>" + "<p id = price style = margin:0; color: #14AE0B;>$" + ListProductSql.getString("RetailPrice")
						+ "</p>" + "</div>");

						
				if (role == null || !role.equals("admin")) {
					out.print("<form method = POST action= ProductDetail.jsp > "
							+ "<input type = hidden name = item value = " + ListProductSql.getString("ProductId") + ">"
							+ "<input id = detailBtn type = submit  value = Details> </form> </div>");
					
				} else {
					out.print("<form  action = 'EditProduct.jsp?' > "
							+ "<input type = hidden name = 'editProduct' value = " + ListProductSql.getString("ProductId") + ">"
							+ "<input id = detailBtn type = submit value = Edit></form>" + "</div>");
				}
			} while (ListProductSql.next());
			out.print("</div>");			
		} catch (Exception e) {
			System.err.println("Error :" + e);
		}
	}%>

	<%!public void searchInput(JspWriter out, ResultSet SearchSql, String role) throws java.io.IOException {		
		try {
						
			SearchSql.next();

			//needs do while for category to work
			if(SearchSql == null){
				out.print("hello world");
			}
			out.print("<div class='flex-container'>");
			do {
				out.print("<div class='card'> <div>" + "<img src= img/ramenlogo.jpeg alt='"
						+ SearchSql.getString("ProductName")
						+ "' style='width:100%; vertical-align: middle; height:100%; min-height:200px;'>" + "</div>"
						+ "<div class='container'>" + "<p style='margin:0;'><b>" + SearchSql.getString("ProductName")
						+ "</b></p>" + "<p id = price style = margin:0; color: #14AE0B;>$" + SearchSql.getString("RetailPrice")
						+ "</p>" + "</div>");
				if (role == null || !role.equals("admin")) {
					out.print("<form method = POST action= ProductDetail.jsp > "
							+ "<input type = hidden name = item value = " + SearchSql.getString("ProductId") + ">"
							+ "<input id = detailBtn type = submit  value = Details> </form> </div>");
					
				} else {
					out.print("<form  action = 'EditProduct.jsp?' > "
							+ "<input type = hidden name = 'editProduct' value = " + SearchSql.getString("ProductId") + ">"
							+ "<input id = detailBtn type = submit value = Edit></form>" + "</div>");
				}
			} while (SearchSql.next());
			out.print("</div>");
			// Step 7: Close connection			
		} catch (Exception e) {
			System.err.println("Error :" + e);
		}
	}%>
</body>

<style>
body{
	background-color:#27282e;
}
.flex-container {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  margin-right:20px;
  margin-left:20px;
  margin-top:0;
}

.flex-container > div {
	display: flex;
    flex-direction: column;
    justify-content: space-between;
    background-color: #f1f1f1;
    min-width: 20%;
    max-width:20%;
    min-height:300px;
    margin: 10px;
    text-align: center;
    /* line-height: 75px; */
    font-size: 30px;
}
  .card {
  box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
  transition: 0.3s;
}

/* On mouse-over, add a deeper shadow */
.card:hover {
  box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2);
}
	
.container {
	 display: flex;
	 flex-direction:column;
  	align-items: center;
  	justify-content: center;
	background: #161618;
	color:white;
	height:100%;
}

#btn {
 	background-color: #27282E;
  	border: none;
  	padding: 16px 32px;
  	text-decoration: none;
  	display:block;
  	margin: auto;
  	cursor: pointer;
  	font-size:1.5rem;
	transition: 0.2s;
}

#btn:hover {
	color:#00E205;
	transition:0.2s;
}

#detailBtn {
	background:#494A4F;
	border: none;
	width:100%;
	cursor: pointer;
	transition: 0.2s;
	text-decoration: none;
	align-items:bottom;
	height:50px;
	font-size:1.2rem;
	color:white;
}

#detailBtn:hover {
	background:rgb(0,226,5);
	color:black;
}

#price {
	color:#14AE0B;
}

h1 {
	color:white;
 	margin-bottom:0;
 	text-align:center;
}

</style>


</html>