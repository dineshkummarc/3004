<%@page import="java.util.ArrayList"%>
<jsp:useBean id="db" scope="session" class="db.database" /> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%

String input[] = {Integer.toString(db.userID)};
//String input[] = {"2"};
String types[] = {"int"};
String columnNames[] = {"pollID", "pollName"};
String columnTypes[] = {"int", "string"};
String query = "SELECT p.pollID, p.pollName FROM Assigned a, Polls p WHERE "
        + "a.userID=? AND p.pollID=a.pollID";
String jsonName[] = {"pollID", "PollName"};
//ArrayList<String[]> result = db.doPreparedQuery(query, input, types, columnNames, columnTypes);
String data = db.doPreparedQueryAndy(query, input, types, columnNames, columnTypes, jsonName);
out.println(data);


%>
