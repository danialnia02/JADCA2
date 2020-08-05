	<%
		String username = null;
		String role = null;
		String id = null;
		
	if ((String) session.getAttribute("username") == null || (String) session.getAttribute("role") == null) {
		response.sendRedirect("Login.jsp");
	} else {
		username = (String) session.getAttribute("username");
		role = (String) session.getAttribute("role");
		id = (String) session.getAttribute("id");
		session.setAttribute("username", username);
		session.setAttribute("role", role);
		session.setAttribute("id", id);
		response.sendRedirect("Cart.jsp");
	}
	%>
