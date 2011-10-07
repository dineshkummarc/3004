if(dbPoll.role === 5) {
	$(".sa").hide();
} else if(dbPoll.role === 4) {
	$(".sa").hide();
	$(".pa").hide();
} else if(dbPoll.role === 3) {
	$(".sa").hide();
	$(".pa").hide();
	$(".pc").hide();
} else if(dbPoll.role <= 2) {
	$(".sa").hide();
	$(".pa").hide();
	$(".pc").hide();
	$(".pm").hide();
}