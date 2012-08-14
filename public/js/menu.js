$(function(){
	if(!$.cookie("admin")){
		$('#panel-div').show();
	}
	load_links();
	$("#addpage_dialog").dialog(dialog_opts(function() {
		var page = $("#pagelabel").val();
		$.post('/admin/'+escape(page)+'/edit', {add: page}, function(text){
			$('#box').html(text);
		});
		$(this).dialog("close"); 
	}));
	$("#loginlinkdialog").dialog(dialog_opts(function() {
		var data = {
			u: $("#username").val(),
			p: $("#password").val()
		}
		$.post('/auth', data, function() {
			load_links();
			location.hash = "#/";
		});
		$(this).dialog("close"); 
	}));
});

function dialog_opts(func) {
	return {
		autoOpen: false,
		modal:true,
		width: 300,
		buttons: {
			"Ok": func, 
			"Cancel": function() { 
				$(this).dialog("close"); 
			} 
		}
	}
}

function load_page(page) {
	$.get('/page/' + page, function (text) {
		$('#links li').removeClass('active');
		if (text !== "<p>Error 404</p>\n") {
			$('#box').html(text);
			$('title').html("BlackJax - " + $('.' + page).children(0).html());
			$('#links li.' + page).addClass('active');
		} else {
			$('#box').html("<h2>Error 404</h2><canvas id='corgi' width='640' height='480'></canvas>");
			corgiCanvas();
		}
		load_panel(page);
	});
}

function load_links(callback){
	$('#links').load('/panel/links', callback);
	load_lang();
}

function load_panel(page){
	$('#panel').load('/panel/admin',function(){
		$(this).find('li a')
		.click(function (e) {
			e.preventDefault();
			var action = $(this).attr('href').replace(/#/, "");
			location.hash = "#/" + page + "/" + action;
		});
	});
}

function load_lang(){
	$('#lang').load('/lang',function(){
		$("#lang_drop")
		.msDropDown({style:"min-width:110px"})
		.change(function(){
			var data = {
				lang: this.value
			};
			$.post("/lang", function(text){
				load_links();
				location.hash = '#/'
			});
		});
	});
}

var bix = Bix({
	"/": function () {
		location.hash = $("#links li a").first().attr('href');
	},
	"/:page": load_page,
	"/:page/:action": function (page, action) {
		$.post('/admin/' + page + '/' + action, function(text){
			$('#box').html(text);
		});
	}
});

bix.config({
	forceHash: true
});

$(function () {
	load_links(bix.run);
});

Mousetrap.bind('g o t t a g o f a s t', function () {
	// http://jsfiddle.net/zmj4b/2/embedded/result/
	function ms(){var e=document.createElement("img");e.setAttribute("src","http://i.imgur.com/kqnvD.jpg"),e.setAttribute("width",50),document.body.appendChild(e),e.style.position="fixed",setInterval(function(){if(!e.style.left||+e.style.left.replace("px","")>winW)e.style.top=winH*Math.random()+"px",e.pos=0,e.speed=50*Math.random();e.style.left=e.pos+"px",e.pos+=e.speed},30)}var winW=630,winH=460;document.body&&document.body.offsetWidth&&(winW=document.body.offsetWidth,winH=document.body.offsetHeight),document.compatMode=="CSS1Compat"&&document.documentElement&&document.documentElement.offsetWidth&&(winW=document.documentElement.offsetWidth,winH=document.documentElement.offsetHeight),window.innerWidth&&window.innerHeight&&(winW=window.innerWidth,winH=window.innerHeight),document.body.innerHTML+='<iframe width="1" height="1" src="http://www.youtube.com/embed/H0MwvOJEBOM?autoplay=1" frameborder="0" allowfullscreen></iframe>';for(var i=0;i<10;i++)ms()
});

function corgiCanvas() {
	var canvas = document.getElementById("corgi");
	var c = canvas.getContext("2d");
	var FPS = 30;

	function randomRange (min, max) {
	    return ((Math.random()*(max-min)) + min);
	}

	function sprintf(format) {
	    for (var i = 1; i < arguments.length; i++)
	        format = format.replace("%s", arguments[i]);
	    return format;
	}

	function color(r, g, b, opacity) {
	    return sprintf("rgba(%s, %s, %s, %s)", r, g, b, opacity);
	}

	c.drawCircle = function (x, y, radius) {
	    this.beginPath();
	    this.arc(x, y, radius, 0, Math.PI * 2, true);
	    this.closePath();
	    this.fill();
	};

	c.dImage = function (b) {
	    this.drawImage(b.img, b.mp.cx, b.mp.cy, b.mp.radius, b.mp.radius);
	};

	var stars = []

	function makeStar() {
	    var star = {
	        x: 0,
	        y: randomRange(0, canvas.height),
	        size: 5,
	        color: color(200, 255, 0, 1)
	    }
	    stars.push(star);
	}

	function drawStars() {
	    var star;
	    for (var i = 0; i < stars.length; i++) {
	        star = stars[i];
	        c.fillStyle = "#f7f8af";
	        c.drawCircle(star.x, star.y, star.size);
	        star.x += 5;
	        stars[i] = star;
	    }
	}

	var corg = new Image();
	corg.src = "http://i.imgur.com/NLjFg.png"

	corg.mp = {
	    cx: 400,
	    cy: 250,
	    theta: 0,
	    speed: 2,
	    radius: 50,
	}

	function drawCorg() {
	    corg.mp.theta = (corg.mp.theta + corg.mp.speed/FPS) % 360;
	    if (corg.mp.theta <= 0) corg.mp.theta += 360;
	    var y = corg.mp.cy + corg.mp.radius*Math.sin(corg.mp.theta);

	    c.drawImage(corg, corg.mp.cx, y, 250, 250);
	}

	var make = true;

	function draw() {
	    if(make = !make) makeStar();
	    c.clearRect(0, 0, canvas.width, canvas.height);
	    c.fillStyle = "#003955";
	    c.fillRect(0, 0, canvas.width, canvas.height);
	    drawStars();
	    drawCorg();
	}


	for (var i = 0; i < 150; i++) draw();

	setInterval(draw, FPS);
}