//dbPoll.api("listpolls-json.jsp", function(data) {
dbPoll.api("test2.txt", function(data) {
	var i, l, o = dbPoll.obj, html = "", poll;
	console.log(data);
	//present polls
	for(i = 0, l = data.present.length; i < l; ++i) {
		poll = data.present[i];
		html += "<tr><td>"+poll.name+"</td><td>"+poll.description+"</td><td>"+poll.startDate+"</td><td>"+poll.endDate+"</td><td>";
		html += poll.completed == "yes" ? "yes" : "no" + "</td><td></tr>";
	}
	
	console.log(html);
	o.present.append(html);
	
	//future polls
	html = "";
	for(i = 0, l = data.future.length; i < l; ++i) {
		poll = data.future[i];
		html += "<tr><td>"+poll.name+"</td><td>"+poll.description+"</td><td>"+poll.startDate+"</td><td>"+poll.endDate+"</td><td>";
		html += poll.completed == "yes" ? "yes" : "no" + "</td><td></tr>";
	}
	
	o.future.append(html);
	
	//past polls
	html = "";
	for(i = 0, l = data.past.length; i < l; ++i) {
		poll = data.past[i];
		html += "<tr><td>"+poll.name+"</td><td>"+poll.description+"</td><td>"+poll.startDate+"</td><td>"+poll.endDate+"</td><td>";
		html += poll.completed == "yes" ? "yes" : "no" + "</td><td></tr>";
	}
	
	o.past.append(html);
});