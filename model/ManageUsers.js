var MAP1, MAP2;

$("#create").click(function() {
	var param = {},
		p = $(this).parent(),
		pos = MAP1.getPosition();
	
	param.action = "register";
	param.username = p.find(".username").val();
	param.password = p.find(".password").val();
	param.email = p.find(".email").val();
	param.userType = p.find(".role").val();
	param.location = "(" + pos.Na + "," + pos.Oa + ")";
	
	console.log(param);
	dbPoll.api("edituser.jsp", param);
});

$("label.exp").hide();
$("#editbox").hide();

$("select.role").change(function() {
	if($(this).val() == 4) {
		$(this).parent().next().show();
	} else {
		$(this).parent().next().hide();
	}
});

var user;
$("#edit").click(function() {
	$("#editbox").toggle();
	var username = $(this).parent().find(".username").val(),
		p = $("#editbox");
	
	//set the global username
	if(!user) {
		user = username;
	} else {
		user = undefined;
	}
	
	dbPoll.api("edituser.jsp", {returnBoolean: true, userName: username}, function(data) {
		var pos = data.location.split(",");
		
		MAP2.setPosition(new google.maps.LatLng(pos[0], pos[1]));
		p.find(".email").val(data.email);
		p.find(".role").val(data.userLevel);
	});
	
	google.maps.event.trigger(map, 'resize');
	google.maps.event.trigger(map2, 'resize');
});

$("#modify").click(function() {
	var param = {},
		pos = MAP2.getPosition();
		
	param.userName = user;
	param.password = $(this).parent().find(".password").val();
	param.location = "(" + pos.Na + "," + pos.Oa + ")";
	param.userLevel = $(this).parent().find(".role").val();
	param.email = $(this).parent().find(".role").val();
	
	dbPoll.api("edituser.jsp", param, function() {
	
	});
});

$("#remove").click(function() {
	var username = $(this).parent().find(".username").val();
	
	dbPoll.api("edituser.jsp", {action: "remove", userName: username});
});


function init() {
	console.log("TEST");
	var latlng = new google.maps.LatLng(-27.45741210341303, 153.01979345703126);
	var myOptions = {
		zoom: 8,
		center: latlng,
		mapTypeId: google.maps.MapTypeId.ROADMAP,
		mapTypeControl: false
	};

	var map = new google.maps.Map(document.getElementById("map"), myOptions);
	var map2 = new google.maps.Map(document.getElementById("map2"), myOptions);
	
	google.maps.event.addListener(map, "click", function(e) {
		console.log(e);
		if(MAP1) {
			MAP1.setPosition(e.latLng);
		} else {
			MAP1 = new google.maps.Marker({
				position: e.latLng,
				map: map
			});
		}
	});
	
	google.maps.event.addListener(map2, "click", function(e) {
		console.log(e);
		if(MAP2) {
			MAP2.setPosition(e.latLng);
		} else {
			MAP2 = new google.maps.Marker({
				position: e.latLng,
				map: map2
			});
		}
	});
	
}