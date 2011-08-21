$("#login-submit").click(function() {
	var user = $("#username").val(),
		pass = $("#password").val(),
		url;
	
	if($("#comp").val() === "A") {
		url = "admin/webuser-login.jsp";
	} else {
		url = "api/admin-dologin.jsp";
	}
	
	console.log("LOGIN", user, pass);
	
	dbPoll.api(url, {username: user, password: pass}, function(data) {
		if(data.username) {
			$("#top span.name").text(data.username);
			dbPoll.go("Home");
		}
	});
});

if(dbPoll.q.user) {
	$("#username").val(dbPoll.q.user);
}