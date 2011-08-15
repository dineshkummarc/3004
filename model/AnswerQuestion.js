var QID, QTYPE;

function submit() {
	var param = {},
		ans = [];
		
	param.qid = QID;
	
	if(QTYPE == "mp-multiple") {
		$("input:checked").each(function() { 
			ans.push($(this).val());
		});
		
		param.aid = ans.join(",");
	} else if(QTYPE == "mp-single") {
		param.aid = $("input:radio[name=ans]:checked").val();
	} else if(QTYPE.substr(0, 2) == "sr") {
		param.a = $("#resp").val();
	}
	
	dbPoll.api("submitanswer-json.jsp", param, function(data) {
		
	});
}

//dbPoll.api("getquestion-json.jsp", {poll: dbPoll.q.poll}, function(data) {
dbPoll.api("AnswerQuestion.txt", function(data) {
	var o = dbPoll.obj, index = +dbPoll.q.q || 0, l = data.questions.length,
		question, html = "";
		
	if(index >= l) {
		index = l - 1;
	}
	
	//load first question
	question = data.questions[index];
	QID = question.id;
	QTYPE = question.type;
		
	o.qnum.text(index+1);
	o.qtotal.text(l);
	
	console.log(question);
	
	if(question.font && question.font != "null") o.answer.css("font-family", question.font);
	if(question.images && question.images != "null") o.image.attr("src", question.images);
	else $("div.img").hide();
	
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
		html = "<input id='resp' type='text' name='ans' />";
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

$("#submit").click(submit);
$("#next").click(submit);
