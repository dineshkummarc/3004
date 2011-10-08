var DEBUG_MODE = true,
	POLL;

if(dbPoll.q.id) {
	POLL = dbPoll.q.id;
	dbPoll.api("api/creator-getpollquestions.jsp?action=grab", 
	        {id: POLL}, function(obj) {
		parseData(obj);
	});
}


/**
* Toggle visibility of comparitive options
*/
$("input.comparitivebox").live("change", function() { 
	$(this).parent().parent().find(".comparitive").toggle();
});

/**
* Toggle visibility of ranking options
*/
$("input.rankingbox").live("change", function() {
	$(this).parent().parent().find(".ranking").css("display", "inline");
});

var question = $("div.question").clone(),
	container = $("#editpoll"),
	questionCount = 1;

/**
* Add a new question
*/
$("#newq").click(function() {
	var q = question.clone().appendTo(container);
	
	if($("#template").val() != "") {
		var options = $("#template").val().split(","),
			i = 0, l = options.length;
			
		for(;i < l; ++i) {
			createResponse(q, {id: -1, text: options[i]});
		}
		
		q.find("div.response:first").remove();
	}
	
	questionCount++;
});

/**
* Add a new response
*/
$("button.newr").live("click", function() {
	var parent = $(this).next(),
		response = $(this).next().children(":first-child"),
		type = $(this).parent().parent().parent().children("select.qformat"),
		r;
		
	if(type.val() == "M" && $(this).next().children("div.response").size() >= 10) {
		return;
	}
	
	r = response.clone().appendTo(parent);
	r.find("button.saveq, button.saver").hide();
	r.find("input.aid").val("-1");
});

/**
* Cancel a question. Not allowed to remove all questions.
*/
$("button.remq").live("click", function() {
	if(questionCount > 1) {
		$(this).parent().remove();
		var id = $(this).parent().find("input.qid").val();
		if(id != "-1") {
			dbPoll.api("api/creator-delquestion.jsp", {questID: id});
		}
		questionCount--;
	}
});

/**
* Cancel a response
*/
$("button.remr").live("click", function() {
	if($(this).parent().parent().children("div.response").size() > 1) {
		var id = $(this).parent().find("input.aid").val();
		
		if(id != "-1") {
			dbPoll.api("api/creator-delanswer.jsp", {answerID: id});
		}
		
		$(this).parent().remove();
	}
});

/**
* Display a save button whenever a field has changed
*/
$("input, select").live("change", showSave).live("keyup", showSave);
$("select.compare, select.chart, select.widget, input.font, input.image, input.indicator")
	.live("change", showSaveUp)
	.live("keyup", showSaveUp);

function showSave() {
	$(this).parent().children("button.saveq, button.saver").show();
}

function showSaveUp() {
	$(this).parent().parent().children("button.saveq").show();
}

$("select.widget").live("focus", function() {
	$(this).css({height: 100, position: "absolute"});
}).live("blur", function() {
	$(this).css({height: 27, position: ""});
});


/**
* Save Responses
*/ 
$("button.saver").live("click", function() {
	var parent = $(this).parent(),
		self = $(this),
		data = {};
	
	data.id = parent.find("input.aid").val();
	data.text = parent.find("input.resptext").val();
	data.keypad = parent.find("select.keypad").val();
	data.correct = parent.find("input.correct")[0].checked;
	data.weight = parent.find("input.weight").val() || "NULL";
	data.questionID = parent.parent().parent().parent().parent().parent().find("input.qid").val();
	
	if(data.questionID) {
		showError(parent, "Save question first");
		return;
	}
	
	console.log(data);
	//send the request to the server
	dbPoll.api("api/response.jsp?action=update", data, function(resp) {
		self.hide();
		if(resp.newid) {
			parent.find("input.aid").val(resp.newid);
		}
	});
});

/**
* Save Questions
*/
$("button.saveq").live("click", function() {
	var parent = $(this).parent(),
		data = {},
		self = $(this);
	
	data.id = parent.find("input.qid").val();
	data.text = parent.find("input.qname").val();
	data.qformat = parent.find("select.qformat").val();
	data.compareTo = parent.find("select.compare").val();
	data.demographic = parent.find("input.demographicbox")[0].checked;
	data.widget = (parent.find("select.widget").val() || []).join(",");
	data.chart = parent.find("select.chart").val();
	data.font = parent.find("input.font").val();
	data.image = parent.find("input.image").val();
	data.indicator = parent.find("input.indicator").val();
	data.pollID = POLL;
	data.creator = 1;
	
	console.log(data);
	
	//send the request to the server
	dbPoll.api("api/questions.jsp?action=update", data, function(resp) {
		self.hide();
		if(resp.newid) {
			parent.find("input.qid").val(resp.newid);
		}
		updateCompare();
	});
});

/**
* Show an error message on a specific line
*/
function showError(line, msg) {
	line.find("span.error").fadeIn().text(msg).delay(1600).fadeOut();
}

/**
* Grab all the questions and put them in
* the compare dropdown box.
*/
function updateCompare() {
	var optionlist = "";
	
	$("div.question").each(function() {
		var self = $(this),				
			id = self.find("input.qid").val(),
			qtext = self.find("input.qname").val();
			
		if(id !== "-1") {
			optionlist += "<option value='"+id+"'>"+qtext+"</option>";
		}
	});
	
	$("select.compare").html(optionlist);
}

/**
* Parse data returned from selecting a Poll
*
* @example
* [{id: 1, text: "Question", type: "M", compareTo: 2, demographic: true, ranking:true, responses: [{id: 2, text: "Repsonse A", keypad: "NULL", correct: true, weight: 50}]}]
*/
parseData = function parseData(data) {
	var q = 0, l = data.length, r, k, quest, resp, qelem;
	
	//loop over questions
	for(;q < l; ++q) {
		quest = data[q];
		qelem = createQuestion(quest);
		
		//loop over responses
		k = quest.responses.length
		for(r = 0; r < k; ++r) {
			resp = quest.responses[r];
			createResponse(qelem, resp);
		}
		
		qelem.find("div.response:first").remove();
	}
	
	container.children("div.question:first").remove();
	updateCompare();
}

function createQuestion(data) {
	var qelem = question.clone().appendTo(container);
	
	qelem.find("input.qid").val(data.id);
	qelem.find("input.qname").val(data.text);
	qelem.find("select.qformat").val(data.type);
	qelem.find("input.font").val(data.font);
	qelem.find("input.image").val(data.image);
	qelem.find("input.indicator").val(data.indicator);
	
	if(data.compareTo != "-1") {
		qelem.find("input.comparitivebox").attr("checked", "checked");
		qelem.find(".comparitive").show();
		qelem.find("select.compare").val(data.compareTo);
	}
	
	if(data.ranking && data.ranking != "null") {
		qelem.find("input.rankingbox").attr("checked", "checked");
		qelem.find(".ranking").show();
	}
	
	if(data.demographic && data.demographic == "T") {
		qelem.find("input.demographicbox").attr("checked", "checked");
	}
	
	if(data.widget) {
		var wiz = data.widget.split(",");
		qelem.find("select.widget").val(wiz);
	}
	
	if(data.chart) {
		qelem.find("select.chart").val(data.chart);
	}
	
	questionCount++;
	return qelem;
}

function createResponse(quest, data) {
	var response = quest.find("div.response:first"),
		relem = response.clone().appendTo(quest.find("div.responses"));
	
	relem.find("button.saveq, button.saver").hide();
	relem.find("input.aid").val(data.id);
	relem.find("input.resptext").val(data.text);
	relem.find("select.keypad").val(data.keypad);
	
	if(data.correct) {
		relem.find("input.correct").attr("checked", "checked");
	}
	
	if(data.weight && data.weight != "NULL") {
		relem.find("input.weight").val(data.weight);
	}
}

function grabData() {
	var data = {};
	data.name = $("#pname").val() || "NULL";
	data.questions = [];
	
	//grab an array of questions
	$("div.question").each(function() {
		data.questions.push(grabQuestionData($(this)));
	});
	
	data.questionsCount = data.questions.length;
	
	return data;
}

/**
* Method to find out all the information to
* insert into the database from a question DIV.
*/
function grabQuestionData(question) {
	var data = {}, i = 0;
	data.demographic = question.find("input.demographicbox")[0].checked;
	data.responseType = question.find("select.qformat").val() || "NULL";
	data.question = question.find("input.qname").val() || "NULL";
	data.compareTo = question.find("select.compare").val() || "NULL";
	data.responses = [];
	
	question.find("div.response").each(function() {
		var self = $(this), obj = {};
		obj.response = self.find("input.resptext").val() || "NULL";
		obj.keypad = self.find("select.keypad").val() || "NULL";
		obj.weight = self.find("input.weight").val() || "NULL";
		obj.correct = self.find("input.correct")[0].checked;
		
		data.responses.push(obj);
	});
	
	data.responsesCount = data.responses.length;
	
	return data;
}