<%@page import="java.sql.*" %>
<%@page import="java.util.ArrayList" %>
<jsp:useBean id="db" scope="session" class="db.database" /> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String[] inputData = {request.getParameter("questID")};
String[] inputTypes = {"string"};
String[] colNames = {"answerID", "keypad", "answer", "correct"};
String[] colType = {"int", "string", "string", "string"};

ArrayList<String[]> MCQAnswers = db.doPreparedQuery("SELECT * FROM Answers"
        + " WHERE QuestID=?", inputData, inputTypes, colNames, colType);
out.print(" {\"questID\": " + "\"" + request.getParameter("questID") + "\", \"answers\": [");

for(int i=0; i!= MCQAnswers.size(); i++) {
    if(i != 0) {
        out.print(",");
    }
  out.print(" {\"answerID\": \"" + MCQAnswers.get(i)[0] + "\", "
           + "\"keypad\": \"" + MCQAnswers.get(i)[1] + "\", " +
            "\"answer\": \"" + MCQAnswers.get(i)[2] + "\", " +
            "\"correct\": \"" + MCQAnswers.get(i)[3] + "\"} ");
            
}

out.print("]}");

%>
