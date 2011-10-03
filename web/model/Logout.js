dbPoll.api("api/all-logout.jsp", function() {
	dbPoll.go("Login");
	
	$("#top span.name").text("Please Login");
});