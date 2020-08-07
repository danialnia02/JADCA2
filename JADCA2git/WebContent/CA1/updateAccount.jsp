
<%@include file="./sqlQueries.jsp"%>

<%
try{
	
	
	String id = request.getParameter("userId");
	String password = request.getParameter("username");		
	String role = request.getParameter("role");		
	String buttonType = request.getParameter("buttonType");
	
	System.out.println(buttonType);
	
	request.setAttribute("userId",id);
	request.setAttribute("password",password);
	request.setAttribute("role",role);
	request.setAttribute("buttonType",buttonType);
	
	request.getRequestDispatcher("../UpdateAccountSql").include(request, response);	
	
	/* if(test.equals("Delete")){		
		DeleteAccount(out,id,conn);		
	}else{
		
		UpdateAccount(out,id,role,conn);	
	}	
	conn.close(); */
	response.sendRedirect("RootPage.jsp");
}catch(Exception e){
	System.err.println("Error :" + e);
}
%>
