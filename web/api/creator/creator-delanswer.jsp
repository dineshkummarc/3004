<%@page import="java.sql.*" %>
<%@page import="java.util.ArrayList" %>
<jsp:useBean id="db" scope="session" class="db.database" /> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
if(db.accessCheck("creator") == 1) {
    out.print("{\"access\":\"OK\", ");
    String[] inputData = {request.getParameter("answerID")};
    String[] inputTypes = {"int"};

    db.doPreparedExecute("DELETE FROM Answers WHERE answerID=?", inputData, inputTypes);
    db.doPreparedExecute("DELETE FROM Rankings WHERE answerID=?", inputData, inputTypes);

    out.print("\"status\": \"OK\"}");
} else {
    out.print("{\"access\":\"bad\"}");
}
%>


