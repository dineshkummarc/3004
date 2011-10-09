<jsp:useBean id="db" scope="session" class="db.database" /> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

String pollID = request.getParameter("pollID"); 
String input[] = {pollID};
String types[] = {"int"};
String columnNames[] = {"userID", "userName"};
String columnTypes[] = {"int", "string"};
String query = "SELECT Distinct u.userName"
                    + ", u.userID FROM Users u, Responses r, Questions q"
                    + " WHERE q.pollID=? AND q.questID=r.questID AND u.userID=r.userID";
String jsonName[] = {"userID", "UserName"};
String data = db.doPreparedQueryAndy(query, input, types, columnNames, columnTypes, jsonName);
out.println(data);

%>