var MAP, marker;

dbPoll.api("api/users_getassignedpolls.jsp", function(data) {
	var i = 0, l = data.length, html = "", poll;
	
	for(; i < l; ++i) {
		poll = data[i];
		html += "<option value='"+poll.pollID+"'>"+poll.pollName+"</option>";
	}
	
	$("#poll").html(html);
});

$("#poll").change(function() {
	var id = $(this).val();
	
	dbPoll.api("api/all_set_get_geolocation.jsp", {action: "load", type: "poll", id: id}, function(data) {
		var pos = data.location.split(","),
			latlng = new google.maps.LatLng(pos[0], pos[1]);
			
		if(marker) {
			marker.setPosition(latlng);
		} else {
			marker = new google.maps.Marker({
				position: latlng,
				map: MAP
			});
		}
		
		MAP.setCenter(latlng);
	});
});

$("#submit").click(function() {
	var param = {},
		pos = marker.getPosition();
		
	param.pollID = $("#poll").val();
	param.action = "set";
	param.location = pos.Oa + "," + pos.Pa;
	
	dbPoll.api("api/all_set_get_geolocation.jsp", param);
});

function init() {
	var latlng = new google.maps.LatLng(-27.45741210341303, 153.01979345703126);
	var myOptions = {
		zoom: 8,
		center: latlng,
		mapTypeId: google.maps.MapTypeId.ROADMAP,
		mapTypeControl: false
	};

	MAP = new google.maps.Map(document.getElementById("map"), myOptions);
	
	google.maps.event.addListener(MAP, "click", function(e) {
		console.log(e);
		if(marker) {
			marker.setPosition(e.latLng);
		} else {
			marker = new google.maps.Marker({
				position: latlng,
				map: MAP
			});
		}
	});
}