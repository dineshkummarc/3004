<%--
    Document   : admin-setpollend
    Created on : 03/10/2011, 11:03:00 PM
    Author     : Darren
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.text.*"%>
<%@page import="java.io.*"%>
<jsp:useBean id="db" scope="session" class="db.database" /> 

<%
try{
    if(db.accessCheck("polladmin") == 1) {
	    out.println("{");
	    out.println("\"access\": \"OK\"");
	    out.println("}");
	    String pollID = request.getParameter("id");
	    String finishDate = request.getParameter("date");
	    if (finishDate.equals(null)) {
		    out.println("{");
		    out.println("\"error\": " + "\"Undefined finish date\"");
		    out.println("}");
	    } else {
		    String query = "UPDATE polls SET finishDate=? WHERE pollid=?";
		    String[] values = {finishDate, pollID};
		    String[] types = {"string", "int"};
		    db.doPreparedExecute(query, values, types);
		    out.println("{");
		    out.println("\"status\": " + "\"Poll end date changed\"");
		    out.println("}");
	    }   
    } else {
	    out.println("{");
	    out.println("\"access\": \"bad\"");
	    out.println("}");
    }
} catch(Exception e){
    out.write(e.toString());
}

%>