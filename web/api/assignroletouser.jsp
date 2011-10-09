<%-- 
    Document   : submitanswer-json
    Created on : 15/08/2011, 9:34:53 AM
    Author     : Aidan Rowe
--%>
<%-- NOTE: need ot make it return the results from a quesiton that has been submitted --%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="db" scope="session" class="db.database" /> 
<%@ page import = "java.util.ArrayList" %>

<%
/* Allows user to submit answer from a question and returns statistics from other users
 * answers.  
 * 
 * @require User must be logged in to access this API (session variable must be set)
 * @return JSON file with information polls assigned to user
 */
String username = request.getParameter( "username" );
String pollid = request.getParameter( "pollid" );
String role = request.getParameter( "role" );

//if (null != user && !user.equals( "" )) {
if (db.getLoggedIn() == 1) {
    //out.println("THIS IS THE USER ID" + userID + " <br/>");
    if (username == "" || pollid == "" || role == "" || username == null || pollid == null || role == null) {
        out.print("{ \"error\": \"Invalid query sent.\"}");                
    } else {             
        String input[] = new String[1];
        input[0] = username;

        String inputT[] = new String[1];
        inputT[0] = "string";

        String outputCN[] = new String[1];
        outputCN[0] = "userid";
        
        String outputCT[] = new String[1];
        outputCT[0] = "int";

        ArrayList<String[]> userid = new ArrayList<String[]>();
        userid = db.doPreparedQuery("SELECT userid from Users where username=?", input, inputT, outputCN, outputCT);
        
        String userID = userid.get(0)[0];
        
        String inputs[] = new String[2];
        inputs[0] = userID;
        inputs[1] = pollid;
        
        String types[] = new String[2];
        types[0] = "int";
        types[1] = "string";
        
        String value = db.doPreparedExecute("DELETE FROM Assigned WHERE userID = ? and pollID = ?", inputs, types);
        
        input[] = new String[3];
        
        
        value = db.doPreparedExecute("INSERT INTO Assigned(userID, pollID, role) values (?, ?, ?)", inputs, types);
        
    }
                
} else {
    out.print("{ \"error\": \"You are not currently logged in.\", \"redirect\":\"Login\"}");
}
%>
