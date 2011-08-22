dbPoll.api("api/webuser-logout.jsp", function() {
	dbPoll.go("Login");
	
	$("#top span.name").text("Please Login");
});