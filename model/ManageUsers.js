$("#create").click(function() {
	var param = {},
		p = $(this).parent();
	
	param.action = "register";
	param.username = p.find(".username").val();
	param.password = p.find(".password").val();
	param.email = p.find(".email").val();
	param.userType = p.find(".role").val();
	
	console.log(param);
	dbPoll.api("edituser.jsp", param);
});

$("label.exp").hide();
$("#editbox").hide();

$("select.role").change(function() {
	if($(this).val() == 4) {
		$(this).parent().next().show();
	} else {
		$(this).parent().next().hide();
	}
});

$("#edit").click(function() {
	$("#editbox").toggle();
	var username = $(this).parent().find(".username").val(),
		p = $("#editbox");
	
	dbPoll.api("edituser.jsp", {returnBoolean: true, userName: username}, function(data) {
		p.find(".username").val(data.username);
		p.find(".location").val(data.username);
		p.find(".email").val(data.email);
		p.find(".userLevel").val(data.userLevel);
	});
});

$("#remove").click(function() {
	var username = $(this).parent().find(".username").val();
	
	dbPoll.api("edituser.jsp", {action: "remove", userName: username});
});