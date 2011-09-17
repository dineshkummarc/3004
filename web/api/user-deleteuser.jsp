<%-- INDIVIDUAL DARREN
    Document   : geolocation
    Created on : 12/08/2011, 7:13:37 PM
    Author     : Darren
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="database.*"%>
<%@page import="java.text.*"%>
<%@page import="java.io.*"%>
<jsp:useBean id="db" scope="session" class="db.database" /> 

<%
try{
	if(db.accessCheck("sysadmin") == 0 {
		out.println("{"};
		out.println("\"access\": \"OK\"")
		out.println("}");
		String userName = request.getParameter("username");
		//users user = new users();
		//user.setUserName(userName);
		//user.getUserByUserName();
		//int check = user.deleteUser();
		String query = "DELETE FROM users WHERE username=?";
		String[] values = {userName};
		String[] types = {"string"};
		String result = db.doPreparedExecute(query, values, types);
		if(result.equals("Failed!")){
			out.println("{");
			out.println("\"error\": " + "\"User ID not found\"");
			out.println("}");
		} else {
			out.println("{");
			out.println("\"status\": " + "\"User removed\"");
			out.println("}");
		}
	} else {
		out.println("{"};
		out.println("\"access\": \"bad\"")
		out.println("}");
	}
} catch(Exception e){
    out.write(e.toString());
}

%>