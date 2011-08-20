//dbPoll.api("listpolls-json.jsp", function(data) {
dbPoll.api("PollIndex.txt", function(data) {
	var i, l, o = dbPoll.obj, html = "", poll;
	console.log(data);
	//present polls
	for(i = 0, l = data.present.length; i < l; ++i) {
		poll = data.present[i];
		if(poll.completed == "true") {
			html += "<tr><td>"+poll.name+"</td><td>"+poll.description+"</td><td>";
		} else {
			html += "<tr><td><a href=':AnswerQuestion/poll/"+poll.id+"'>"+poll.name+"</a></td><td>"+poll.description+"</td><td>";
		}
		
		html += "<abbr title='"+poll.startDate+"'>"+poll.startDate+"</abbr></td><td><abbr title='"+poll.finishDate+"'>"+poll.finishDate+"</abbr></td><td>";
		html += poll.completed == "true" ? "<img src='assets/images/tick.png' />" : "" + "</td></tr>";
	}
	
	console.log(html);
	o.present.append(html);
	
	//future polls
	html = "";
	for(i = 0, l = data.future.length; i < l; ++i) {
		poll = data.future[i];
		html += "<tr><td>"+poll.name+"</td><td>"+poll.description+"</td><td>";
		html += "<abbr title='"+poll.startDate+"'>"+poll.startDate+"</abbr></td><td><abbr title='"+poll.finishDate+"'>"+poll.finishDate+"</abbr></td><td>";
		html += poll.completed == "true" ? "<img src='assets/images/tick.png' />" : "" + "</td></tr>";
	}
	
	o.future.append(html);
	
	//past polls
	html = "";
	for(i = 0, l = data.past.length; i < l; ++i) {
		poll = data.past[i];
		html += "<tr><td>"+poll.name+"</td><td>"+poll.description+"</td><td>";
		html += "<abbr title='"+poll.startDate+"'>"+poll.startDate+"</abbr></td><td><abbr title='"+poll.finishDate+"'>"+poll.finishDate+"</abbr></td><td>";
		html += poll.completed == "true" ? "<img src='assets/images/tick.png' />" : "" + "</td></tr>";
	}
	
	o.past.append(html);
	$("abbr").timeago();
});

jQuery.timeago.settings.allowFuture = true;