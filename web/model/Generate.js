$("#su-submit").click(function() {
	window.location = "report.jsp?type=system"
});

$("#sh-submit").click(function() {
	window.location = "report.jsp?type=session"
});

dbPoll.api("api/reportPolls.jsp", {userID: 2}, function(data) {
	var i = 0, l = data.length, html = "", p;
	
	for(; i < l; ++i) {
		p = data[i];
		html += "<option value='"+p.pollID+"'>"+p.PollName+"</option>";
	}
	
	$("#polls").html(html).trigger("change");
});

$("#polls").change(function() {
	var id = $(this).val();
	
	dbPoll.api("api/reportQuestion.jsp", {pollID: id}, function(data) {
		var i = 0, l = data.length, html = "", quest;
		
		for(; i < l; ++i) {
			quest = data[i];
			
			html += "<option value='"+p.questID+"'>"+p.Question+"</option>";
		}
		
		html += "<option value='individual'>Individual</option>";
		
		$("#demog").html(html).trigger("change");
	});
});

$("#demog").change(function() {
	var id = $("#polls").val();
	
	if($(this).val() === "individual") {
		dbPoll.api("api/reportUser.jsp", {pollID: id}, function(data) {
			var i = 0, l = data.length, html = "<option value=''>---</option>", user;
		
			for(; i < l; ++i) {
				user = data[i];
				
				html += "<option value='"+user.userID+"'>"+user.UserName+"</option>";
			}
			
			$("#value").html(html);
		});
		
		$("#chartsel").html("<option value='Bar'>Bar</option>");
		$("#location").attr('disabled', true);
	} else {
		dbPoll.api("api/reportAnswer.jsp", {questID: $(this).val()}, function(data) {
			var i = 0, l = data.length, html = "<option value=''>---</option>", ans;
		
			for(; i < l; ++i) {
				ans = data[i];
				
				html += "<option value='"+ans.answerID+"'>"+ans.Answer+"</option>";
			}
			
			$("#value").html(html);
		});
	
		$("#chartsel").html("<option value='Bar'>Bar</option><option value='Pie'>Pie</option>");
		$("#location").removeAttr("disabled");
	}
});


$("#sr-submit").click(function() {
	var param = {};
	param.id = $("#polls").val(),
	param.demoID = $("#demog").val();
	param.demoValue = $("#value").val();
	param.graph = $("#chartsel").val();
	param.location = $("#location").val();
	
	window.location = "report.jsp?"+$.param(param);
});