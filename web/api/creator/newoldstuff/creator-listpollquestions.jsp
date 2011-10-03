<%@page import="java.sql.*" %>
<%@page import="java.util.ArrayList" %>
<jsp:useBean id="db" scope="session" class="db.database" /> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String[] inputData = {request.getParameter("pollID")};
String[] inputTypes = {"string"};
String[] colNames = {"questID", "demographic", "responseType", "question"};
String[] colType = {"int", "string", "string", "string"};

ArrayList<String[]> PollQuestions = db.doPreparedQuery("SELECT * FROM Questions"
        + " WHERE PollID=?", inputData, inputTypes, colNames, colType);

out.print(" {\"pollID\": " + "\"" + request.getParameter("pollID") + "\", \"questions\": [");

for(int i=0; i!= PollQuestions.size(); i++) {
    if(i != 0) {
        out.print(",");
    }
  out.print(" {\"questID\": \"" + PollQuestions.get(i)[0] + "\", "
           + "\"demographic\": \"" + PollQuestions.get(i)[1] + "\", " +
            "\"responseType\": \"" + PollQuestions.get(i)[2] + "\", " +
            "\"question\": \"" + PollQuestions.get(i)[3] + "\"} ");
            
}

out.print("]}");

%>