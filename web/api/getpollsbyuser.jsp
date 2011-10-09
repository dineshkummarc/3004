<%-- 
    Document   : listpolls-json
    Created on : 13/08/2011, 10:19:03 AM
    Author     : Aidan Rowe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import="db.*"%>
<jsp:useBean id="db" scope="session" class="db.database" /> 
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.Date,java.text.SimpleDateFormat,java.text.ParseException" %>

<%
/* Returns a list of all the polls a web use rhas been assigned to 
 * including their pollID, pollname, description, startDate, finishDate
 * and their status.
 * 
 * @require User must be logged in to access this API (session variable must be set)
 * @return JSON file with information polls assigned to user
 */
if (db.getLoggedIn() == 1) {
    
String userID = Integer.toString(db.getUserID());

        //Prepare the inputs, types, columnNames and columnTypes which are going to be returned
        String inputs[];
        inputs = new String[1];
        inputs[0] = userID;

        String types[];
        types = new String[1];
        types[0] = "int";

        String columnNames[];
        columnNames = new String[4];
        columnNames[0] = "pollID";
        columnNames[1] = "pollName";
        columnNames[2] = "description";
        columnNames[3] = "role";

        String columnTypes[];
        columnTypes = new String[4];
        columnTypes[0] = "int";
        columnTypes[1] = "string";
        columnTypes[2] = "string";
        columnTypes[3] = "string";
        String[] jsonNames = {"id", "name", "description", "role"};
        //ArrayList<String[]> pastPolls = new ArrayList<String[]>();
        String data = db.doPreparedQueryAndy("SELECT p.pollID, p.pollName, p.description, a.role from Assigned a INNER JOIN Polls p ON a.pollID = p.pollID WHERE a.userID = ?", inputs, types, columnNames, columnTypes, jsonNames);
        out.print(data);
        /*
        out.print("[");
        
        for ( int i = 0; i  < pastPolls.size(); i++) {
            out.print("{");
            out.print("\"id\": " + pastPolls.get(i)[0] + ", ");
            out.print("\"name\": \"" + pastPolls.get(i)[1] + "\", ");
            out.print("\"description\": \"" + pastPolls.get(i)[2] + "\", ");
            out.print("\"role\": \"" + pastPolls.get(i)[3] + "\" ");
            if (i == (pastPolls.size() -1)) {
                out.print("}]");
            } else {
                out.print("},");
            }
        }
            */
        
        
} else {
    out.print("{ \"error\": \"User not logged in.\", \"redirect\":\"Login\"}");
}
%>