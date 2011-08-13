//dbPoll.api("getquestion-json.jsp", {poll: dbPoll.q.poll}, function(data) {
dbPoll.api("test.txt", function(data) {
	var o = dbPoll.obj, index = +dbPoll.q.q || 0, l = data.questions.length,
		question, html = "";
		
	if(index >= l) {
		index = l - 1;
	}
	
	//load first question
	question = data.questions[index];
		
	o.qnum.text(index+1);
	o.qtotal.text(l);
	
	console.log(question);
	
	if(question.font && question.font != "null") o.answer.css("font-family", question.font);
	if(question.images && question.images != "null") o.image.attr("src", question.images);
	
	o.name.text(question.question);
	
	if(question.type === "mp-single" || question.type === "mp-multiple") {
		var j, ans;
		
		for(j in question.answers) {
			ans = question.answers[j];
			if(question.type === "mp-single") {
				html += "<label><input type='radio' name='ans' value='"+j+"' /> "+ans+"</label>";
			} else if(question.type === "mp-multiple") {
				html += "<label><input type='checkbox' name='ans' value='"+j+"' /> "+ans+"</label>";
			}
		}
	} else {
		html = "<label><input id='resp' type='text' name='ans' /></label>";
	}
	
	o.response.html(html);
	
	if(question.type === "sr-num") {
		$("#resp").keydown(function(e) {
			return (e.which >= 48 && e.which <= 57) || e.which === 8;
		});
	} else if(question.type === "sr-alphanum") {
		$("#resp").keydown(function(e) {
			return (e.which >= 48 && e.which <= 57) || (e.which >= 65 && e.which <= 90) || e.which === 8;
		});
	}
	
	console.log(index, l);
	if(index+1 < l) {
		o.next.show();
		o.next.attr("href", ":AnswerQuestion/poll/"+dbPoll.q.poll+"/q/"+(index+1));
	} else {
		o.next.hide();
	}
});
