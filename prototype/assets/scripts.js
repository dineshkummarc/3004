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
		questionCount = 1;
	
	/**
	* Add a new question
	*/
	$("#newq").click(function() {
		question.clone().appendTo(document.body);
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
		var data = grabQuestionData($(this).parent());
		console.log(data);
		
		$.ajax("questions.jsp", {
			type: "POST",
			dataType: "json",
			data: data,
			success: function(resp) {
				//response for creating a question.
			}
		});
	});
	
	/**
	* Method to find out all the information to
	* insert into the database from a question DIV.
	*/
	function grabQuestionData(question) {
		var data = {};
		data.demographic = question.find("input.demographicbox")[0].checked;
		data.responseType = question.find("select.qformat").val();
		data.question = question.find("input.qname").val();
		data.compareTo = question.find("select.compare").val();
		
		data.responses = grabResponseData(question);
		
		return data;
	}
	
	/**
	* Return an array of objects of Responses for
	* a specific question.
	*/
	function grabResponseData(question) {
		var data = [];
		
		question.find("div.response").each(function() {
			var resp = {},
				self = $(this);
			
			resp.response = self.find("input.resptext").val();
			resp.keypad = self.find("select.keypad").val();
			resp.weight = self.find("input.weight").val();
			resp.correct = self.find("input.correct")[0].checked;
			
			data.push(resp);
		});
		
		return data;
	}
});