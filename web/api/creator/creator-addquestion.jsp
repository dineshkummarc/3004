<%-- 
    Document   : creator-addquestion
    Created on : 18/09/2011, 1:51:35 PM
    Author     : dcf
--%>
<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.ArrayList" %>
<jsp:useBean id="db" scope="session" class="db.database" /> 
<%
    String compareTo = request.getParameter("compareTo"); 
    String pollID = request.getParameter("pollID");
    String responseType = request.getParameter("qformat");
    //String questID = request.getParameter("id");
    String demographic = request.getParameter("demographic");
    String images = request.getParameter("image");
    /* String created = request.getParameter("created"); */
    String question = request.getParameter("text");
    /* for demo only*/
    int creator = db.getUserID();
    String font = request.getParameter("font");
    String chartType = request.getParameter("chart");
    String correctIndicator = request.getParameter("indicator");
    
    
        
    String insertQuestion = ("INSERT INTO "
            + "Questions(questid, demographic, responsetype, question, "
            + "pollid, created, font, correctindicator, charttype, images, "
            + "creator) VALUES (qseq.nextval, ?, ?, ?, ?, SYSDATE, ?, ?, ?, ?, ?)");

    String[] insertQuestionInput = {demographic, responseType, question,
        pollID, font, correctIndicator, chartType, images, Integer.toString(creator)};
    String[] insertQuestionTypes = {"string", "string", "string",
        "int", "string", "string", "string", "string", "int"};
    db.doPreparedExecute(insertQuestion, insertQuestionInput, insertQuestionTypes);
    
    if(compareTo != null && compareTo == "comparitive") {
        String maxQID = "SELECT MAX(questID) FROM Questions";
        String[] inputMaxQID = {};
        String[] inputMaxQIDTypes = {};
        String[] outputMaxQID = {"MAX(questID)"};
        String[] outputMaxQIDTypes = {"int"};
        ArrayList<String[]> qid = db.doPreparedQuery(maxQID, inputMaxQID, inputMaxQIDTypes, outputMaxQID, outputMaxQIDTypes);
        
        String[] comparativesInput = {compareTo};
        String[] comparativesInputCols = {"int"};
        
        String query= "INSERT INTO Comparitives(questID, compareTo) VALUES "
                + "(" + qid.get(0)[0] + ", ?)";
        db.doPreparedExecute(query, comparativesInput, comparativesInputCols);
    }
    
    out.print("{\"status\": \"OK\"}");

%>