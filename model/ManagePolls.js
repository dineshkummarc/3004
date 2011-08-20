/**
* Get list of polls
*/
dbPoll.api("api/admin-listpolls.jsp", function(data) {
	var i = 0, l = data.polls.length, j,
		poll, creator, html = "";
	
	//loop over polls
	for(; i < l; ++i) {
		poll = data.polls[i];
		
		html += "<div class='poll list'><h2>"+poll.pollName+"</h2>";
		html += "<div class='inner' data-id='"+poll.pollID+"'>";
		html += "<label>Rename: <a class='button renameb'>Rename</a><input type='text' class='rename' /></label>";
		html += "<label>Delete Poll: <a class='button delete'>Delete</a></label><div class='creators'>";
		
		//loop over the poll creators
		html += updateCreators(poll.pollCreators);

		html += "</div><label>Creator: <a class='button assign'>Assign</a><input type='text' class='username' /></label></div></div>";
	}
	
	$("#polls").html(html);
});

/**
* Create a Poll
*/
$("#create-poll .create").click(function() {
	var name = $("#create-poll .name").val();
	
	dbPoll.api("api/createpoll-json.jsp", {pollName: name}, function(data) {
		if(data.status == "OK") {
			window.location.reload();
		}
	});
});

/**
* Delete poll
*/
$(".delete").live("click", function() {
    var $parent = $(this).parent().parent(),
            id = $parent.attr("data-id");
		
	
    dbPoll.api("api/delpoll-json.jsp", {pollID: id}, function(data) {
         $parent.parent().remove();
    });
});

/**
* Assign a creator
*/
$(".assign").live("click", function() {
	console.log("click");
	var username = $(this).parent().find(".username").val(),
            $creators = $(this).parent().parent().find(".creators"),
            id = $(this).parent().parent().attr("data-id");
	
	dbPoll.api("api/assigncreator-json.jsp", {pollID: id, username: username}, function(data) {
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
$(".renameb").live("click", function() {
	var name = $(this).parent().find("input.rename").val(),
		id = $(this).parent().parent().attr("data-id");
		
	dbPoll.api("api/editpoll-json.jsp", {pollName: name, pollID: id}, function() {
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
	
    username = username.substr(0, username.length - 1);
	
	dbPoll.api("api/unassigncreator-json.jsp", {pollID: id, username: username}, function(data) {
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
		
		html += "<span>" + c + " <a class='del'><img src='assets/images/cross.png' valign='text-bottom' /></a></span> ";
	}
	
	return html;
}

dbPoll.exit = function() {
	$(".poll a.del").die();
	$(".renameb").die();
	$(".assign").die();
	$(".delete").die();
};