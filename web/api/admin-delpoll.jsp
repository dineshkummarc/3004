<%-- 
    Document   : delpoll-json
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
            
            String[] array = {request.getParameter("pollID")};
            String[] types = {"int"};

            db.doPreparedExecute("DELETE FROM Polls WHERE PollID=?", array,types);
            db.doPreparedExecute("DELETE FROM Assigned WHERE PollID=? AND role='Poll Creator'", array,types);
            
            String[] paramArray = {};
            String[] paramTypes = {};
            String[] columnNames = {"PollID", "PollName"};
            String[] columnTypes = {"int", "string"};
            ArrayList<String[]> polls = new ArrayList<String[]>();
            polls = db.doPreparedQuery("SELECT * FROM Polls", paramArray, paramTypes, columnNames, columnTypes);
            %>
            
            <%= "\"numPolls\": " + polls.size() + ", \"polls\": [" %>
 
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
                                     paramArray, paramTypes, pclinkCols, pclinkColTypes);
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
                out.print("{\"access\":\"bad\"} ");
            }
%>