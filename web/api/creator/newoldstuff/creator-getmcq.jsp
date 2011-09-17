<%@page import="java.sql.*" %>
<%@page import="java.util.ArrayList" %>
<jsp:useBean id="db" scope="session" class="db.database" /> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String[] inputData = {request.getParameter("questID")};
String[] inputTypes = {"string"};
String[] colNames = {"pollID", "questID", "demographic", "responseType",
                        "question", "created", "font", "correctIndicator",
                        "chartType", "images", "creator", "location" };
String[] colType = {"int", "int", "string", "string", "string", "string",
                        "string", "string", "string", "string", "int", 
                        "string" };

ArrayList<String[]> MCQ = db.doPreparedQuery("SELECT * FROM Questions WHERE QuestID=?"
                            , inputData, inputTypes, colNames, colType);
out.print(" {\"pollID\": " + "\"" + MCQ.get(0)[0] + "\"" + 
           ", \"questID\": \"" + MCQ.get(0)[1] + "\", "
           + "\"demographic\": \"" + MCQ.get(0)[2] + "\", " +
            "\"responseType\": \"" + MCQ.get(0)[3] + "\", " +
            "\"question\": \"" + MCQ.get(0)[4] + "\", " +
            "\"created\": \"" + MCQ.get(0)[5] + "\", " +
            "\"font\": \"" + MCQ.get(0)[6] + "\", " + 
            "\"correctIndicator\": \"" + MCQ.get(0)[7] + "\", " +
            "\"chartType\": \"" + MCQ.get(0)[8] + "\", " +
            "\"images\": \"" + MCQ.get(0)[9] + "\", " +
            "\"creator\": \"" + MCQ.get(0)[10] + "\", " + 
            "\"location\": \"" + MCQ.get(0)[11] + "\"}");
%>
