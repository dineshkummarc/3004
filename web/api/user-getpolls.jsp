<%-- INDIVIDUAL DARREN
    Document   : geolocation
    Created on : 12/08/2011, 7:13:37 PM
    Author     : Darren
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="database.*"%>
<%@page import="java.text.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="db" scope="session" class="db.database" /> 

<%
try{
	if(db.accessCheck("sysadmin") == 0 {
		out.println("{"};
		out.println("\"access\": \"OK\"")
		out.println("}");
		String dataID = String.valueOf(db.getUserID());
		String query = "SELECT pollID, pollName FROM polls WHERE polls.pollID IN (SELECT pollID FROM assigned WHERE userID=?)";
		String[] values = {dataID};
		String[] types = {"int"};
		String[] columnNames = {"pollID", "pollName"};
		String[] columnValues = {"int", "string"};
		ArrayList<String[]> results = db.doPreparedQuery(query, values, types, columnNames, columnValues);
		
		if (results.size() == 0) {
			out.println("{");
			out.println("\"error\": " + "\"none assigned\"");
			out.println("}");
		} else {
			String printString = "[";
			for (String[] s : results) {
				if (!printString.equals("[")) {
					printString = printString + ", ";
				}
				printString = printString + ("{\"pollID\" : " + s[0] + ", \"pollName\" : \"" + s[1] + "\"}");
			}
			printString = printString + "]";
			out.print(printString);
		}
	} else {
		out.println("{"};
		out.println("\"access\": \"bad\"")
		out.println("}");
	}
} catch(Exception e){
    out.write(e.toString());
}

%>