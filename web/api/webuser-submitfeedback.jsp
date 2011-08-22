<%-- 
    Document   : submitfeedback-json
    Created on : 15/08/2011, 3:18:03 PM
    Author     : Aidan Rowe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import="db.*"%>
<jsp:useBean id="db" scope="session" class="db.database" /> 
<%@ page import = "java.util.ArrayList" %>

<%
/* Allows a user to submit feedback whilst undertaking a poll, feedback is submitted
 * based on userID and questID
 * 
 * @require qid - UserID
 *          feedback - message to be submitted
 * @return JSON which says its correct or incorrect.
 */
String questionID = request.getParameter( "qid" );
String feedback = request.getParameter( "feedback" );

//if (null != user && !user.equals( "" )) {
if (db.getLoggedIn() == 1) {
    String userID = Integer.toString(db.getUserID());
    
    if (questionID.equals("") || questionID == "") {
        out.print("{ \"error\": \"Invalid question ID.\"}");                
    } else {
        String types[];
        String inputs[];

        String value = null;
        
        if (feedback != null) {     
            types = new String[3];
            types[0] = "int";
            types[1] = "int";
            types[2] = "string";
            
            inputs = new String[3];
            inputs[0] = userID;
            inputs[1] = questionID;
            inputs[2] = feedback;

            value = null;

            value = db.doPreparedExecute("INSERT into Feedback(userID, questID, text) values (?, ?, ?)", inputs, types);

            if (value.equals("Failed!")) {              
                out.print("{ \"error\": \"Submission failed due to incorrect parameteres\"}");  
            } else {
                out.print("{ \"status\": \"Thank you for your feedback\"}");
            }
            
        } else {
            out.print("{ \"error\": \"Feedback is invalid.\"}");
        } 
    }
} else {
    out.print("{ \"error\": \"You are not currently logged in, Why are you here?\", \"redirect\":\"Login\"}");
}
%>
