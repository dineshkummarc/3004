<%-- 
    Document   : editpoll-json
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
            if(request.getParameter("pollName").length() == 0) { %>
                <%= "\"status\": \"You cannot enter an empty poll name.\" }" %>
            <% }
            else { %>
                <%= "\"status\": \"OK\", "%>
            <% 
                
            String[] array = {request.getParameter("pollName"), request.getParameter("pollID")};
            String[] types = {"string", "int"};

   
            db.doPreparedExecute("UPDATE Polls SET PollName=? WHERE PollID=?", array,types);
            
            String[] pollArray = {request.getParameter("pollID")};
            String[] pollTypes = {"int"};
            String[] pollCols = {"PollID", "PollName"};
            String[] pollColTypes = {"int", "string"};
            ArrayList<String[]> polls = new ArrayList<String[]>();
            polls = db.doPreparedQuery("SELECT * FROM Polls WHERE PollID=?", pollArray, pollTypes, pollCols, pollColTypes);
 
            for(int i=0; i<polls.size(); i++) {
                %>
               

                <%= "\"poll\": {\"pollID\": " + Integer.parseInt(polls.get(i)[0])
                        + ", \"pollName\": \"" + polls.get(i)[1] +
                        "\", \"pollCreators\": [" 
                        %>
                <% String[] pclinkCols = {"UserID", "Username"};
                String[] pclinkColTypes = {"int", "string"};
                ArrayList<String[]> pclink = new ArrayList<String[]>();
                pclink = db.doPreparedQuery("SELECT * FROM Users pcs WHERE pcs.UserID IN (SELECT "
                                     + "UserID FROM PollCreatorLink WHERE PollID=?) ",
                                     pollArray, pollTypes, pclinkCols, pclinkColTypes);
                %>

                <% for(int c=0; c<pclink.size(); c++) {
                    if(c > 0) {
                %>
                    <%= "," %>
                    <% } %>
                    
            
        <%= "\"" + pclink.get(c)[1] + "\"" %>
        <% } %>
                <%= "]} }" %>
          <%  } }
    
    %>
<% } else {
                out.print("{\"access\":\"bad\"} ");
            }
%>