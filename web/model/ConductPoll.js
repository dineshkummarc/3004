var html = "<embed codebase='http://localhost:80/'\
       archive='ControlApplet.jar,gson-1.7.1.jar,jna.jar,rc_sdk.jar'\
       code='controller.class'\
      width='950' height='600'\
      type='application/x-java-applet'\
      userid='"+dbPoll.userID+"'\
      pluginspage='http://java.sun.com/j2se/1.5.0/download.html'/>";
	  
$("#applet").html(html);

dbPoll.api("getpollsbyuser.jsp", function(data) {
	var i = 0, l = data.length,
		poll, html = "";
	
	for(; i < l; ++i) {
		poll = data[i];
		html += "<option value='"+poll.id+"'>"+poll.name+"</option>";
	}
	
	$("#poll").html(html);
});

$("#send").click(function() {
	var to = $("#to").val(),
		poll = $("#poll").val(),
		msg = $("#msg").val();
		
	dbPoll.api("api/", {});
});