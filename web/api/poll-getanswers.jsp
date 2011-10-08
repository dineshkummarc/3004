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
String questionID = request.getParameter( "qid" );

//if (null != user && !user.equals( "" )) {
if (db.getLoggedIn() == 1) {
    String userID = Integer.toString(db.getUserID());
    //out.println("THIS IS THE USER ID" + userID + " <br/>");
    if (questionID == null) {
        out.print("{ \"error\": \"Invalid question ID.\"}");                
    } else {

        out.print("{ \"status\": \"OK\",");


        String responseInput[] = new String[1];
        responseInput[0] = questionID;

        String responseTypes[] = new String[1];
        responseTypes[0] = "int";

        String responseCN[] = new String[3];
        responseCN[0] = "answer";
        responseCN[1] = "COUNT(m.answerID)";
        responseCN[2] = "COUNT(p.answerID)";

        String responseCP[] = new String[3];
        responseCP[0] = "string";
        responseCP[1] = "int";
        responseCP[2] = "int";

        out.print("\"responses\": [");
        ArrayList<String[]> responses = new ArrayList<String[]>();
        responses = db.doPreparedQuery("SELECT a.answer, COUNT(m.answerID), COUNT(p.answerID) FROM Answers a LEFT OUTER JOIN MultiResponses m ON m.answerID = a.answerID LEFT OUTER JOIN KeyResponses p ON p.answerID = a.answerID WHERE a.questID = ? GROUP BY m.answerID, a.answer ORDER BY a.answer", responseInput, responseTypes, responseCN, responseCP);

        //out.println("FUCKOFFF also, size=" + responses.size());

        for (int i = 0; i < responses.size(); i++){
            //out.println(responses.get(i)[1]);
            //out.println(responses.get(i)[2]);


            int temp = Integer.parseInt(responses.get(i)[1]) + Integer.parseInt(responses.get(i)[2]);
            out.print("[\"" + responses.get(i)[0] + "\"," + temp + "]");
            if (i == (responses.size() -1)) {
             out.print("]");
            } else {
                out.print(",");
            }
        }
        out.print("}");

    }
           
} else {
    out.print("{ \"error\": \"You are not currently logged in.\", \"redirect\":\"Login\"}");
}
%>
