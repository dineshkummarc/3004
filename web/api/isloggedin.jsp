<jsp:useBean id="db" scope="session" class="db.database" /> 
<% if(db.getLoggedIn() == 1) {
    out.println("{\"status\": \"OK\", \"username\": \"" + db.username + "\"," + "\"userID\": " + db.getUserID() + ",\"role\": " + db.getUserLevel() + ",}");
} else {
    out.println("{\"status\": \"You are not logged in.\"}");
}
%>