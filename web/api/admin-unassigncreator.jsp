<%-- 
    Document   : unassigncreator-json
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
            
            String[] array = {request.getParameter("pollID"), request.getParameter("username")};
            String[] types = {"int", "string"};

            db.doPreparedExecute("DELETE FROM Assigned WHERE Role='Poll Creator' AND PollID=? AND UserID IN "
                    + "(SELECT UserID FROM Users WHERE Username = ?)", array,types);
            
            String[] pollArray = {request.getParameter("pollID")};
            String[] pollTypes = {"int"};
            String[] pclinkCols = {"UserID", "Username"};
            String[] pclinkColTypes = {"int", "string"};
            ArrayList<String[]> pclink = new ArrayList<String[]>();
            pclink = db.doPreparedQuery("SELECT * FROM Users pcs WHERE pcs.UserID IN (SELECT "
                                     + "UserID FROM Assigned WHERE role='Poll Creator' AND PollID=?) ",
                                     pollArray, pollTypes, pclinkCols, pclinkColTypes);
            %>
            <%= "\"pollCreators\": [" %> 

                <% for(int c=0; c<pclink.size(); c++) {
                    if(c > 0) {
                %>
                    <%= "," %>
                    <% } %>
                    
            
        <%= "\"" + pclink.get(c)[1] + "\"" %>
        <% } %>
                <%= "]}" %>
   <% } else {
                out.print("{\"access\":\"bad\"} ");
            }
%>
