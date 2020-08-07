<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>	
	<%
		String category = request.getParameter("category");
		try {
			Class.forName("com.mysql.jdbc.Driver");			
			Connection conn = DriverManager.getConnection(connURL);
			Statement stmt = conn.createStatement();			
			PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM product WHERE `productCategory` = ? ");
			pstmt.setString(1,category);
			
			ResultSet rs = pstmt.executeQuery();
			
			if (!rs.next()) {
			} else {
				out.print("<h1 name='category' value='" + category + "'>"
						+ category + "</h1>");
				out.print("<div class='flex-container'>");
				do {
					String productId = rs.getString("productId");

					out.print("<div class='card'><a href='Item.jsp?itemid="
							+ productId + "'><img src='"
							+ rs.getString("ImageLocation") + "' alt='"
							+ rs.getString("ProductName")
							+ "' style='width:100%'>"
							+ "<div class='container'>"
							+ "<h4><b>John Toe</b></h4>"
							+ "<p>Architect and Engineer</p>" + "</div>"
							+ "</a></div>");
				} while (rs.next());
			}

			// Step 7: Close connection
			conn.close();
		} catch (Exception e) {
			System.err.println("Error :" + e);
		}
	%>
</body>
<style>
.flex-container {
	display: flex;
	flex-wrap: wrap;
	box-shadow: 2px 2px 5px #222;
	margin-right: 10px;
	margin-top: 5%;
}

.flex-container>div {
	background-color: #f1f1f1;
	min-width: 20%;
	height: 300px;
	margin: 10px;
	text-align: center;
	line-height: 75px;
	font-size: 30px;
}

.card {
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
	transition: 0.3s;
}

/* On mouse-over, add a deeper shadow */
.card:hover {
	box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.2);
}

/* Add some padding inside the card container */
}
</style>
</html>