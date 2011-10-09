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
String questionID = request.getParameter( "questid" );

//if (null != user && !user.equals( "" )) {
    String userID = request.getParameter("userid");
    //out.println("THIS IS THE USER ID" + userID + " <br/>");
    if (questionID == null) {
        out.print("{ \"error\": \"Invalid question ID.\"}");                
    } else {
        String types[];
        String inputs[];
        
        String value = null;
        
        if (!(pollID == null || pollID.equals(""))) {         
            types = new String[2];
            types[0] = "int";
            types[1] = "int";
            
            inputs = new String[2];
            inputs[0] = questionID;
            inputs[1] = pollID;

            value = null;

            //out.print(inputs[0]);
            //out.print(inputs[1]);
            
            value = db.doPreparedExecute("UPDATE Polls SET activeQuestion = ? WHERE pollID = ?", inputs, types);
            if (value.equals("Failed!")) {              
                out.print("{ \"error\": \"Submission failed due to incorrect parameteres\"}");  
            } else {
                out.print("{ \"status\": \"OK\" }");
                
            }
        }
    }
%>
