
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.text.*"%>
<%@page import="java.io.*"%>
<jsp:useBean id="db" scope="session" class="db.database" /> 

<%
try{
	if(db.accessCheck("master") == 1) {

		String dataID = request.getParameter("id"); //ID of the above type
		String location = "";
		//polls poll = new polls();
		//poll.setPollID(Integer.parseInt(dataID));
		//poll.getPoll();
		//location = poll.getLocation();
		String query = "SELECT location FROM polls WHERE pollid=?";
		String[] values = {dataID};
		String[] types = {"int"};
		String[] columnNames = {"location"};
		String[] columnValues = {"string"};
		ArrayList<String[]> results = db.doPreparedQuery(query, values, types, columnNames, columnValues);
		location = results.get(0)[0];
		if(!location.equals("")){
			out.println("{");
			out.println("\"location\": \"" + location + "\"");
			out.println("}");
		} else {
			out.println("{");
			out.println("\"error\": " + "\"No data found\"");
			out.println("}");
		}
	}
} catch(Exception e){
    out.write(e.toString());
}

%>