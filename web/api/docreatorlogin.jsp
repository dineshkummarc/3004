<%-- 
    Document   : docreatorlogin
    Created on : 28/07/2011, 8:22:20 PM
    Author     : David
--%>
<%@page import="java.sql.*" %>
<%@page import="java.util.ArrayList" %>
<jsp:useBean id="db" scope="session" class="db.database" /> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
        <% if(db.creatorLogin(request.getParameter("username"), request.getParameter("password")) == 1) {
            %>
            <%= "{\"status\": \"OK\" } <br /> <a href=\"listcreatorpolls.jsp\">Go to your poll listings (unassessable: DEMO ONLY)</a>" %>
        <% } else if(db.creatorLogin(request.getParameter("username"), request.getParameter("password")) == 3) {
            out.println("{\"status\": \"You do not have Poll Creator access on any polls.\"}");
        } else { %>
            <%= "{\"status\": \"Incorrect username or password. Please try again.\"}" %>
        <% } %>
