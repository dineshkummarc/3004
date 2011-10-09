var MAP, marker, currentLatLng;



$("#poll").change(function() {
	var id = $(this).val();
	
	dbPoll.api("api/poll-getlocation.jsp", {id: id}, function(data) {
		var pos = data.location.split(","),
			latlng = new google.maps.LatLng($.trim(pos[0]), $.trim(pos[1]));
			
		if(marker) {
                    marker.setMap(null);
                    marker = null;
                 }
                 marker = createMarker(latlng);
		
		MAP.setCenter(latlng);
	});
});

$("#submit").click(function() {
	var param = {};
        param.id = $("#poll").val();
	
        //var pos = marker.getLatLng();
        var str_pos = currentLatLng.toString().split(",");
        //alert(currentLatLng.toString());
	var lat = str_pos[0].substr(1);
        var lng = str_pos[1].substr(0, str_pos[1].length-1)
        param.location = lat + "," + lng;
        // Convert latlng to address_components.
    
    geocoder = new google.maps.Geocoder(); // init for geocoder
    var latlng = new google.maps.LatLng(lat, lng);            
    geocoder.geocode({'latLng': latlng}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
          if (results[1]) {
              var country, state = "No State", city = "No City", suburb = "No Suburb", street = "No Street",
              unit = "No Unit";
              var add_com = results[0].address_components, type;
              for(var i=0; i<add_com.length; i++){
                  type = add_com[i].types[0];
                  
                  if(type==="street_number"){
                      unit = add_com[i].long_name;
                      //alert(unit);
                  }
                  else if(type==="route"){
                      street = add_com[i].long_name;
                      //alert(street);
                  }
                  else if(type==="sublocality"){
                      suburb = add_com[i].long_name;
                      //alert(suburb);
                  }
                  else if(type==="locality"){
                      city = add_com[i].long_name;
                      //alert(city);
                  }
                  else if(type==="administrative_area_level_1"){
                      state = add_com[i].long_name;
                      //alert(state);
                  }
                  else if(type==="country"){
                      country = add_com[i].long_name;
                      //alert(country);
                  }
                }
                param.country = country;
                param.state = state;
                param.city = city;
                param.suburb = suburb;
                param.street = street;
                param.unit = unit;
                dbPoll.api("api/poll-setlocation.jsp", param);
            }
        }else {
            alert("Geocoder failed due to: " + status);
        }
    });
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
                    marker.setMap(null);
                    marker = null;
                 }
                 marker = createMarker(e.latLng);

	});
        
        dbPoll.api("api/user-getpolls.jsp", function(data) {
	var i = 0, l = data.length, html = "", poll;
	
	for(; i < l; ++i) {
		poll = data[i];
		html += "<option value='"+poll.pollID+"'>"+poll.pollName+"</option>";
	}
	
	$("#poll").html(html).trigger("change");
});
}

function createMarker(latlng) {
    
    currentLatLng = latlng;
    marker = new google.maps.Marker({
    position: latlng,
    map: MAP,
    zIndex: Math.round(latlng.lat()*-100000)<<5
    });   
    
    return marker;
}



   
 
