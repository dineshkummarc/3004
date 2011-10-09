var roles = {
	"Web User": 1,
	"Key User": 2,
	"Poll Master": 3,
	"Poll Creator": 4,
	"Poll Admin": 5,
	"System Admin": 6
}

dbPoll.api("api/getpollsbyuser.jsp", function(data) {
	var i = 0, l = data.length, html = "",
		poll;
	
	for(; i < l; ++i) {
		poll = data[i];
		//skip if not creator or higher
		if(roles[poll.role] < 4) continue;
		html += "<tr><td>" + poll.name + "</td><td>" + poll.description + "</td><td><a href=':EditPoll/id/"+poll.id+"'>Edit</a></td></tr>";
	}
	
	$("#apolls").append(html);
});