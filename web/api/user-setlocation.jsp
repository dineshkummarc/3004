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
    String dataID = request.getParameter("id"); //ID of the above type
    String location = request.getParameter("location"); //The number generated by Google Maps
    if (location.equals(null)) {
        out.println("{");
        out.println("\"error\": " + "\"undefined coords\"");
        out.println("}");
    } else {
        //users user = new users();
        //user.setUserID(Integer.parseInt(dataID));
        //user.getUser();
        //user.setLocation(location);
        //user.editUser();
        String query = "UPDATE users SET location=? WHERE userid=?";
        String[] values = {location, dataID};
        String[] types = {"string", "int"};
        db.doPreparedExecute(query, values, types);
        out.println("{");
        out.println("\"status\": " + "\"Location changed\"");
        out.println("}");
    }                 
} catch(Exception e){
    out.write(e.toString());
}

%>