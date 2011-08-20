<%-- 
    Document   : logout
    Created on : 15/08/2011, 10:18:29 AM
    Author     : Aidan Rowe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="db" scope="session" class="db.database" /> 


<%
    
    db.logout();
    out.println("{ \"status\": \"OK\"}");
%>
