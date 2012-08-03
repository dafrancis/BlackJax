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
		$('#box').html(text);
		$('title').html("BlackJax - " + $('.' + page).children(0).html());
		$('#links li.' + page).addClass('active');
		load_panel(page);
	});
}

function load_links(){
	$('#links').load('/panel/links');
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
		location.hash = $("#links li a").attr('href');
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

bix.run();