<%-- 
    Document   : creator-addanswer
    Created on : 18/09/2011, 3:18:54 PM
    Author     : s4203658
--%>
<%@page import="java.sql.*" %>
<%@page import="java.util.ArrayList" %>
<jsp:useBean id="db" scope="session" class="db.database" /> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
if(db.accessCheck("creator") == 1) {
    out.print("{\"access\":\"OK\", ");
    String questID = request.getParameter("questID");
    String weight = request.getParameter("weight"); 
    String answer = request.getParameter("text");
    String keypad = request.getParameter("keypad");
    String correct = request.getParameter("correct");
    
    
    String insertAnswer = ("INSERT INTO Answers(answerID, keypad, answer, "
                    + "questID, correct) VALUES (aseq.nextval, ?, ?, ?, ?)");

    String[] insertAnswerInput = {keypad, answer, questID, correct};
    String[] insertAnswerTypes = {"string", "string", "int", "string"};
    db.doPreparedExecute(insertAnswer, insertAnswerInput, insertAnswerTypes);
    
    if(weight != null){
        String maxQID = "SELECT MAX(answerID) FROM Answers";
        String[] inputMaxQID = {};
        String[] inputMaxQIDTypes = {};
        String[] outputMaxQID = {"MAX(answerID)"};
        String[] outputMaxQIDTypes = {"int"};
        ArrayList<String[]> aid = db.doPreparedQuery(maxQID, inputMaxQID, inputMaxQIDTypes, outputMaxQID, outputMaxQIDTypes);
        
        String insertRanking = ("INSERT INTO Rankings(answerID, weight) VALUES" 
                + " (?, ?)");
        String[] insertRankingInput = {aid.get(0)[0], weight};
        String[] insertRankingTypes = {"int", "string"};
        db.doPreparedExecute(insertRanking, insertRankingInput, insertRankingTypes);
    }
    
    out.print("\"status\":\"OK\"}");
       } else {
            out.print("{\"access\":\"bad\"}");
       }
%>