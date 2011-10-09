<%-- 
    Document   : creator-editquestion
    Created on : 18/09/2011, 2:47:33 PM
    Author     : dcf
--%>

<%@page import="java.sql.*" %>
<%@page import="java.util.ArrayList" %>
<jsp:useBean id="db" scope="session" class="db.database" /> 
<%
if(db.accessCheck("creator") == 1) {
    if (request.getParameter("id").equals("-1")) {
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

        out.print("{\"status\": \"OK, ADDED NEW\"}");
   } else {
        String compareTo = request.getParameter("compareTo"); 
        String responseType = request.getParameter("qformat");
        String questID = request.getParameter("id");
        String demographic = request.getParameter("demographic");
        String images = request.getParameter("image");

        String question = request.getParameter("text");

        int creator = db.getUserID();
        String font = request.getParameter("font");
        String chartType = request.getParameter("chart");
        String correctIndicator = request.getParameter("indicator");



        String updateQuestion = "UPDATE Questions SET demographic=?, responsetype=?,"
                + " question=?, font=?, correctindicator=?, charttype=?, images=? "
                + " WHERE questID=?";

        String[] updateQuestionInput = {demographic, responseType, question,
            font, correctIndicator, chartType, images, questID};
        String[] updateQuestionTypes = {"string", "string", "string", "string", "string",
            "string", "string", "int"};
        db.doPreparedExecute(updateQuestion, updateQuestionInput, updateQuestionTypes);

        if(compareTo != null && compareTo == "comparitive") {
            String[] comparativesInput = {questID, compareTo};
            String[] comparativesInputCols = {"int", "int"};

            String query= "INSERT INTO Comparitives(questID, compareTo) VALUES "
                    + "(?, ?)";
            db.doPreparedExecute(query, comparativesInput, comparativesInputCols);
        }

        out.print("{\"status\": \"OK, UPDATED\"}");
   }
} else {
    out.print("{\"access\":\"bad\"}");
}

%>