<%-- 
    Document   : assigncreator-json
    Created on : 28/07/2011, 8:22:20 PM
    Author     : David
--%>
<%@page import="java.sql.*" %>
<%@page import="java.util.ArrayList" %>
<jsp:useBean id="db" scope="session" class="db.database" /> 
<jsp:useBean id="emailmodule" scope="session" class="db.email" /> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>

        <%
            if(request.getParameter("username").length() == 0) { %>
                <%= "{ \"status\" : \"You cannot assign an empty username.\", " %>
            <% }
            
            else { 
                
            String[] array = {request.getParameter("username")};
            String[] types = {"string"};
            String[] columnName = {"userID"};
            String[] columnType = {"int"};
   
            ArrayList<String[]> checkExists = db.doPreparedQuery("SELECT * FROM Users WHERE lower(userName) = lower(?)", array, types, columnName, columnType);
            
            if(checkExists.size() == 0) { %>
                <%= "{ \"status\" : \"That username doesn't exist.\", " %>
            <% }
                else {
                    // username exists, but is it already assigned to the poll?
                    String[] inputData = {checkExists.get(0)[0], request.getParameter("pollID")};
                    String[] inputTypes = {"int", "int"};
                    String[] colNames = {"UserID"};
                    String[] colType = {"int"};
                    ArrayList<String[]> checkAlready = db.doPreparedQuery("SELECT UserID FROM PollCreatorLink WHERE UserID=? AND PollID=?", inputData, inputTypes, colNames, colType);
                    if(checkAlready.size() > 0) { 
                        System.out.println("checkAlready is greater than zero; data: " + checkAlready.get(0)[0]);
                        %>
                        <%= "{ \"status\" : \"That username is already assigned to this poll.\", " %>
                        
                    <%  
                    } else {
                        // all ok, add them
                        System.out.println("DEBUG: Creator has been assigned!");
                        String[] inputData1 = {checkExists.get(0)[0], request.getParameter("pollID")};
                        String[] inputTypes1 = {"int", "int"};
                        db.doPreparedExecute("INSERT INTO PollCreatorLink(UserID, PollID) VALUES(?, ?)", inputData1, inputTypes1);%>
                        <%= "{ \"status\": \"OK\", " %>
                        <% 
                        // now alert them with an email
                        String[] findPoll = {inputData1[1]};
                        String[] findPollType = {"int"};
                        String[] getPollName = {"Name"};
                        String[] getPollType = {"string"};
                        ArrayList<String[]> pollName = db.doPreparedQuery("SELECT PollName FROM Polls WHERE PollID=?", findPoll, findPollType, getPollName, getPollType);
                        
                        String[] getEmailIn = {request.getParameter("username")};
                        String[] getEmailInType = {"string"};
                        String[] getEmailCol = {"email"};
                        String[] getEmailColType = {"string"};
                        ArrayList<String[]> getEmail = db.doPreparedQuery("SELECT * FROM Users WHERE lower(userName) = lower(?)", getEmailIn, getEmailInType, getEmailCol, getEmailColType);
                        System.out.println(getEmail.get(0)[0]);
                        emailmodule.sendEmail(getEmail.get(0)[0], "You've been given Poll Creator access to a poll.", "You now have Poll Creator access to the following poll: " + pollName.get(0)[0]);
                     }
                }
            }
            
            String[] pollArray = {request.getParameter("pollID")};
            String[] pollTypes = {"int"};
            String[] pclinkCols = {"userID", "userName"};
            String[] pclinkColTypes = {"int", "string"};
            ArrayList<String[]> pclink = new ArrayList<String[]>();
            pclink = db.doPreparedQuery("SELECT * FROM Users pcs WHERE pcs.UserID IN (SELECT "
                                     + "UserID FROM PollCreatorLink WHERE PollID=?) ",
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