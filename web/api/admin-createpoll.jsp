<%-- 
    Document   : createpoll-json
    Created on : 28/07/2011, 8:22:20 PM
    Author     : David
--%>
<%@page import="java.sql.*" %>
<%@page import="java.util.ArrayList" %>
<jsp:useBean id="db" scope="session" class="db.database" /> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if(db.accessCheck("polladmin") == 1) {
	out.print("{\"access\":\"OK\", ");
	if(request.getParameter("pollName").length() == 0) {
	    out.print("\"status\": \"You cannot enter an empty poll name.\" } ");
	} else {
	    out.print("\"status\": \"OK\", ");

	    String[] array = {request.getParameter("pollName"), request.getParameter("description"), request.getParameter("start"), request.getParameter("finish")};
	    String[] types = {"string", "string", "string", "string"};


	    db.doPreparedExecute("INSERT INTO Polls(PollID, Pollname, description, startDate, finishDate) VALUES (pseq.nextval, ?, ?, ?, ?)", array,types);

	    ArrayList<String[]> maxPoll = new ArrayList<String[]>();
	    String[] a1 = {};
	    String[] a2 = {};
	    String[] getColumnName = {"MAX(PollID)"};
	    String[] getColumnType = {"int"};
	    maxPoll = db.doPreparedQuery("SELECT MAX(PollID) FROM Polls", a1, a2, getColumnName, getColumnType);

	    String[] pollArray = {maxPoll.get(0)[0]};
	    String[] pollTypes = {"int"};
	    String[] pollCols = {"PollID", "Pollname"};
	    String[] pollColTypes = {"int", "string"};
	    ArrayList<String[]> polls = new ArrayList<String[]>();
	    polls = db.doPreparedQuery("SELECT * FROM Polls WHERE PollID=?", pollArray, pollTypes, pollCols, pollColTypes);

	    for(int i=0; i<polls.size(); i++) {
		out.print("\"poll\": {\"pollID\": " + Integer.parseInt(polls.get(i)[0])
			+ ", \"pollName\": \"" + polls.get(i)[1] +
			"\", \"pollCreators\": [" );
		String[] pclinkCols = {"userID", "userName"};
		String[] pclinkColTypes = {"int", "string"};
		ArrayList<String[]> pclink = new ArrayList<String[]>();
		pclink = db.doPreparedQuery("SELECT * FROM Users pcs WHERE pcs.userID IN (SELECT "
				     + "UserID FROM PollCreatorLink WHERE PollID=?) ",
				     pollArray, pollTypes, pclinkCols, pclinkColTypes);
		for(int c=0; c<pclink.size(); c++) {
		    if(c > 0) {
			out.print(",");  
		    }
		    out.print("\"" + pclink.get(c)[1] + "\"");
		}
		out.print("]}}");
	    } 
	} 
    } else {
	out.print("{\"access\":\"bad\"} ");
    }
%>
