dbPoll.api("api/getfeedback.jsp", {pollID: dbPoll.q.id}, function(data) {
	var i = 0, l = data.length, poll,
		html = "";
	
	for(; i < l; ++i) {
		poll = data[i];
		html += "<p>" + poll + "</p>";
	}
	
	$("#fb").html(html);
});