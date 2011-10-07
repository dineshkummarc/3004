<jsp:useBean id="db" scope="session" class="db.database" /> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
//Answers
   
        String questID = request.getParameter("questID");
        if(questID!=null || !questID.equals("")){
            
            String input[] = {questID};
            String types[] = {"int"};
            String columnNames[] = {"answerID", "answer"};
            String columnTypes[] = {"int", "string"};
            String query = "SELECT answerID, answer FROM Answers " 
                    + "WHERE questID=?";
            String jsonName[] = {"answerID", "Answer"};
            String data = db.doPreparedQueryAndy(query, input, types, columnNames, columnTypes, jsonName);
            out.println(data);
        }
    

%>