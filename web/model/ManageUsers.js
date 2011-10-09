var MAP1, MAP2, map, map2, currentLatLng, currentLatLng1;

$("#create").click(function() {
	var param = {}, pos, lat, lng,
        p = $(this).parent();
        if(!MAP1){
            dbPoll.message("Please specify a location on the map.");
        }
        else{
            pos = currentLatLng.toString().split(",");
            lat = pos[0].substr(1);
            lng = pos[1].substr(0, pos[1].length-1);
        }
	param.action = "register";
	param.userName = p.find(".username").val();
	param.email = p.find(".email").val();
	param.userLevel = p.find(".role").val();
	param.location = lat + "," + lng;
	
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
		var myOptions = {
		zoom: 8,
		center: latlng,
		mapTypeId: google.maps.MapTypeId.ROADMAP,
		mapTypeControl: false
                };
                map2 = new google.maps.Map(document.getElementById("map2"), myOptions);
		//console.log(map2, pos, latlng);
		if(MAP2) {
                    MAP2.setMap(null);
                    MAP2 = null;
                 }
                 MAP2 = createMarker2(latlng);
		
		map2.setCenter(latlng);
		
                google.maps.event.addListener(map2, "click", function(e) {
		console.log(e);
		if(MAP2) {
                    MAP2.setMap(null);
                    MAP2 = null;
                 }
                 MAP2 = createMarker2(e.latLng);
	});
		p.find(".email").val(data.email);
		p.find(".role").val(data.userLevel);
	});
	

});

$("#modify").click(function() {
	var param = {};
        var pos = currentLatLng1.toString().split(",");
        var lat = pos[0].substr(1);
        var lng = pos[1].substr(0, pos[1].length-1);
	console.log(pos);
        param.action = "edit";
	param.userName = user;
	param.password = $(this).parent().find(".password").val();
	param.location = lat + "," + lng;
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
                    MAP1.setMap(null);
                    MAP1 = null;
                 }
                 MAP1 = createMarker1(e.latLng);
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

function createMarker1(latlng) {
    
    currentLatLng = latlng;
    marker = new google.maps.Marker({
    position: latlng,
    map: map,
    zIndex: Math.round(latlng.lat()*-100000)<<5
    });   
    
    return marker;
}

function createMarker2(latlng) {
    
    currentLatLng1 = latlng;
    marker = new google.maps.Marker({
    position: latlng,
    map: map2,
    zIndex: Math.round(latlng.lat()*-100000)<<5
    });   
    
    return marker;
}