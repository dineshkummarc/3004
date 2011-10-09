<%-- 
    Document   : creator-editanswer
    Created on : 18/09/2011, 4:51:54 PM
    Author     : dcf
--%>

<%@page import="java.sql.*" %>
<%@page import="java.util.ArrayList" %>
<jsp:useBean id="db" scope="session" class="db.database" /> 
<%
if(db.accessCheck("creator") == 1) {
    if (request.getParameter("id").equals("-1")) {
        String questID = request.getParameter("questionID");
        String weight = request.getParameter("weight"); 
        String answer = request.getParameter("text");
        String keypad = request.getParameter("keypad");
        String correct = request.getParameter("correct");


        String insertAnswer = ("INSERT INTO Answers(answerID, answer, "
                        + "questID, correct) VALUES (aseq.nextval,  ?, ?, ?)");

        String[] insertAnswerInput = {keypad, answer, questID, correct};
        String[] insertAnswerTypes = {"string", "int", "string"};
        String status = db.doPreparedExecute(insertAnswer, insertAnswerInput, insertAnswerTypes);


        out.print("{\"status\": \"" + status + "\"}");
    } else {
        String answerID = request.getParameter("id");
        String weight = request.getParameter("weight"); 
        String answer = request.getParameter("text");
        String keypad = request.getParameter("keypad");
        if(keypad.equals("NULL")){
            keypad = "n";
        }
        if(weight.equals("NULL")){
            weight = "1";
        }
        String correct = request.getParameter("correct");

        String updateAnswer = "UPDATE Answers SET keypad=?, answer=?, "
                + "correct=?, weight=? WHERE answerID=?";

        String[] updateAnswerInput = {keypad, answer, correct, weight, answerID};
        String[] updateAnswerTypes = {"string", "string", "string", "int", "int"};
        String status = db.doPreparedExecute(updateAnswer, updateAnswerInput, updateAnswerTypes);



        out.print("{\"status\": \"" + status + "\"}");
   }
} else {
    out.print("{\"access\":\"bad\"}");
}

%>