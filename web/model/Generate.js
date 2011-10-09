$("#su-submit").click(function() {
	window.location = "api/report.jsp?type=system"
});

$("#sh-submit").click(function() {
	window.location = "api/report.jsp?type=session"
});

dbPoll.api("api/reportPoll.jsp", {}, function(data) {
	var i = 0, l = data.length, html = "", p;
	
	for(; i < l; ++i) {
		p = data[i];
		html += "<option value='"+p.pollID+"'>"+p.PollName+"</option>";
	}
	
	$("#polls").html(html).trigger("change");
});

$("#location-div").hide();
$("#statis-div").show();

$("#r-type").change(function() {
	var type = $(this).val();
	
	if(type==="statistical"){
            $("#statis-div").show();
        }
        else{
            $("#statis-div").hide();
        }
});


$("#polls").change(function() {
	var id = $(this).val();
	
	dbPoll.api("api/reportQuestion.jsp", {pollID: id}, function(data) {
		var i = 0, l = data.length, html = "<option value='-1'>--</option><option value='individual'>Individual</option>"+
"<option value='location'>Location</option>", p;
		
		for(; i < l; ++i) {
			p = data[i];
			
			html += "<option value='"+p.questID+"'>"+p.Question+"</option>";
		}
		
		
		$("#filter").html(html).trigger("change");
	});
});

$("#filter").change(function() {
	var id = $("#polls").val();
        
        if($(this).val() === "") return;
	
	if($(this).val() === "individual") {
                $("#value-div").show('slow');
		dbPoll.api("api/getUsersByAttendence.jsp", {pollID: id}, function(data) {
			var i = 0, l = data.length, html = "<option value='-1'>---</option>", user;
		
			for(; i < l; ++i) {
				user = data[i];
				
				html += "<option value='"+user.userID+"'>"+user.UserName+"</option>";
			}
			
			$("#value").html(html);
		});
		
		$("#chartsel").html("<option value='Bar'>Bar</option>");
		$("#location-div").hide();
	}
        else if($(this).val() === "location"){
            $("#location-div").show('slow');
            $("#value-div").hide();
            dbPoll.api("api/reportLocation.jsp", {pollID: id, type: "country"}, function(data) {
			var i = 0, l = data.length, html = "<option value='-1'>---</option>", country;
		
			for(; i < l; ++i) {
				country = data[i];
				
				html += "<option value='"+country.Location+"'>"+country.Location+"</option>";
			}
			
			$("#country-value").html(html).trigger("change");
		});
                
		$("#chartsel").html("<option value='Bar'>Bar</option>");
        }
        else {  
            $("#value-div").show('slow');
            dbPoll.api("api/reportAnswer.jsp", {questID: $(this).val()}, function(data) {
                    var i = 0, l = data.length, html = "<option value='-1'>---</option>", ans;

                    for(; i < l; ++i) {
                            ans = data[i];

                            html += "<option value='"+ans.Answer+"'>"+ans.Answer+"</option>";
                    }

                    $("#value").html(html);
            });

            $("#chartsel").html("<option value='Bar'>Bar</option><option value='Pie'>Pie</option>");
            $("#location-div").hide();
	}
});

// For all select under div

$("#country-value").change(function() {
    var id = $("#polls").val();
    var country = $("#country-value").val();
    var html = "<option value='-1'>---</option>"
    if(country != "-1"){
        dbPoll.api("api/reportLocation.jsp", {pollID: id, type: "state", 
            country: country}, function(data) {

            var i = 0, l = data.length, state;

            for(; i < l; ++i) {
                    state = data[i];

                    html += "<option value='"+state.Location+"'>"+state.Location+"</option>";
            }

            $("#state-value").html(html).trigger("change");
        });
    }
    else{
        $("#state-value").html(html).trigger("change");
    }
});

$("#state-value").change(function() {
    var id = $("#polls").val();
    var state = $("#state-value").val();
    var html = "<option value='-1'>---</option>";
    if(state != "-1"){
        dbPoll.api("api/reportLocation.jsp", {pollID: id, type: "city",
            state: state}, function(data) {
            var i = 0, l = data.length, city;

            for(; i < l; ++i) {
                    city = data[i];

                    html += "<option value='"+city.Location+"'>"+city.Location+"</option>";
            }

            $("#city-value").html(html).trigger("change");
        });
    }
    else{
        $("#city-value").html(html).trigger("change");
    }
});

$("#city-value").change(function() {
    var id = $("#polls").val();
    var city = $("#city-value").val();
    var html = "<option value='-1'>---</option>";
    if(city != "-1"){
        dbPoll.api("api/reportLocation.jsp", {pollID: id, type: "suburb",
            city: city}, function(data) {
            var i = 0, l = data.length, html = "<option value='-1'>---</option>", suburb;

            for(; i < l; ++i) {
                    suburb = data[i];

                    html += "<option value='"+suburb.Location+"'>"+suburb.Location+"</option>";
            }

            $("#suburb-value").html(html).trigger("change");
        });
    }
    else{
        $("#suburb-value").html(html).trigger("change");
    }
});

$("#suburb-value").change(function() {
    var id = $("#polls").val();
    var suburb = $("#suburb-value").val();
    var html = "<option value='-1'>---</option>";
    if(suburb != "-1"){
        dbPoll.api("api/reportLocation.jsp", {pollID: id, type: "street",
            suburb: suburb}, function(data) {
            var i = 0, l = data.length, html = "<option value='-1'>---</option>", street;

            for(; i < l; ++i) {
                    street = data[i];

                    html += "<option value='"+street.Location+"'>"+street.Location+"</option>";
            }
            $("#street-value").html(html).trigger("change");
        });
    }
    else{
        $("#street-value").html(html).trigger("change");
    }
});

// Comparision Select change trigger for chart
$("#location-compare").change(function() {
    
    if($("#location-compare").val()==="F"){
        $("#chartsel").html("<option value='Bar'>Bar</option><option value='Pie'>Pie</option>");
        
    }
    else{
        $("#chartsel").html("<option value='Bar'>Bar</option>");
    } 
});
// End of location div

$("#sr-submit").click(function() {
        var type = $("#r-type").val();
	var param = {};
        var isValid = true;
        var error = "";
        if(type==="statistical"){
            if($("#filter").val()=== "individual"){

                param.pollID = $("#polls").val();
                param.user = $("#value").val();
                param.type = "individual";
                if($("#value").val()==="-1"){
                    isValid = false;
                    error = "Must specify a user.";
                }
            }
            else if($("#filter").val()=== "location"){

                param.pollID = $("#polls").val();
                param.type = "location";
                param.graph = $("#chartsel").val();
                param.comparison = $("#location-compare").val();
                param.country = $("#country-value").val();
                param.state = $("#state-value").val();
                param.city = $("#city-value").val();
                param.suburb = $("#suburb-value").val();
                param.street = $("#street-value").val();

            }
            else{
                param.pollID = $("#polls").val();
                param.demoID = $("#filter").val();
                param.demoValue = $("#value").val();
                param.graph = $("#chartsel").val();
                param.type = "statistical";
            //param.location = $("#location").val();
            }
        }
        else{
            param.pollID = $("#polls").val();
            param.type = "session_p";
        }
        if(isValid){
            window.location = "api/report.jsp?"+$.param(param);
        }
        else{
            dbPoll.message(error);
        }
});