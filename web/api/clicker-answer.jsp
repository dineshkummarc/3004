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
String questionID = request.getParameter( "questionid" );
String answerID = request.getParameter( "answerid" );
String clickerID = request.getParameter( "clickerid" );

//if (null != user && !user.equals( "" )) {

    String userID = request.getParameter("userid");
    //out.println("THIS IS THE USER ID" + userID + " <br/>");
    if (questionID == null) {
        out.print("{ \"error\": \"Invalid question ID.\"}");                
    } else {
        String answers[];               
        String types[];
        String inputs[];
        
        String types2[];
        String inputs2[];

        String value = null;
        
        if (!(answerID == null || answerID.equals(""))) {
            answers = answerID.split(",");               
        
            types = new String[2];
            types[0] = "string";
            types[1] = "int";
            
            inputs = new String[2];
            inputs[0] = clickerID;
            inputs[1] = questionID;
            
            types2 = new String[3];
            types2[0] = "string";
            types2[1] = "int";
            types2[2] = "int";
            
            inputs2 = new String[3];
            inputs2[0] = clickerID;
            inputs2[1] = questionID;

            value = null;

            value = db.doPreparedExecute("DELETE FROM KeyResponses WHERE clickerID = ? and questID = ?", inputs, types);
            
            value = null;
            for (int i = 0; i < answers.length; i++) {
                value = null;
                inputs2[2] = answers[i];
                value = db.doPreparedExecute("INSERT into KeyResponses(clickerID, questID, answerID) values (?, ?, ?)", inputs2, types2);
            }
            if (value.equals("Failed!")) {              
                out.print("{ \"error\": \"Submission failed due to incorrect parameteres\"}"); 
            } else {
		String[] countInput = {questionID};
		String[] countTypes = {"string"};
		String[] columNames = {"responsecount"};
		String[] columTypes = {"int"};
		int count = Integer.parseInt(db.doPreparedQuery("SELECT COUNT(*) AS responsecount FROM KeyResponses WHERE questID=?", countInput, countTypes, columNames, columTypes).get(0)[0]);
                out.print("{ \"responses\": " + count + " }");
                
            }
        }
    }
%>
