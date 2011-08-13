$("#submit").click(function() {
	var $parent = $(this).parent(),
		param = {},
		o = dbPoll.obj;
		
	param.username = o.username.val(),
	param.password = o.password.val(),
	param.email = o.email.val();
		
	dbPoll.api("registercreator-json.jsp", param, function(data) {
		$parent.find(".message").html(data.status);
	});
});