<%-- 
    Document   : creator-editanswer
    Created on : 18/09/2011, 4:51:54 PM
    Author     : dcf
--%>

<%@page import="java.sql.*" %>
<%@page import="java.util.ArrayList" %>
<jsp:useBean id="db" scope="session" class="db.database" /> 
<%
    String answerID = request.getParameter("answerID");
    String weight = request.getParameter("weight"); 
    String answer = request.getParameter("text");
    String keypad = request.getParameter("keypad");
    String correct = request.getParameter("correct");
        
    String updateAnswer = "UPDATE Answers SET keypad=?, answer=?, "
            + "correct=? WHERE answerID=?";
    
    String[] updateAnswerInput = {keypad, answer, correct, answerID};
    String[] updateAnswerTypes = {"string", "string", "string", "int"};
    db.doPreparedExecute(updateAnswer, updateAnswerInput, updateAnswerTypes);
    
    if(weight != null) {
        
        
        String[] rankingInputCols = {"int", "int"};
        
        String[] checkCols = {answerID};
        String[] checkType = {"int"};
        String query = new String();
        ArrayList<String[]> check = db.doPreparedQuery("SELECT answerID FROM Rankings WHERE answerID=?", checkCols, checkType, checkCols, checkType);
        
        if(check.isEmpty()) {
            String[] rankingInput = {answerID, weight};
            query = "INSERT INTO Rankings(answerID, weight) VALUES (?, ?)";
            db.doPreparedExecute(query, rankingInput, rankingInputCols);
        } else {
            String[] rankingUpdateInput = {weight, answerID};
            query = "UPDATE Rankings SET weight=? WHERE answerID=?";
            db.doPreparedExecute(query, rankingUpdateInput, rankingInputCols);
        }
        
       
    }
    
    out.print("{\"status\": \"OK\"}");

%>