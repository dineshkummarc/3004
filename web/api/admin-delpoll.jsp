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
            
            String[] array = {request.getParameter("pollID")};
            String[] types = {"int"};

            db.doPreparedExecute("DELETE FROM dcf_Polls WHERE PollID=?", array,types);
            db.doPreparedExecute("DELETE FROM dcf_PollCreatorLink WHERE PollID=?", array,types);
            
            String[] paramArray = {};
            String[] paramTypes = {};
            String[] columnNames = {"PollID", "Name", "Admin"};
            String[] columnTypes = {"int", "string", "string"};
            ArrayList<String[]> polls = new ArrayList<String[]>();
            polls = db.doPreparedQuery("SELECT * FROM dcf_Polls", paramArray, paramTypes, columnNames, columnTypes);
            %>
            
            <%= "{\"numPolls\": " + polls.size() + ", \"polls\": [" %>
 
            <% for(int i=0; i<polls.size(); i++) {
                %>
                
                <% if(i > 0) { %>
                <%= ", " %>
                <% } %>
                

                <%= "{\"pollID\": " + Integer.parseInt(polls.get(i)[0])
                        + ", \"pollName\": \"" + polls.get(i)[1] +
                        "\", \"pollCreators\": [" 
                        %>
                <% String[] pclinkCols = {"UserID", "Username", "Password"};
                String[] pclinkColTypes = {"int", "string", "string"};
                ArrayList<String[]> pclink = new ArrayList<String[]>();
                pclink = db.doPreparedQuery("SELECT * FROM dcf_PollCreators pcs WHERE pcs.UserID IN (SELECT "
                                     + "UserID FROM dcf_PollCreatorLink WHERE PollID=" + Integer.parseInt(polls.get(i)[0]) + ") ",
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
