<%-- 
    Document   : registercreator-json
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
                <%= "{ \"status\" : \"You cannot register an empty username.\" " %>
            <% } else if(request.getParameter("password").length() == 0) { %>
                <%= "{ \"status\" : \"Please enter a password for the account.\" " %>
            <% } else if(request.getParameter("email").length() == 0) { %>
                <%= "{ \"status\" : \"Please enter an email address for the account.\" " %>
            <% }
            
            else { 
                String email = request.getParameter("email");
                if((!email.contains("@")) || (!email.contains("."))) { %>
                    <%= "{ \"status\" : \"Please enter an valid email address for the account.\" " %>
               <% } else {
                
                
            String[] array = {request.getParameter("username")};
            String[] types = {"string"};
            String[] columnName = {"UserID"};
            String[] columnType = {"int"};
   
            ArrayList<String[]> checkExists = db.doPreparedQuery("SELECT UserID FROM dcf_PollCreators WHERE Username LIKE ?", array, types, columnName, columnType);
            
            if(checkExists.size() > 0) { %>
                <%= "{ \"status\" : \"That username already exists.\" " %>
            <% }
                else {
                    // all ok, let's register them
                    
                        String[] inputData1 = {request.getParameter("username"), request.getParameter("password"), email};
                        String[] inputTypes1 = {"string", "string", "string"};
                        db.doPreparedExecute("INSERT INTO dcf_PollCreators(Username, Password, Email) VALUES(?, ?, ?)", inputData1, inputTypes1);%>
                        <%= "{ \"status\": \"Account " + request.getParameter("username") + " registered successfully.\" " %>
                        
                        <% emailmodule.sendEmail(email, "You've been given a dbPOLL account!", 
                                "A user account has been registered for you. You can now login with username as " + 
                                request.getParameter("username") + " and password as " + request.getParameter("password") + "."); 
                }
            } } %>
            
           <%= "}" %>
