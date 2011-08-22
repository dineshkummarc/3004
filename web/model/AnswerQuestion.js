var DATA, I, 
	QID, QTYPE, QNAME,
	interval,
	CHARTTYPE = "bar";

function submit(show) {
	var param = {},
		ans = [];
		
	param.qid = QID;
	show = show === undefined ? true : false;
	
	if(QTYPE == "mp-multiple") {
		$("input:checked").each(function() { 
			ans.push($(this).val());
		});
		
		param.aid = ans.join(",");
	} else if(QTYPE == "mp-single") {
		param.aid = $("input:radio[name=ans]:checked").val() || "";
	} else if(QTYPE.substr(0, 2) == "sr") {
		param.a = $("#resp").val();
	}
	
	$("#chart").show().empty();
	
	dbPoll.api("api/webuser-submitanswer.jsp", param, function(data) {
		console.log(data);
		if(data.responses && show) {
			var table = new google.visualization.DataTable(),
				key, i = 0, chart,
				q = DATA.questions[I-1];
				
			if(!q) return;	
			
			table.addColumn('string', 'Response');
			table.addColumn('number', 'Amount');
			
			table.addRows(data.responses);
			
			if(q.chartType === "column") {
				chart = new google.visualization.ColumnChart(document.getElementById('chart'));
			} else if(q.chartType === "pie") {
				chart = new google.visualization.PieChart(document.getElementById('chart'));
			} else if(q.chartType === "bar") {
				chart = new google.visualization.BarChart(document.getElementById('chart'));
			} else {
				return;
			}
			
			console.log(table);
			chart.draw(table, {width: 500, height: 400, title: q.question});
		} else {
			$("#chart").hide();
		}
	});
}

dbPoll.api("api/webuser-getquestions.jsp", {poll: dbPoll.q.poll}, function(data) {
	var o = dbPoll.obj, index = +dbPoll.q.q || 0, l = data.questions.length;
		
	if(index >= l) {
		index = l - 1;
	}
	
	DATA = data;
	I = index;
	loadQuest(data.questions[index], index);
});

function loadQuest(question, index) {
	if(interval) clearInterval(interval);
	$("#timer").html("");
	//load first question
	var o = dbPoll.obj, html = "", l = DATA.questions.length;
	
	if(!question) return;
	QID = question.id;
	QTYPE = question.type;
	QNAME = question.question;
		
	o.qnum.text(index+1);
	o.qtotal.text(l);
	
	console.log(question);
	
	if(question.font && question.font != "null") o.answer.css("font-family", question.font);
	else o.answer.css("font-family", "Arial");
	
	if(question.fontColor && question.fontColor != "null") o.answer.css("color", question.fontColor);
	else o.answer.css("color", "#000");
	
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
	if(index+1 >= l) {
		o.submit;
		
		o.next.text("Back").unbind("click").click(function() {
			submit();
			
			dbPoll.go("PollIndex");
		});
	}
	
	var w = question.widgets;
	
	if(w) {
		if(w.timer) {
			var t = +w.timer;
			interval = setInterval(function() {
				var min = ~~(t / 60),
					sec = t % 60;
				
				if(t <= 0) {
					submit();
					loadQuest(DATA.questions[++I], I);
				}
				
				$("#timer").html(dbPoll.zero(min, 2) + ":" + dbPoll.zero(sec, 2));
				t--;
			}, 1000);
		}
	}
	
	$("#feedback").show();
}

$("#submit").click(function() {
	submit(false);
});
$("#next").click(function() {
	submit();
	
	loadQuest(DATA.questions[++I], I);
});

$("#feedback-sub").click(function() {
	var param = {};
	param.qid = QID;
	param.feedback = $("#feedback-resp").val();
	
	$("#feedback-resp").val("");
	
	dbPoll.api("api/webuser-submitfeedback.jsp", param);
	$("#feedback").hide();
});