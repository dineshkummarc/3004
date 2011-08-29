<%-- 
    Document   : listcreatorpolls
    Created on : 28/07/2011, 8:22:20 PM
    Author     : David
--%>
<%@page import="java.sql.*" %>
<%@page import="java.util.ArrayList" %>
<jsp:useBean id="db" scope="session" class="db.database" /> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>

        <%
        if(db.getCreatorLoggedIn() == 0) {
            %> <%= "{\"login\": 0, " %>
        <% } else { %>
        <%= "{\"login\": 1, <a href=\"docreatorlogout.jsp\">[logout]</a>} <br /> <table border=\"1\"> <tr> <th> # </th> <th> Poll ID </th> <th> Poll name </th> </tr>" %>
        <% } 
            String[] array = {db.creatorUsername};
            String[] types = {"string"};
            String[] columnNames = {"PollID", "Name"};
            String[] columnTypes = {"int", "string"};
            ArrayList<String[]> polls = new ArrayList<String[]>();
            polls = db.doPreparedQuery("SELECT * FROM Polls WHERE PollID IN "
                    + "(SELECT PollID FROM PollCreatorLink WHERE UserID IN "
                    + "(SELECT UserID FROM Users WHERE Username = ?))", array, types, columnNames, columnTypes);

 
            for(int i=0; i<polls.size(); i++) {
                %>
                <%= "<tr>" %>
                <%= "<td>" + i + "</td>"%>
                <%
                for(int col=0; col<columnNames.length; col++) {
                %>
                
                <%= "<td>" + polls.get(i)[col] + "</td> " %>
                <% } %>
                <%= "</tr>" %>
                <% } %>
