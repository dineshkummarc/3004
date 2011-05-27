<%@page import="java.util.*" %>

<%
String ParameterNames = "";
for(Enumeration e = request.getParameterNames(); e.hasMoreElements();){
	ParameterNames = (String)e.nextElement();
	System.out.println(ParameterNames + "<br/>");
}
%>