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
    String dataID = request.getParameter("id"); //ID of the above type
    String location = "";
    //questions question = new questions();
    //question.setQuestID(Integer.parseInt(dataID));
    //question.getQuestion();
    //location = question.getLocation();
    String query = "SELECT location FROM questions WHERE questid=?";
    String[] values = {dataID};
    String[] types = {"int"};
    String[] columnNames = {"location"};
    String[] columnValues = {"string"};
    ArrayList<String[]> results = db.doPreparedQuery(query, values, types, columnNames, columnValues);
    location = results.get(0)[0];
    if(!location.equals("")){
        out.println("{");
        out.println("\"location\": \"" + location + "\"");
        out.println("}");
    } else {
        out.println("{");
        out.println("\"error\": " + "\"No data found\"");
        out.println("}");
    }
} catch(Exception e){
    out.write(e.toString());
}

%>