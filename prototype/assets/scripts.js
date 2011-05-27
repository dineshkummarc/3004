var DEBUG_MODE = true;

$(function() {
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
		$(this).parent().parent().find(".ranking").toggle();
	});
	
	var question = $("div.question").clone(),
		container = $("#container"),
		questionCount = 1;
	
	/**
	* Add a new question
	*/
	$("#newq").click(function() {
		question.clone().appendTo(container);
		questionCount++;
	});
	
	/**
	* Add a new response
	*/
	$("button.newr").live("click", function() {
		var parent = $(this).next(),
			response = $(this).next().children(":first-child"),
			type = $(this).parent().parent().parent().children("select.qformat");
			
		if(type.val() == "M" && $(this).next().children("div.response").size() >= 10) {
			return;
		}
		
		response.clone().appendTo(parent);
	});
	
	/**
	* Cancel a question. Not allowed to remove all questions.
	*/
	$("button.remq").live("click", function() {
		if(questionCount > 1) {
			$(this).parent().remove();
			questionCount--;
		}
	});
	
	/**
	* Cancel a response
	*/
	$("button.remr").live("click", function() {
		if($(this).parent().parent().children("div.response").size() > 1) {
			$(this).parent().remove();
		}
	});
	
	/**
	* Save a question
	*/
	$("button.saveq").live("click", function() {
		data = grabData();
		console.log(data);
		
		$.ajax("data.jsp", {
			type: "POST",
			dataType: "html",
			data: data,
			success: function(resp) {
				//response for creating a question.
				console.log(resp);
			},
			
			error: function(e,f,g) {
				console.log("ERROR", e,f,g);
			}
		});
	});
	
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
});