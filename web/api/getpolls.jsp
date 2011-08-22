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
    int dataID = db.getUserID();
    
    assigneds assigned = new assigneds();
    assigned.setUserID(dataID);
    ArrayList<polls> allPolls = assigned.getPolls();
    
    if (allPolls == null) {
        out.println("{");
        out.println("\"error\": " + "\"none assigned\"");
        out.println("}");
    } else {
        String printString = "[";
        for (polls p : allPolls) {
            if (!printString.equals("[")) {
                printString = printString + ", ";
            }
            printString = printString + ("{\"pollID\" : " + p.getPollID() + ", \"pollName\" : \"" + p.getPollName() + "\"}");
        }
        printString = printString + "]";
        out.print(printString);
    }
} catch(Exception e){
    out.write(e.toString());
}

%>