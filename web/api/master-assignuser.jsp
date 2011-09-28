<%--
    Document   : master-assignuser
    Created on : 12/08/2011, 7:13:37 PM
    Author     : Darren
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.text.*"%>
<%@page import="java.io.*"%>
<jsp:useBean id="db" scope="session" class="db.database" /> 

<%
try{
	if(db.accessCheck("master") == 1) {
		out.println("{");
		out.println("\"access\": \"OK\"");
		out.println("}");
		String pollID = request.getParameter("pollid"); //ID of the poll
                String userID = request.getParameter("userid"); //ID of the user
                String userRole = request.getParameter("role"); //Role of user
		String query = "INSERT INTO assigned (userID, pollID, role) VALUES (?, ?, ?)";
		String[] values = {userID, pollID, userRole};
		String[] types = {"int", "int", "string"};
		String result = db.doPreparedExecute(query, values, types);
		if(result.equals("Failed!")){
                    query = "UPDATE assigned SET role=? WHERE userID=? AND pollID=?";
                    String[] values2 = {userRole, userID, pollID};
                    String[] types2 = {"string", "int", "int"};
                    result = db.doPreparedExecute(query, values2, types2);
                    if(result.equals("Failed!")){
			out.println("{");
			out.println("\"error\": " + "\"Database communication issues\"");
			out.println("}");
                    } else {
                        out.println("{");
			out.println("\"status\": " + "\"User assigned\"");
			out.println("}");
                    }
		} else {
			out.println("{");
			out.println("\"status\": " + "\"User assigned\"");
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