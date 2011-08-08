$("#login-submit").click(function() {
	var user = $("#username").val(),
		pass = $("#password").val();
	
	console.log("LOGIN", user, pass);
	dbPoll.api("dologin-json.jsp", {username: user, password: pass}, function(data) {
		if(data.status == "OK") {
			dbPoll.go("Main");
		}
	});
});

if(dbPoll.q.user) {
	$("#username").val(dbPoll.q.user);
}