(function(dbPoll, $, o) {

dbPoll.api("getquestion-json.jsp", {poll: dbPoll.q.poll}, function(data) {
	if(data.status === "error") {
		console.log("ERRORZ", data);
		return;
	}
	
	o.qnum.text(data.qnum);
	o.qtotal.text(data.qtotal);
	
	o.answer.css("font", data.question.font);
	o.image.attr("src", data.question.images);
});


}(dbPoll, jQuery, dbPoll.obj);