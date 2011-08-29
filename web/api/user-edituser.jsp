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
    String userName = request.getParameter("username");
    String password = request.getParameter("password");
    String email = request.getParameter("email");
    String location = request.getParameter("location");
    String userLevel = request.getParameter("userlevel");
    String expired = request.getParameter("expired");
    //users user = new users();
    //user.setUserName(userName);
    //user.getUserByUserName();
    //user.setPassword(password);
    //user.setEmail(email);
    //user.setLocation(location);
    //user.setUserLevel(userLevel);
    //int check = user.editUser();
    String query = "UPDATE users SET password=?, email=?, location=?, userlevel=?, expired=? WHERE username=?";
    String[] values = {password, email, location, userLevel, expired, userName};
    String[] types = {"string", "string", "string", "string", "string", "string"};
    String result = db.doPreparedExecute(query, values, types);
    if(result.equals("Failed!")){
        out.println("{");
        out.println("\"error\": " + "\"User ID not found\"");
        out.println("}");
    } else {
        out.println("{");
        out.println("\"status\": " + "\"User edited\"");
        out.println("}");
    } 
} catch(Exception e){
    out.write(e.toString());
}

%>