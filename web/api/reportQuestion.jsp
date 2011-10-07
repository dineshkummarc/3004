<jsp:useBean id="db" scope="session" class="db.database" /> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
//question
String pollID = request.getParameter("pollID");
        if(pollID!=null || !pollID.equals("")){
            
            String input[] = {pollID};
            String types[] = {"int"};
            String columnNames[] = {"questID", "question"};
            String columnTypes[] = {"int", "string"};
            String query = "SELECT questID, question FROM Questions "
                + "WHERE pollID=?  AND demographic='T'";
            String jsonName[] = {"questID", "Question"};
            String data = db.doPreparedQueryAndy(query, input, types, columnNames, columnTypes, jsonName);
            out.println(data);
        }
       

%>