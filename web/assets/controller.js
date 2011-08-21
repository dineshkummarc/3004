(function($, window, document, undefined) {
var CONTAINER;

function loadView(view) {
	var pos = view.indexOf('/'),
		qstr, vars, i = 0, l,
		page = view;
	
	//exit handler
	if(dbPoll.exit) {
		dbPoll.exit();
		dbPoll.exit = null;
	}
	
	dbPoll.q = {};
	
	//if there are some URL vars
	if(~pos) {
		qstr = view.substr(pos+1);
		vars = qstr.split('/');
		
		//add it to the dbPoll namespace
		for(l = vars.length; i < l; i += 2) {
			dbPoll.q[vars[i]] = vars[i+1];
		}
		
		page = view.substring(0, pos);
	}

	//load the HTML
	$.ajax("view/"+page+".html", {
		dataType: "html",
		cache: false,
		
		success: function(html) {
			CONTAINER.html(html);
			dbPoll.obj = {};
			
			//save all jQuery elements in an object
			$("*").each(function() {
				var id = $(this).attr("id");
				
				if(id) {
					dbPoll.obj[id] = $(this);
				}
			});
			
			//load the SCRIPT after the HTML
			var scr = document.createElement("script");
			scr.src = "model/"+page+".js?"+(+new Date);
			document.getElementsByTagName("head")[0].appendChild(scr);
		}
	});
	
	//change the URL
	window.location.hash = "#!/" + view;
}

//on document ready
$(function() {
	//get the page from the hashbang
	var page = window.location.hash.substr(3),
		head = $("head");
		
	CONTAINER = $("#container");
	
	if(!page) {
		loadView("Login");
	} else {
		loadView(page);
	}
	
	//catch all links to detect a page change
	$("a").live("click", function(e) {
		var href = $(this).attr("href");
                if(!href) return true;
		
		//need to load in a new view
		if(href.charAt(0) === ":") {
			loadView(href.substr(1));
			
			//stop the link from doing anything
			e.preventDefault();
			e.stopPropagation();
			return false;
		}
		
		//else treat as a normal link
		return true;
	});
	
	$("#notify").click(function() {
		$(this).stop().hide().css("top", -50);
	});
	
	if(navigator.userAgent.match(/Android/i) ||
		navigator.userAgent.match(/webOS/i) ||
		navigator.userAgent.match(/iPhone/i) ||
		navigator.userAgent.match(/iPod/i)
		) {
		
		$('link[rel=stylesheet]').remove();
		$("<link/>", {rel: "stylesheet", href: "assets/mobile.css", type: "text/css"}).append(head);
	}
	
	dbPoll.api("api/isloggedin.jsp", function(status) {
		if(status.username) {
			$("#top span.name").text(status.username);
		} else {
			dbPoll.go("Login");
		}
	});
});

//setup a global namespace
if(!window.dbPoll) window.dbPoll = {};

dbPoll.api = function(url, data, resp) {
	if(typeof data === "function") {
		resp = data;
		data = {};
	}
	
	$.ajax(url, {
		data: data,
		dataType: "text",
		cache: false,
		
		success: function(d) {
			//because the JSON will most 
			//likely not be well formed
            try {
				var json = eval("(" + d + ")");
			} catch(err) {
				console.log(err, d);
				dbPoll.message("<strong>Server Error:</strong> Invalid JSON data.");
			}
                     
            if(json.error) {
				dbPoll.message(json.error);
			} else if(json.status && json.status != "OK") {
				dbPoll.message(json.status);
			}
			
			if(resp) resp(json);
		},
		
		error: function() {
			dbPoll.message("<strong>Server Error:</strong> Request to server page failed.");
		}
	});
};

dbPoll.go = loadView;

dbPoll.message = function(msg) {
	var n = $("#notify");
	n.css({left: $(window).width() / 2 - n.width() / 2});
	n.show().html(msg).animate({top: 50}, 500, function() {
		$(this).delay(msg.length * 100).animate({top: -50}, 500, function() {
			$(this).html("").hide();
		});
	});
};

dbPoll.zero = function(number, width) {
	width -= number.toString().length;
	if(width > 0) {
		return new Array( width + (/\./.test( number ) ? 2 : 1) ).join( '0' ) + number;
	}
	return number;
}

})(jQuery, window, document);