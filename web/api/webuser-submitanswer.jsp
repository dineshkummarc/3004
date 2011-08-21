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
//String user = request.getParameter( "user" );
String questionID = request.getParameter( "qid" );
String answerID = request.getParameter( "aid" );
String answer = request.getParameter( "a" );

//if (null != user && !user.equals( "" )) {
if (db.getLoggedIn() == 1) {
    String userID = Integer.toString(db.getUserID());
    //out.println("THIS IS THE USER ID" + userID + " <br/>");
    if (questionID.equals("") || questionID == "") {
        out.print("{ \"error\": \"Invalid question ID.\"}");                
    } else {
        String answers[];               
        String types[];
        String inputs[];
        
        String types2[];
        String inputs2[];

        String value = null;
        
        if (answerID != null) {
            answers = answerID.split(",");               
        
            types = new String[2];
            types[0] = "int";
            types[1] = "int";
            
            inputs = new String[2];
            inputs[0] = userID;
            inputs[1] = questionID;
            
            types2 = new String[3];
            types2[0] = "int";
            types2[1] = "int";
            types2[2] = "int";
            
            inputs2 = new String[3];
            inputs2[0] = userID;
            inputs2[1] = questionID;

            value = null;

            value = db.doPreparedExecute("DELETE FROM Responses WHERE userID = ? and questID = ?", inputs, types);
            value = db.doPreparedExecute("DELETE FROM MultiResponses WHERE userID = ? and questID = ?", inputs, types);
            
            value = null;
            
            value = db.doPreparedExecute("INSERT into Responses(userID, questID) values (?, ?)", inputs, types);
            for (int i = 0; i < answers.length; i++) {
                value = null;
                inputs2[2] = answers[i];
                
                
                value = db.doPreparedExecute("INSERT into MultiResponses(userID, questID, answerID) values (?, ?, ?)", inputs2, types2);


            }
            if (value.equals("Failed!")) {              
                out.print("{ \"error\": \"Submission failed due to incorrect parameteres\"}");  
            } else {
                out.print("{ \"status\": \"OK\",");
                
                
                String responseInput[] = new String[1];
                responseInput[0] = questionID;

                String responseTypes[] = new String[1];
                responseTypes[0] = "int";

                String responseCN[] = new String[2];
                responseCN[0] = "answer";
                responseCN[1] = "COUNT(m.answerID)";

                String responseCP[] = new String[2];
                responseCP[0] = "string";
                responseCP[1] = "int";

                out.print("\"responses\": [");
                ArrayList<String[]> responses = new ArrayList<String[]>();
                responses = db.doPreparedQuery("SELECT m.answerID, a.answer, COUNT(m.answerID) FROM Answers a LEFT OUTER JOIN MultiResponses m ON m.answerID = a.answerID WHERE a.questID = ? GROUP BY m.answerID, a.answer ORDER BY a.answer", responseInput, responseTypes, responseCN, responseCP);
                
                for (int i = 0; i < responses.size(); i++){
                    out.print("[\"" + responses.get(i)[0] + "\"," + responses.get(i)[1] + "]");
                    if (i == (responses.size() -1)) {
                     out.print("]");
                    } else {
                        out.print(",");
                    }
                }
                out.print("}");
                
            }
            
        } else if (!answer.equals("") && answer != null) {
            types = new String[2];
            types[0] = "int";
            types[1] = "int";
            
            inputs = new String[2];
            inputs[0] = userID;
            inputs[1] = questionID;
            
            
            value = null;

            value = db.doPreparedExecute("DELETE FROM Responses WHERE userID = ? and questID = ?", inputs, types);
            value = db.doPreparedExecute("DELETE FROM ShortResponses WHERE userID = ? and questID = ?", inputs, types);
            
            value = null;
            
            value = db.doPreparedExecute("INSERT into Responses(userID, questID) values (?, ?)", inputs, types);                                
                             
            types2 = new String[3];
            types2[0] = "int";
            types2[1] = "int";
            types2[2] = "string";
            
            inputs2 = new String[3];
            inputs2[0] = userID;
            inputs2[1] = questionID;
            inputs2[2] = answer;

            value = null;
            value = db.doPreparedExecute("INSERT into ShortResponses(userID, questID, response) values (?, ?, ?)", inputs2, types2);

            if (value.equals("Failed!")) {              
                out.print("{ \"error\": \"Submission failed due to incorrect parameteres\"}");  
            } else {
                out.print("{ \"status\": \"OK\"}");
                
                
                
            }
        } else {
            out.print("{ \"error\": \"Invalid answer ID.\"}");
        } 
        
        value = null;
        String inputsCount[] = new String[1];
        inputsCount[0] = questionID;
  
        String typesCount[] = new String[1];
        typesCount[0] = "int";
        
        String columnNames[] = new String[1];
        columnNames[0] = "count(*)";
        
        String columnTypes[] = new String[1];
        columnTypes[0] = "int";
 
        
        ArrayList<String[]> completeCheck1 = new ArrayList<String[]>();
        completeCheck1 = db.doPreparedQuery("SELECT COUNT(*) FROM Questions q1, Questions q2 WHERE q1.pollID = q2.pollID AND q2.questID = ?", inputsCount, typesCount, columnNames, columnTypes);
        
        String inputsCount2[] = new String[2];
        inputsCount2[0] = questionID;
        inputsCount2[1] = userID;
  
        String typesCount2[] = new String[2];
        typesCount2[0] = "int";
        typesCount2[1] = "int";
        
        String columnNames2[] = new String[1];
        columnNames2[0] = "count(*)";
        
        String columnTypes2[] = new String[1];
        columnTypes2[0] = "int";
        
        ArrayList<String[]> completeCheck2 = new ArrayList<String[]>();
        completeCheck2 = db.doPreparedQuery("SELECT COUNT(*) FROM Questions q1, Questions q2, Responses r WHERE q2.questID = ? AND q1.pollID = q2.pollID AND r.userID = ? AND r.questID = q1.questID", inputsCount2, typesCount2, columnNames2, columnTypes2);
        
        int totalQ = Integer.parseInt(completeCheck1.get(0)[0]);
        int answeredQ = Integer.parseInt(completeCheck2.get(0)[0]);
        System.out.println("TotalQ  =" + totalQ);
        System.out.println("answeredQ  =" + answeredQ);
        
        if (totalQ == answeredQ) {
            
            
        String i1[] = new String[1];
        i1[0] = questionID;
  
        String t1[] = new String[1];
        t1[0] = "int";
        
        String cn1[] = new String[1];
        cn1[0] = "pollID";
        
        String ct1[] = new String[1];
        ct1[0] = "int";    
            
        ArrayList<String[]> pollretrieval = new ArrayList<String[]>();
        pollretrieval = db.doPreparedQuery("SELECT pollID from Questions where questID = ?", i1, t1, cn1, ct1);
            
            String types3[];
            types3 = new String[2];
            types3[0] = "int";
            types3[1] = "int";
            
            String inputs3[];
            inputs3 = new String[2];
            inputs3[0] = userID;
            inputs3[1] = pollretrieval.get(0)[0];
            ///this nees to use the questID not the pollID
            String check = null;
            System.out.println("UPDATING THE STATUS");
            check = db.doPreparedExecute("UPDATE Assigned SET status = 'true' WHERE userID = ? and pollID = ?", inputs3, types3);
        }
        
    }
} else {
    out.print("{ \"error\": \"You are not currently logged in, Why are you here?\"}");
}
%>
