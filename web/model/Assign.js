var DATA = {};

dbPoll.api("api/getpollsbyuser.jsp", function(data) {
	var i = 0, l = data.length, html = "",
		poll;
	
	for(; i < l; ++i) {
		poll = data[i];
		
		html += "<option value='"+poll.id+"'>"+poll.name+"</option>";
		DATA[poll.id] = poll.role;
	}
	
	$("#upoll").html(html);
});

$("#upoll").change(function() {
	var html = "",
		role = DATA[$(this).val()];
		
	switch(role) {
		case "System Admin":
			html += "<option value='System Admin'>System Admin</option>";
		case "Poll Admin":
			html += "<option value='Poll Admin'>Poll Admin</option>";
		case "Poll Creator":
			html += "<option value='Poll Creator'>Poll Creator</option>";
		case "Poll Master":
			html += "<option value='Poll Master'>Poll Master</option>";
		default:
			html += "<option value='Web User'>Web User</option>";
			html += "<option value='Key User'>Key User</option>";
	}
	
	$("#urole").html(html);
});

$("#subm").click(function() {
	var params = {};
	params.userName = $("#uname").val();
	params.pollID = $("#upoll").val();
	params.role = $("#upoll").val();
	
	dbPoll.api("api/assignPoll-user.jsp", params, function() {
		dbPoll.go("Home");
	});
});