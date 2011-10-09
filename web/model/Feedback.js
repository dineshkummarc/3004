dbPoll.api("api/getfeedback.jsp", {pollID: dbPoll.q.id}, function(data) {
	var i = 0, l = data.length, poll,
		html = "",
		feedb = {};
	
	if(l == 0) {
		$("#fb").html("No Feedback Results");
		return;
	}
	
	//group it
	for(; i < l; ++i) {
		if(!feedb[data[i].question]) feedb[data[i].question] = [];
		feedb[data[i].question].push(data[i]);
	}
	
	//grouping
	for(var q in feedb) {
		html += "<h2>" + q + "</h2>";
		for(i = 0; i < feedb[q].length; ++i) {
			poll = feedb[q][i];
			html += "<blockquote>" + poll.text + "</blockquote>";
		}
	}
	
	$("#fb").html(html);
});