//dbPoll.api("listpolls-json.jsp", function(data) {
dbPoll.api("test2.txt", function(data) {
	var i, l, o = dbPoll.obj, html = "", poll;
	
	//present polls
	for(i = 0, l = data.present; i < l; ++i) {
		poll = data.present[i];
		html += "<tr><td>"+poll.name+"</td><td>"+poll.description+"</td><td>"+poll.assigned+"</td><td>";
		html += poll.completed == "yes" ? "yes" : "no" + "</td><td>";
		html += poll.feedback == "yes" ? "yes" : "no" + "</td></tr>";
	}
	
	o.present.innerHTML += html;
	
	//future polls
	html = "";
	for(i = 0, l = data.future; i < l; ++i) {
		poll = data.future[i];
		html += "<tr><td>"+poll.name+"</td><td>"+poll.description+"</td><td>"+poll.assigned+"</td><td>";
		html += poll.completed == "yes" ? "yes" : "no" + "</td><td>";
		html += poll.feedback == "yes" ? "yes" : "no" + "</td></tr>";
	}
	
	o.future.innerHTML += html;
	
	//past polls
	html = "";
	for(i = 0, l = data.past; i < l; ++i) {
		poll = data.past[i];
		html += "<tr><td>"+poll.name+"</td><td>"+poll.description+"</td><td>"+poll.assigned+"</td><td>";
		html += poll.completed == "yes" ? "yes" : "no" + "</td><td>";
		html += poll.feedback == "yes" ? "yes" : "no" + "</td></tr>";
	}
	
	o.past.innerHTML += html;
});