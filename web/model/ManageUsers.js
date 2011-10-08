var MAP1, MAP2, map, map2;

$("#create").click(function() {
	var param = {},
		p = $(this).parent(),
		pos = MAP1.getPosition();
	
	param.action = "register";
	param.userName = p.find(".username").val();
	param.email = p.find(".email").val();
	param.userLevel = p.find(".role").val();
	param.location = pos.Oa + "," + pos.Pa;
	
	console.log(param);
	dbPoll.api("api/user-createuser.jsp", param);
});

$("label.exp").hide();
$("#editbox").hide();

$("select.role").change(function() {
	if($(this).val() == "Poll Admin") {
		$(this).parent().next().show();
	} else {
		$(this).parent().next().hide();
	}
});

var user;
$("#edit").click(function() {
	var username = $(this).parent().find(".username").val(),
		p = $("#editbox");
	
	//set the global username
	user = username;
	
	dbPoll.api("api/user-getdetails.jsp", {returnBoolean: true, userName: username}, function(data) {
		if(data.userID == "-1") {
			username = undefined;
			$("#editbox").hide();
			return;
		}
		
		$("#editbox").show();
	
		var pos = data.location.split(","),
			latlng = new google.maps.LatLng($.trim(pos[0]), $.trim(pos[1]));
		
		console.log(map2, pos, latlng);
		MAP2 = new google.maps.Marker({
			position: latlng,
			map: map2
		});
		
		map2.setCenter(latlng);
			
		p.find(".email").val(data.email);
		p.find(".role").val(data.userLevel);
                
                google.maps.event.trigger(map, 'resize');
                google.maps.event.trigger(map2, 'resize');
	});
	
	google.maps.event.trigger(map, 'resize');
	google.maps.event.trigger(map2, 'resize');
});

$("#modify").click(function() {
	var param = {},
		pos = MAP2.getPosition();
		
	console.log(pos);
    param.action = "edit";
	param.userName = user;
	param.password = $(this).parent().find(".password").val();
	param.location = pos.Oa + "," + pos.Pa;
	param.userLevel = $(this).parent().find(".role").val();
	param.email = $(this).parent().find(".email").val();
	
	dbPoll.api("api/user-edituser.jsp", param, function() {
	
	});
});

$("#remove").click(function() {
	var username = $(this).parent().find(".username").val();
	
	dbPoll.api("api/user-deleteuser.jsp", {action: "remove", userName: username});
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

	map = new google.maps.Map(document.getElementById("map"), myOptions);
	map2 = new google.maps.Map(document.getElementById("map2"), myOptions);
	
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
		}
	});
	
	
	var html = "";
	
	switch(dbPoll.role) {
		case 6:
			html += "<option value='System Admin'>System Admin</option>";
		case 5:
			html += "<option value='Poll Admin'>Poll Admin</option>";
		case 4:
			html += "<option value='Poll Creator'>Poll Creator</option>";
		case 3:
			html += "<option value='Poll Master'>Poll Master</option>";
		default:
			html += "<option value='Web User'>Web User</option>";
			html += "<option value='Key User'>Key User</option>";
	}
	
	$("select.role").html(html);
}