$("#private-div").hide();

dbPoll.api("api/reportPoll.jsp", {userID: 2}, function(data) {
	var i = 0, l = data.length, html = "", p;
	
	for(; i < l; ++i) {
		p = data[i];
		html += "<option value='"+p.pollID+"'>"+p.PollName+"</option>";
	}
	
	$("#polls").html(html);
});

$("#mType").change(function() {
    var id = $("#polls").val();
    var type = $(this).val();
    
    if(type==="private"){
        dbPoll.api("api/getUsersByAssigned.jsp", {pollID: id}, function(data) {
		var i = 0, l = data.length, html = "<option value='-1'>--</option>", p;
            for(; i < l; ++i) {
                
                p = data[i];
               html += "<option value='"+p.userID+"'>"+p.UserName+"</option>";
            }
            
            $("#messageUser").html(html);
	});
        $("#private-div").show();
    }
    else{
        $("#private-div").hide();
    }
});


$("#message-submit").click(function() {
    
    var isValid = true;
    var error = "";
    var param = {};
    
    var text = $("#mText").val();
    if($("#mType").val()==="private"){
        if($("#messageUser").val()==="-1"){
            isValid = false;
            error = "Must specify a user.";
        }
        else{
            param.to = $("#messageUser").val(); 
        }        
    }
    param.pollID = $("#polls").val();
    param.type = "send";
    param.sType = $("#mType").val();
    param.message = text;
    param.from = 2; // should delete this after session is working
    
    if(jQuery.trim(text)==="" && isValid){
        isValid = false;
        error = "You haven't entered any text!";
    }
    
    if(isValid){
        dbPoll.api("api/message.jsp?"+$.param(param), function(data) {
            dbPoll.message("<strong> Message has been Sent.</strong>");
            $("#mText").val("");
        }); 
    }
    else{
        dbPoll.message(error);
    }
    
});


