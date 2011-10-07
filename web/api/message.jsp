<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<jsp:useBean id="db" scope="session" class="db.database" /> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String[] Months = {"01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"};
String type = request.getParameter("type");
String query = "";
Date now = new Date();
Calendar calendar = new GregorianCalendar(); // to get year in 20xx format
calendar.setTime(now);
String thisYear = Integer.toString(calendar.get(Calendar.YEAR)); // convert int to string
String user = Integer.toString(db.getUserID());
if(type.equals("get")){
    
    String pollID = request.getParameter("pollID");
    
    // below for query
    String columnTypes[] = {"int", "string", "string", "timestamp", "string"};
    String jsonName[] = {"msgID", "message" , "from", "time", "isRead"};
    String columnNames[] = {"msgID", "message" , "fromUser", "created", "isRead"};
   
    long thirtyMins_IN_MS = 1000 * 60 * 30;
    Date temp = new Date(now.getTime() - thirtyMins_IN_MS); // get date for the last 7days
    String tempDate = temp.getDate() + "/" + Months[temp.getMonth()] + "/" + thisYear; 
    tempDate += " " + temp.getHours() + ":" + temp.getMinutes() + ":" + temp.getSeconds();
    out.print(tempDate);
    String input[] = {user, pollID, tempDate};
    String types[] = {"int", "int",  "string"}; // assume the db is still using id as pk.
    query = "SELECT msgID, fromUser, message, created, isRead FROM Messages WHERE toUser=? OR toUser=-1 "
            + " AND pollID=? AND isRead='F' AND created > to_date(?, 'dd/mm/yyyy HH24:MI:SS') ORDER BY created"; // get message for last 7 days
    String data = db.doPreparedQueryAndy(query, input, types, columnNames, columnTypes, jsonName);
    out.println(data);
    
}
else if(type.equals("send")){
    String to = "";
    String sType = request.getParameter("sType");
    String pollID = request.getParameter("pollID");
    String from = user; // should get fromUser from session, see next line
    //String from = (String)session.getAttribute("user");
    if(sType.equals("private")){
        to = request.getParameter("to");
    }
    else{
        to = "-1";
    }
    String tempDate = now.getDate() + "/" + Months[now.getMonth()] + "/" + thisYear; 
    tempDate += " " + now.getHours() + ":" + now.getMinutes() + ":" + now.getSeconds();
    out.print(tempDate);
    String message = request.getParameter("message");
    String input[] = {pollID, from, to, tempDate, message};
    String types[] = {"int", "int", "int", "string", "string"}; // assume the db is still using id as pk.
    query = "INSERT INTO Messages(msgID, pollID, fromUser, toUser, created, message, isRead) "
            + "VALUES (mseq.nextval, ?, ?, ?, to_date(?, 'dd/mm/yyyy HH24:MI:SS'), ?, 'F')";
    String data = db.doPreparedExecute(query, input, types);
    String status = "[{\"status\": \"" + data + "\"}]";
    out.print(status);
}

else if(type.equals("read")){
    
    String msgID = request.getParameter("msgID");
    String input[] = {"T", msgID};
    String types[] = {"string", "int"};
    query = "UPDATE Messages SET isRead=? WHERE msgID=?"; //msgID is pk
    String data = db.doPreparedExecute(query, input, types);
    out.print(data);
}
/*
else if(type.equals("delete")){
    
    String msgID = request.getParameter("msgID");
    String input[] = {msgID};
    String types[] = {"int"};
    query = "DELETE FROM Messages WHERE msgID=?"; //msgID is pk
    String data = db.doPreparedExecute(query, input, types);
    out.print(data);
}
 */


%>
