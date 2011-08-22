$("#submit").click(function() {
	var $parent = $(this).parent(),
		param = {},
		o = dbPoll.obj;
		
	param.username = o.username.val(),
	param.password = o.password.val(),
	param.email = o.email.val();
		
	dbPoll.message("<img src='assets/images/ajax-loader.gif'/> <strong>Loading:</strong> Adding a Poll Creator");
		
	dbPoll.api("api/registercreator-json.jsp", param, function(data) {
		o.username.val("");
		o.password.val("");
		o.email.val("");
		
		//stop showing the load message
		if(data.status == "OK") {
			dbPoll.cancelMessage();
		}
	});
});