<%-- 
    Document   : clicker-getpolls.jsp
    Created on : 02/10/2011, 11:28:34 AM
    Author     : Aidan Rowe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="db" scope="session" class="db.database" /> 
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.Date,java.text.SimpleDateFormat,java.text.ParseException" %>


<%
/* Returns a list of all the polls a web use rhas been assigned to 
 * including their pollID, pollname, description, startDate, finishDate
 * and their status.
 * 
 * @require User must be logged in to access this API (session variable must be set)
 * @return JSON file with information polls assigned to user
 */
    
String userID = request.getParameter("userid");

//out.println(db.getUserLevel());

        //Prepare the inputs, types, columnNames and columnTypes which are going to be returned
        String inputs[];
        inputs = new String[1];
        inputs[0] = userID;

        String types[];
        types = new String[1];
        types[0] = "int";

        String columnNames[];
        columnNames = new String[6];
        columnNames[0] = "pollID";
        columnNames[1] = "pollName";
        columnNames[2] = "description";
        columnNames[3] = "startDate";
        columnNames[4] = "finishDate";
        columnNames[5] = "status";

        String columnTypes[];
        columnTypes = new String[6];
        columnTypes[0] = "int";
        columnTypes[1] = "string";
        columnTypes[2] = "string";
        columnTypes[3] = "string";
        columnTypes[4] = "string";
        columnTypes[5] = "string";
        
        ArrayList<String[]> pastPolls = new ArrayList<String[]>();
        pastPolls = db.doPreparedQuery("SELECT p.pollID, p.pollName, p.description, to_char((p.startDate), 'yyyy-mm-dd HH24:MI:SS') AS startDate, to_char((p.finishDate), 'yyyy-mm-dd HH24:MI:SS') AS finishDate, a.status from Assigned a INNER JOIN Polls p ON a.pollID = p.pollID WHERE a.userID = ? AND p.finishDate <= LOCALTIMESTAMP ORDER BY p.startDate", inputs, types, columnNames, columnTypes);
        
        out.print("{ \"past\": [ ");
        
        for ( int i = 0; i  < pastPolls.size(); i++) {
            out.print("{");
            out.print("\"id\": " + pastPolls.get(i)[0] + ", ");
            out.print("\"name\": \"" + pastPolls.get(i)[1] + "\", ");
            out.print("\"description\": \"" + pastPolls.get(i)[2] + "\", ");
            out.print("\"startDate\": \"" + pastPolls.get(i)[3] + "\", ");
            out.print("\"finishDate\": \"" + pastPolls.get(i)[4] + "\", ");
            out.print("\"completed\": \"" + pastPolls.get(i)[5] + "\"");
            if (i == (pastPolls.size() -1)) {
                out.print("}");
            } else {
                out.print("},");
            }
        }
        
        out.print("], \"future\": [");
        
        ArrayList<String[]> futurePolls = new ArrayList<String[]>();
        futurePolls = db.doPreparedQuery("SELECT p.pollID, p.pollName, p.description, to_char((p.startDate), 'yyyy-mm-dd HH24:MI:SS') AS startDate, to_char((p.finishDate), 'yyyy-mm-dd HH24:MI:SS') AS finishDate, a.status from Assigned a INNER JOIN Polls p ON a.pollID = p.pollID WHERE a.userID = ? AND p.startDate >= LOCALTIMESTAMP ORDER BY p.startDate", inputs, types, columnNames, columnTypes);
        
        for ( int i = 0; i  < futurePolls.size(); i++) {
            out.print("{");
            out.print("\"id\": " + futurePolls.get(i)[0] + ", ");
            out.print("\"name\": \"" + futurePolls.get(i)[1] + "\", ");
            out.print("\"description\": \"" + futurePolls.get(i)[2] + "\", ");
            out.print("\"startDate\": \"" + futurePolls.get(i)[3] + "\", ");
            out.print("\"finishDate\": \"" + futurePolls.get(i)[4] + "\", ");
            out.print("\"completed\": \"" + futurePolls.get(i)[5] + "\"");
            if (i == (futurePolls.size() -1)) {
                out.print("}");
            } else {
                out.print("},");
            }
        }

        out.print("], \"present\": [");
        
        ArrayList<String[]> currentPolls = new ArrayList<String[]>();
        currentPolls = db.doPreparedQuery("SELECT p.pollID, p.pollName, p.description, to_char((p.startDate), 'yyyy-mm-dd HH24:MI:SS') AS startDate, to_char((p.finishDate), 'yyyy-mm-dd HH24:MI:SS') AS finishDate, a.status from Assigned a INNER JOIN Polls p ON a.pollID = p.pollID WHERE a.userID = ? AND p.startDate <= LOCALTIMESTAMP AND p.finishDate >= LOCALTIMESTAMP ORDER BY p.startDate", inputs, types, columnNames, columnTypes);
        
        for ( int i = 0; i  < currentPolls.size(); i++) {
            out.print("{");
            out.print("\"id\": " + currentPolls.get(i)[0] + ", ");
            out.print("\"name\": \"" + currentPolls.get(i)[1] + "\", ");
            out.print("\"description\": \"" + currentPolls.get(i)[2] + "\", ");
            out.print("\"startDate\": \"" + currentPolls.get(i)[3] + "\", ");
            out.print("\"finishDate\": \"" + currentPolls.get(i)[4] + "\", ");
            out.print("\"completed\": \"" + currentPolls.get(i)[5] + "\"");
            if (i == (currentPolls.size() -1)) {
                out.print("}");
            } else {
                out.print("},");
            }
        }
        
        out.print("] }");
%>