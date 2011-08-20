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
            
            String[] array = {request.getParameter("pollID"), request.getParameter("username")};
            String[] types = {"int", "string"};

            db.doPreparedExecute("DELETE FROM dcf_PollCreatorLink WHERE PollID=? AND UserID IN "
                    + "(SELECT UserID FROM dcf_PollCreators WHERE Username LIKE ?)", array,types);
            
            String[] pollArray = {request.getParameter("pollID")};
            String[] pollTypes = {"int"};
            String[] pclinkCols = {"UserID", "Username", "Password"};
            String[] pclinkColTypes = {"int", "string", "string"};
            ArrayList<String[]> pclink = new ArrayList<String[]>();
            pclink = db.doPreparedQuery("SELECT * FROM dcf_PollCreators pcs WHERE pcs.UserID IN (SELECT "
                                     + "UserID FROM dcf_PollCreatorLink WHERE PollID=?) ",
                                     pollArray, pollTypes, pclinkCols, pclinkColTypes);
            %>
            <%= "{ \"pollCreators\": [" %> 

                <% for(int c=0; c<pclink.size(); c++) {
                    if(c > 0) {
                %>
                    <%= "," %>
                    <% } %>
                    
            
        <%= "\"" + pclink.get(c)[1] + "\"" %>
        <% } %>
                <%= "]}" %>
   
