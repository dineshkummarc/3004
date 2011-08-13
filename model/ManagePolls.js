/**
* Get list of polls
*/
dbPoll.api("listpolls-json.jsp", {}, function(data) {
	var i = 0, l = data.polls.length, j,
		poll, creator, html = "";
	
	//loop over polls
	for(; i < l; ++i) {
		poll = data.polls[i];
		
		html += "<div class='poll list'><h2>"+poll.pollName+"</h2>";
		html += "<div class='inner' data-id='"+poll.pollID+"'>";
		html += "<label>Rename: <input type='text' class='rename' /><button class='renameb'>Rename</button></label>";
		html += "<label>Delete Poll: <button class='delete'>Delete Poll</button></label><div class='creators'>";
		
		//loop over the poll creators
		html += updateCreators(poll.pollCreators);

		html += "</div><label>Assign Creator: <input type='text' class='username' /><button class='assign'>Assign</button></label></div></div>";
	}
	
	$("#polls").html(html);
});

/**
* Create a Poll
*/
$("#create-poll .create").click(function() {
	var name = $("#create-poll .name").val();
	
	dbPoll.api("createpoll-json.jsp", {pollName: name}, function(data) {
		if(data.status == "OK") {
			window.location.reload();
		}
	});
});

/**
* Delete poll
*/
$("button.delete").live("click", function() {
    var $parent = $(this).parent().parent(),
            id = $parent.attr("data-id");
		
	
    dbPoll.api("delpoll-json.jsp", {pollID: id}, function(data) {
         $parent.parent().remove();
    });
});

/**
* Assign a creator
*/
$("button.assign").live("click", function() {
	console.log("click");
	var username = $(this).parent().find(".username").val(),
            $creators = $(this).parent().parent().find(".creators"),
            id = $(this).parent().parent().attr("data-id");
	
	dbPoll.api("assigncreator-json.jsp", {pollID: id, username: username}, function(data) {
		if(data.status !== "OK") {
			dbPoll.error(data.status);
		}
		
		var html = updateCreators(data.pollCreators);
		$creators.html(html);
	});
});

/**
* Rename a Poll
*/
$("button.renameb").live("click", function() {
	var name = $(this).parent().find("input.rename").val(),
		id = $(this).parent().parent().attr("data-id");
		
	dbPoll.api("editpoll-json.jsp", {pollName: name, pollID: id}, function() {
		window.location.reload();
	});
});

/**
* Unassign Creators
*/
$(".poll a.del").live("click", function() {
	var id = $(this).parent().parent().parent().attr("data-id"),
            $creators = $(this).parent().parent(),
		username = $(this).parent().text();
	
        username = username.substr(0, username.length - 3);
	
	dbPoll.api("unassigncreator-json.jsp", {pollID: id, username: username}, function(data) {
		$creators.html(updateCreators(data.pollCreators));
	});
});

/**
* Generate HTML for creators list
*/
function updateCreators(creators) {
	var i = 0, l = creators.length, c,
		html = "";
	
	for(; i < l; ++i) {
		c = creators[i];
		
		html += "<span>" + c + "<a class='del'>[x]</a></span> ";
	}
	
	return html;
}