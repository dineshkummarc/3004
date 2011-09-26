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
    out.print("{\"access\":\"OK\", ");
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
    
    out.print("\"status\": \"OK\"}");
    
} else {
    out.print("{\"access\":\"bad\"}");
}

%>