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
            if(request.getParameter("pollName").length() == 0) { %>
                <%= "{ \"status\": \"You cannot enter an empty poll name.\" } " %>
            <% }
            else { %>
                <%= "{ \"status\": \"OK\", "%>
            <% 
                
            String[] array = {request.getParameter("pollName")};
            String[] types = {"string"};

   
            db.doPreparedExecute("INSERT INTO dcf_Polls(Name) VALUES (?)", array,types);
            
            ArrayList<String[]> maxPoll = new ArrayList<String[]>();
            String[] a1 = {};
            String[] a2 = {};
            String[] getColumnName = {"MAX(PollID)"};
            String[] getColumnType = {"int"};
            maxPoll = db.doPreparedQuery("SELECT MAX(PollID) FROM dcf_Polls", a1, a2, getColumnName, getColumnType);
            
            String[] pollArray = {maxPoll.get(0)[0]};
            String[] pollTypes = {"int"};
            String[] pollCols = {"PollID", "Name", "Admin"};
            String[] pollColTypes = {"int", "string", "string"};
            ArrayList<String[]> polls = new ArrayList<String[]>();
            polls = db.doPreparedQuery("SELECT * FROM dcf_Polls WHERE PollID=?", pollArray, pollTypes, pollCols, pollColTypes);
 
            for(int i=0; i<polls.size(); i++) {
                %>
               

                <%= "\"poll\": {\"pollID\": " + Integer.parseInt(polls.get(i)[0])
                        + ", \"pollName\": \"" + polls.get(i)[1] +
                        "\", \"pollCreators\": [" 
                        %>
                <% String[] pclinkCols = {"UserID", "Username", "Password"};
                String[] pclinkColTypes = {"int", "string", "string"};
                ArrayList<String[]> pclink = new ArrayList<String[]>();
                pclink = db.doPreparedQuery("SELECT * FROM dcf_PollCreators pcs WHERE pcs.UserID IN (SELECT "
                                     + "UserID FROM dcf_PollCreatorLink WHERE PollID=?) ",
                                     pollArray, pollTypes, pclinkCols, pclinkColTypes);
                %>

                <% for(int c=0; c<pclink.size(); c++) {
                    if(c > 0) {
                %>
                    <%= "," %>
                    <% } %>
                    
            
        <%= "\"" + pclink.get(c)[1] + "\"" %>
        <% } %>
                <%= "]}}" %>
          <%  } }
    
    %>
