$("#login-submit").click(function() {
	var user = $("#username").val(),
		pass = $("#password").val(),
		url;
	
        url = "api/all-ulogin.jsp";
        
	//if($("#comp").val() === "A") {
		//url = "api/webuser-login.jsp";
        
	//} else {
        //        url = "api/all-ulogin.jsp";
		//url = "api/admin-dologin.jsp";
	//}
	
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