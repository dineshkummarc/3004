<jsp:useBean id="db" scope="session" class="db.database" /> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

String type = request.getParameter("type");
String pollID = request.getParameter("pollID");
String query = "";
String columnTypes[] = {"string"};
String jsonName[] = {"Location"};
        
if(type.equals("country")){
    
    String columnNames[] = {"country"};
    String input[] = {pollID};
    String types[] = {"int"};
    query = "SELECT p.country FROM pollLocation p WHERE p.pollID=?"
            + " GROUP BY p.country";
    String data = db.doPreparedQueryAndy(query, input, types, columnNames, columnTypes, jsonName);
    out.println(data);
}
else if(type.equals("state")){ 
    
    String country = request.getParameter("country");
    String columnNames[] = {"state"};
    String input[] = {pollID, country};
    String types[] = {"int", "string"};
    query = "SELECT p.state FROM pollLocation p WHERE p.pollID=? AND p.country=?"
            + " GROUP BY p.state";
    String data = db.doPreparedQueryAndy(query, input, types, columnNames, columnTypes, jsonName);
    out.println(data);
}
else if(type.equals("city")){
    
    String state = request.getParameter("state");
    String columnNames[] = {"city"};
    String input[] = {pollID, state};
    String types[] = {"int", "string"};
    query = "SELECT p.city FROM pollLocation p WHERE p.pollID=? AND p.state=?"
            + " GROUP BY p.city";
    String data = db.doPreparedQueryAndy(query, input, types, columnNames, columnTypes, jsonName);
    out.println(data);
}
else if(type.equals("suburb")){
    
    String city = request.getParameter("city");
    String columnNames[] = {"suburb"};
    String input[] = {pollID, city};
    String types[] = {"int", "string"};
    query = "SELECT p.suburb FROM pollLocation p WHERE p.pollID=? AND p.city=?"
            + " GROUP BY p.suburb";                
    String data = db.doPreparedQueryAndy(query, input, types, columnNames, columnTypes, jsonName);
    out.println(data);
}
else if(type.equals("street")){
    
    String suburb = request.getParameter("suburb");
    String columnNames[] = {"street"};
    String input[] = {pollID, suburb};
    String types[] = {"int", "string"};
    query = "SELECT p.street FROM pollLocation p WHERE p.pollID=? AND p.suburb=?"
            + " GROUP BY p.street";
    String data = db.doPreparedQueryAndy(query, input, types, columnNames, columnTypes, jsonName);
    out.println(data);
}

%>
