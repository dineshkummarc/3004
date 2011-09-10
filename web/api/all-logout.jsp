<jsp:useBean id="db" scope="session" class="db.database" /> 


<%
    db.logout();
    out.println("{ \"status\": \"OK\"}");
%>
