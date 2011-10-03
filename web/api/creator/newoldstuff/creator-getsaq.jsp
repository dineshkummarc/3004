<%@page import="java.sql.*" %>
<%@page import="java.util.ArrayList" %>
<jsp:useBean id="db" scope="session" class="db.database" /> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String[] inputData = {request.getParameter("questID")};
String[] inputTypes = {"string"};
String[] colNames = {"pollID", "questID", "responseType", "question", "created",
                        "creator", "location" };
String[] colType = {"int", "int", "string", "string", "string", "string",
                        "string" };


ArrayList<String[]> SAQ = db.doPreparedQuery("SELECT * FROM Questions WHERE QuestID=?"
                            , inputData, inputTypes, colNames, colType);


out.print(" {\"pollID\": " + "\"" + SAQ.get(0)[0] + "\"" + 
           ", \"questID\": \"" + SAQ.get(0)[1] + "\", " +
           "\"responseType\": \"" + SAQ.get(0)[2] + "\", " + 
            "\"question\": \"" + SAQ.get(0)[3] + "\", " +
            "\"created\": \"" + SAQ.get(0)[4] + "\", " +
            "\"creator\": \"" + SAQ.get(0)[5] + "\", " + 
            "\"location\": \"" + SAQ.get(0)[6] + "\"}");

%>
