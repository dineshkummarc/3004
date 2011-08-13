$("#poll-creator").click(function() {
	var $parent = $(this).parent(),
		param = {};
		
	param.username = $parent.find("input.username"),
	param.password = $parent.find("input.password"),
	param.email = $parent.find("input.password");
		
	dbPoll.api("registercreator-json.jsp", param, function(data) {
		$parent.find(".message").html(data.status);
	});
});