<%-- 
    Document   : listpolls-json
    Created on : 28/07/2011, 8:22:20 PM
    Author     : David
--%>
<%@page import="java.sql.*" %>
<%@page import="java.util.ArrayList" %>
<jsp:useBean id="db" scope="session" class="db.database" /> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>

        <%
        if(db.getLoggedIn() == 0) {
            %> <%= "{\"login\": 0, \"username\": \"null\"," %>
        <% } else { %>
        <%= "{\"login\": 1, \"username\": \"" + db.username + "\"," %>
        <% } 
        if(db.accessCheck("polladmin") == 1) {
            
            out.print("\"access\":\"OK\", ");
            String[] array = {};
            String[] types = {};
            String[] columnNames = {"PollID", "PollName"};
            String[] columnTypes = {"int", "string"};
            ArrayList<String[]> polls = new ArrayList<String[]>();
            polls = db.doPreparedQuery("SELECT * FROM Polls", array, types, columnNames, columnTypes);
            %>
            
            <%= " \"numPolls\": " + polls.size() + ", \"polls\": [" %>
 
            <% for(int i=0; i<polls.size(); i++) {
                %>
                
                <% if(i > 0) { %>
                <%= ", " %>
                <% } %>
                

                <%= "{\"pollID\": " + Integer.parseInt(polls.get(i)[0])
                        + ", \"pollName\": \"" + polls.get(i)[1] +
                        "\", \"pollCreators\": [" 
                        %>
                <% String[] pclinkCols = {"UserID", "Username"};
                String[] pclinkColTypes = {"int", "string"};
                ArrayList<String[]> pclink = new ArrayList<String[]>();
                pclink = db.doPreparedQuery("SELECT * FROM Users pcs WHERE pcs.UserID IN (SELECT "
                                     + "UserID FROM Assigned WHERE role='Poll Creator' AND PollID=" + Integer.parseInt(polls.get(i)[0]) + ") ",
                                     array, types, pclinkCols, pclinkColTypes);
                %>

                <% for(int c=0; c<pclink.size(); c++) {
                    if(c > 0) {
                %>
                    <%= "," %>
                    <% } %>
                    
            
        <%= "\"" + pclink.get(c)[1] + "\"" %>
        <% } %>
                <%= "]} " %>
          <%  }
    
    %>
            <%= "] }" %>
            <% } else {
            out.print("\"access\":\"bad\" } ");   
           } %>

