<html>
<body>
<%
session.invalidate();
response.sendRedirect("MainPage.jsp?logout=trues");
%>
</body>
</html>