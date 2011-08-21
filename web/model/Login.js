$("#login-submit").click(function() {
	var user = $("#username").val(),
		pass = $("#password").val();
	
	console.log("LOGIN", user, pass);
	dbPoll.api("api/webuser-login.jsp", {username: user, password: pass}, function(data) {
		if(data.username) {
			$("#top span.name").text(data.username);
			dbPoll.go("Home");
		}
	});
});

if(dbPoll.q.user) {
	$("#username").val(dbPoll.q.user);
}