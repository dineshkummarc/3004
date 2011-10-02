<%-- 
    Document   : submitanswer-json
    Created on : 15/08/2011, 9:34:53 AM
    Author     : Aidan Rowe
--%>
<%-- NOTE: need ot make it return the results from a quesiton that has been submitted --%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import="db.*"%>
<jsp:useBean id="db" scope="session" class="db.database" /> 
<%@ page import = "java.util.ArrayList" %>

<%
/* Allows user to submit answer from a question and returns statistics from other users
 * answers.  
 * 
 * @require User must be logged in to access this API (session variable must be set)
 * @return JSON file with information polls assigned to user
 */
String pollID = request.getParameter( "pollid" );

//if (null != user && !user.equals( "" )) {
if (db.getLoggedIn() == 1) {
    String userID = Integer.toString(db.getUserID());
    //out.println("THIS IS THE USER ID" + userID + " <br/>");
    if (pollID == null) {
        out.print("{ \"error\": \"Invalid question ID.\"}");                
    } else {
        String types[];
        String inputs[];

        if (!(pollID == null || pollID.equals(""))) {         
            types = new String[1];
            types[0] = "int";
            
            inputs = new String[1];
            inputs[0] = pollID;
            //out.print(inputs[0]);
            //out.print(inputs[1]);
            String columnNames[];
            columnNames = new String[1];
            columnNames[0] = "activeQuestion";
            
            String columnTypes[];
            columnTypes = new String[1];
            columnTypes[0] = "int";
            
            ArrayList<String[]> value = new ArrayList<String[]>();
            value = db.doPreparedQuery("SELECT activeQuestion FROM Polls where pollID = ?", inputs, types, columnNames, columnTypes);
            
            out.print("{ \"activeQuestion\": " + value.get(0)[0] + " }");            
            
        }
    }
} else {
    out.print("{ \"error\": \"You are not currently logged in, Why are you here?\", \"redirect\":\"Login\"}");
}
%>
