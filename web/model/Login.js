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
	dbPoll.message("Logging in!");
	
	dbPoll.api(url, {username: user, password: pass}, function(data) {
		if(data.username) {
			$("#top span.name").text(data.username);
			dbPoll.role = data.role;
			var html = "";
			
			switch(data.role) {
				case 6:
					html += "<li><a href=':ManageUsers'>Manage Users</a></li>\
							<li><a href=':AddPollCreator'>Add Poll Creator</a></li>";
				case 5:
					html += "<li><a href=':ManagePolls'>Manage Polls</a></li>\
							<li><a href=':AddPollCreator'>Add Poll Creator</a></li>";
				case 4:
					html += "<li><a href=':EditPoll'>Edit Poll</a></li>"
				case 3:
					html += "<li><a href=':Location'>Change Location</a></li>\
							<li><a href=':Generate'>Generate Report</a></li>\
							<li><a href=':ConductPoll'>Conduct Poll</a></li>";
				case 2:
				case 1:
					html += "<li><a href=':PollIndex'>Poll Index</a></li>";
			}
			
			$("#nav ul").html(html);
			
			dbPoll.go("Home");
		}
	});
});

if(dbPoll.q.user) {
	$("#username").val(dbPoll.q.user);
}