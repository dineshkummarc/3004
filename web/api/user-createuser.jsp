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
		//users user = new users();
		//user.setUserID(-1);
		String userName = request.getParameter("username");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String location = request.getParameter("location");
		String userLevel = request.getParameter("userlevel");
		String expired = request.getParameter("expired");
		//user.setUserName(userName);
		//user.setPassword(password);
		//user.setEmail(email);
		//user.setLocation(location);
		//user.setUserLevel(userLevel);
		//int check = user.addUser();
		String query = "INSERT INTO users (userid, username, password, email, location, userlevel, created, expired) VALUES (useq.nextval, ?, ?, ?, ?, ?, SYSDATE, ?)";
		String[] values = {userName, password, email, location, userLevel, expired};
		String[] types = {"string", "string", "string", "string", "string", "string"};
		String result = db.doPreparedExecute(query, values, types);
		if(result.equals("Failed!")){
			out.println("{");
			out.println("\"error\": " + "\"Unknown error occured during creation\"");
			out.println("}");
		} else {
			out.println("{");
			out.println("\"status\": " + "\"User registered\"");
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