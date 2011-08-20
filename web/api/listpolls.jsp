<%-- 
    Document   : listpolls
    Created on : 28/07/2011, 8:22:20 PM
    Author     : David
--%>
<%@page import="java.sql.*" %>
<%@page import="java.util.ArrayList" %>
<jsp:useBean id="db" scope="session" class="db.database" /> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
        <%
        if(db.getLoggedIn() == 0) {
            %> <%= "{\"login\": 0, " %>
        <% } else { %>
        <%= "{\"login\": 1, " %>
        <% } 
            String[] array = {};
            String[] types = {};
            String[] columnNames = {"PollID", "Name", "Admin"};
            String[] columnTypes = {"int", "string", "string"};
            ArrayList<String[]> polls = new ArrayList<String[]>();
            polls = db.doPreparedQuery("SELECT * FROM dcf_Polls", array, types, columnNames, columnTypes);

 
            for(int i=0; i<polls.size(); i++) {
                %>
                <%= "<a href=\"editpoll-json.jsp?pollID=" + polls.get(i)[0] + "&pollName=check\">[edit]</a>" %>
                <%= "<a href=\"delpoll-json.jsp?pollID=" + polls.get(i)[0] + "\">[del]</a>" %>
                <%= "Row " + i %>
                <%
                for(int col=0; col<columnNames.length; col++) {
                %>
                
                <%= polls.get(i)[col] + " " %>
                <% } 
                String[] pclinkCols = {"UserID", "Username", "Password"};
                String[] pclinkColTypes = {"int", "string", "string"};
                ArrayList<String[]> pclink = new ArrayList<String[]>();
                pclink = db.doPreparedQuery("SELECT * FROM dcf_PollCreators pcs WHERE pcs.UserID IN (SELECT "
                                     + "UserID FROM dcf_PollCreatorLink WHERE PollID=" + Integer.parseInt(polls.get(i)[0]) + ") ",
                                     array, types, pclinkCols, pclinkColTypes);
                %>
                <%= "<br /> >>> Poll Creator(s): "%>
                <% for(int c=0; c<pclink.size(); c++) {
                    %>
            
        <%= pclink.get(c)[1] %>
        <% } %>
                <%= "<br /> <br />" %>
          <%  }
    
    %>
