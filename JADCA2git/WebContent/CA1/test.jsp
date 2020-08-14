<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	
<%@ page import="models.exchangeRates"%>
<!DOCTYPE html>

<%
/* String currency =request.getParameter("currency");
String cardNumber=request.getParameter("cardNumber");

System.out.println(currency);
System.out.println(cardNumber); */

/* /* exchangeRates test = new exchangeRates();
System.out.println(test.exchangeRates("SGD")); */

System.out.println(creditCardCheck("4035501000000008")); 

%>

<%!
public static boolean creditCardCheck(String number){
	int sum = 0;
	boolean alternate = false;
	for(int i =number.length() - 1 ; i >=0; i--){
		int n = Integer.parseInt(number.substring(i,i+1));
		if(alternate){
			n*=2;
			if(n>9){
				n=(n%10)+1;
			}
		}
		sum+=n;
		alternate=!alternate;		
	}
	
	
	return (sum%10 ==0);
}

%>

<html>
<head>
<meta charset="ISO-8859-1">
<title>testing page</title>
</head>
<body>

</body>
</html>