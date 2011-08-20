<%-- 
    Document   : dologin
    Created on : 28/07/2011, 8:22:20 PM
    Author     : David
--%>
<%@page import="java.sql.*" %>
<%@page import="java.util.ArrayList" %>
<jsp:useBean id="db" scope="session" class="db.database" /> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
        <% if(db.login(request.getParameter("username"), request.getParameter("password")) == 1) {
            %>
            <%= "{\"status\": \"OK\", \"username\": \"" + db.username + "\"}" %>
        <% } else { %>
            <%= "{\"status\": \"Incorrect username or password. Please try again.\"}" %>
        <% } %>