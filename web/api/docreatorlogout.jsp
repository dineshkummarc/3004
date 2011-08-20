<%-- 
    Document   : dologout
    Created on : 30/07/2011, 4:53:50 PM
    Author     : David
--%>

<%@page import="java.sql.*" %>
<%@page import="java.util.ArrayList" %>
<jsp:useBean id="db" scope="session" class="db.database" /> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>

        <% db.creatorLogout(); %>
        <%= "OK" %>