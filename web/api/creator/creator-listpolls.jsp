<%@page import="java.sql.*" %>
<%@page import="java.util.ArrayList" %>
<jsp:useBean id="db" scope="session" class="db.database" /> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

String[] pollInput = {db.getUsername()};
String[] pollInputTypes = {"string"};
String[] pollColNames = {"PollID"};
String[] pollColTypes = {"int"};

//System.err.println("USERNAME: " + db.getUsername());

ArrayList<String[]> Polls = db.doPreparedQuery("SELECT PollID FROM PollCreatorLink"
        + " WHERE UserID=(SELECT UserID FROM Users WHERE userName=?)", pollInput, pollInputTypes, pollColNames, pollColTypes);

out.print("{\"polls\": [");

for(int i=0; i != Polls.size(); i++) {
    String[] inputData = {Polls.get(i)[0]};
    //System.err.println("Polls.get(i)[0] " + Polls.get(i)[0]);
    String[] inputTypes = {"int"};
    String[] colNames = {"pollID", "pollName", "location", "description", "startDate", "finishDate"};
    String[] colType = {"int", "string", "string", "string", "string", "string"};
    ArrayList<String[]> PollDetails = db.doPreparedQuery("SELECT * FROM Polls"
        + " WHERE PollID=?", inputData, inputTypes, colNames, colType);
    if(i != 0) {
        out.print(",");
    }
    out.print("{\"pollID\": \"" + PollDetails.get(0)[0] + "\", "
           + "\"pollName\": \"" + PollDetails.get(0)[1] + "\", " +
            "\"location\": \"" + PollDetails.get(0)[2] + "\", " +
            "\"description\": \"" + PollDetails.get(0)[3] + "\", "
            + "\"startDate\": \"" + PollDetails.get(0)[4] + "\", " +
            "\"finishDate\": \"" + PollDetails.get(0)[5] + "\"}");
}



out.print("]}");

%>