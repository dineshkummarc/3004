<%@page import="java.sql.*" %>
<%@page import="java.util.ArrayList" %>
<jsp:useBean id="db" scope="session" class="db.database" /> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
if(db.accessCheck("creator") == 1) {
    out.print("{\"access\":\"OK\", ");
    String[] inputData = {request.getParameter("questID")};
    String[] inputTypes = {"string"};

    db.doPreparedExecute("DELETE FROM Questions WHERE questID=?", inputData, inputTypes);

    String[] answerInput = {request.getParameter("questID")};
    String[] answerInputTypes = {"string"};
    String[] answerColNames = {"AnswerID"};
    String[] answerColTypes = {"int"};


    ArrayList<String[]> Answers = db.doPreparedQuery("SELECT AnswerID FROM Answers"
            + " WHERE questID=?", answerInput, answerInputTypes, answerColNames, answerColTypes);
    for(int i=0; i != Answers.size(); i++) {
        String[] delData = {Answers.get(i)[0]};
        String[] delTypes = {"int"};
        db.doPreparedExecute("DELETE FROM Answers WHERE answerID=?", delData, delTypes);
    }

    // will also need to do a query on Answers for this questID and remove them too
    // do query on Answers, loop through result, get each AnswerID, delete it.

    out.print("\"status\": \"OK\"}");
} else {
    out.print("{\"access\":\"bad\"}");
}
%>

