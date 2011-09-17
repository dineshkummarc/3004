<%-- INDIVIDUAL DARREN
    Document   : geolocation
    Created on : 12/08/2011, 7:13:37 PM
    Author     : Darren
--%>

<%@page import="java.util.ArrayList"%>
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
		
		String query = "SELECT userID, username, email, location, userlevel FROM users WHERE username=?";
		String[] values = {userName};
		String[] types = {"string"};
		String[] columnNames = {"userID", "username", "email", "location", "userlevel"};
		String[] columnValues = {"int", "string", "string", "string", "string"};
		ArrayList<String[]> results = db.doPreparedQuery(query, values, types, columnNames, columnValues);
		if (results.size() != 0) {
			out.println("{");
			out.println("\"userID\": \"" + results.get(0)[0] + "\",");
			out.println("\"userName\": \"" + results.get(0)[1] + "\",");
			out.println("\"email\": \"" + results.get(0)[2] + "\",");
			out.println("\"location\": \"" + results.get(0)[3] + "\",");
			out.println("\"userLevel\": \"" + results.get(0)[4] + "\"");
			out.println("}");
		} else {
			out.println("{");
			out.println("\"userID\": \"-1\",");
			out.println("\"status\": " + "\"User not found\"");
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