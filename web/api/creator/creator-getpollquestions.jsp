<%-- 
    Document   : creator-getpollquestions
    Created on : 17/09/2011, 12:22:01 PM
    Author     : dcf
--%>
<%@page import="java.sql.*" %>
<%@page import="java.util.ArrayList" %>
<jsp:useBean id="db" scope="session" class="db.database" /> 

<% 
if(db.accessCheck("creator") == 1) {
    out.print("{\"access\":\"OK\", ");
    String[] inputData = {request.getParameter("id")};
    String[] inputTypes = {"int"};
    String[] outputCols = {"questID", "demographic", "responseType", "question",
                                "created", "font", "correctIndicator", "chartType",
                                "images", "creator"};
    String[] outputTypes = {"int", "string", "string", "string", "string",
                                "string", "string", "string", "string", "int"};
    
    

    String query= "SELECT * FROM Questions WHERE PollID=?";
    System.err.println("getting results...");
    ArrayList<String[]> results = db.doPreparedQuery(query, inputData, inputTypes,
                                                outputCols, outputTypes);
    System.err.println("got results");
    
    
    
    if(results != null){
        out.print("\"questions\": ");
            out.print("[");
            for(int i=0; i<results.size();i++) {
                // another query to get comparative qn if there is one...
                String[] compInputData = {results.get(i)[0]};
                String[] compInputTypes = {"int"};
                String[] compOutputCols = {"questID", "compareTo"};
                String[] compOutputTypes = {"int", "int"};
                ArrayList<String[]> comparative = db.doPreparedQuery("SELECT * FROM Comparitives WHERE questID=?",
                        compInputData, compInputTypes, compOutputCols, compOutputTypes);

                out.print("{");
                out.print("\"id\": " + results.get(i)[0] + ",");
                if(comparative.size() != 0) {
                out.print("\"compareTo\": \"" + comparative.get(0)[1] + "\",");
                } else {
                out.print("\"compareTo\": \"\",");
                }
                out.print("\"demographic\": \"" + results.get(i)[1] + "\",");
                out.print("\"responseType\": \"" + results.get(i)[2] + "\",");
                out.print("\"text\": \"" + results.get(i)[3]  + "\",");
                out.print("\"created\": \"" + results.get(i)[4]  + "\",");
                out.print("\"font\": \"" + results.get(i)[5]  + "\",");
                out.print("\"indicator\": \"" + results.get(i)[6]  + "\",");
                out.print("\"chart\": \"" + results.get(i)[7]  + "\",");
                out.print("\"image\": \"" + results.get(i)[8] + "\",");
                out.print("\"creator\": " + results.get(i)[9] + ",");
                out.print("\"responses\": [");
                
                String[] answersInputData = {request.getParameter("id")};
                String[] answersInputTypes = {"string"};
                String[] answersOutputCols = {"answerID", "keypad", "answer", "questID", "correct", "weight"};
                String[] answersOutputTypes = {"string", "string", "string", "string", "string", "string"};
                
                ArrayList<String[]> results_Answer = db.doPreparedQuery("SELECT * FROM Answers  WHERE questID=?",
                        answersInputData, answersInputTypes, answersOutputCols, answersOutputTypes);        
                
                /* check  this one*/

                    /* below needs to be modified*/
                    if(results_Answer != null){
                            for (int j=0; j<results_Answer.size(); j++) {
                                out.print("{"); 
                                    out.print("\"id\": " + results_Answer.get(j)[0] + ",");
                                    out.print("\"keypad\": \"" + results_Answer.get(j)[1] + "\",");
                                    out.print("\"text\": \"" + results_Answer.get(j)[2] + "\",");
                                    out.print("\"questionID\": " + results_Answer.get(j)[3] + ",");
                                    out.print("\"correct\": \"" + results_Answer.get(j)[4]  + "\",");
                                    out.print("\"weight\": " + results_Answer.get(j)[5]);
                                    out.print("}");
                                    if((j+1) != results_Answer.size()){
                                        out.print(",");
                                    }
                            }

                    }
                    else{
                            out.print("\"No Answers\"");
                    }
                    out.print("]");
                    out.print("}");
                    if((i+1) != results.size()){
                        out.print(",");

                    }
            }
            out.print("]");
            out.print("}");
    }
    else {
            out.print("{");
            out.print("Status: " + "error" + ",");
            out.print("Error: " + "Poll ID does not exist, pick a existing one");
            out.print("}");
    }
} else {
    out.print("{\"access\":\"bad\"}");
}


%>
