<%-- 
    Document   : clicker-getip
    Created on : 09/10/2011, 5:23:15 PM
    Author     : s4203040
--%>

<%@page import="java.net.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="db" scope="session" class="db.database" /> 
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.Date,java.text.SimpleDateFormat,java.text.ParseException" %>

<%
InetAddress myIp = InetAddress.getLocalHost(); 
    out.print("{ \"ip\": \"http://" + myIp.getHostAddress() + ":8085/api/\"}");
    

%>