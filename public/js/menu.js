$(function(){
	if(!$.cookie("admin")){
		$('#panel-div').show();
	}
	load_links();
	if(location.hash!=='')
	$.get('/page/'+escape(location.hash.replace(/#/,"")), function(text){
		$('#box').html(text);
		$('#links li.'+location.hash.replace(/#/,"")).addClass('active');
		load_panel();
	});
	$("#addpage_dialog").dialog({
		autoOpen: false,
		modal:true,
		width: 300,
		buttons: {
			"Ok": function() {
				page = $("#pagelabel").attr("value");
				$.post('/admin/'+escape(page)+'/edit', {add: page}, function(text){
					$('#box').html(text);
				});
				$(this).dialog("close"); 
			}, 
			"Cancel": function() { 
				$(this).dialog("close"); 
			} 
		}
	});
	$("#loginlinkdialog").dialog({
		autoOpen: false,
		modal:true,
		width: 300,
		buttons: {
			"Ok": function() {
				var data = {
					u: $("#username").val(),
					p: $("#password").val()
				}
				$.post('/auth', data, function() {
					load_links();
					load_panel();
				});
				$(this).dialog("close"); 
			}, 
			"Cancel": function() { 
				$(this).dialog("close"); 
			} 
		}
	});
});

function load_links(){
	$('#links').load('/panel/links',function(){
		$('#links li a')
		.click(function(){
			var lin = $(this);
			var page = $(this).attr('href').replace(/#/,"");
			$.get('/page/'+escape(page), function (text) {
				$('#links li').removeClass('active');
				$('#box').html(text);
				$('title').html("BlackJax - "+$('.'+page).children(0).html());
				$('#links li.'+page).addClass('active');
				load_panel();
			});
		});
		load_home();
	});
	load_lang();
}

function load_panel(){
	$('#panel').load('/panel/admin',function(){
		$(this).find('li a')
		.click(function(){
			var action = $(this).attr('href').replace(/#/,"");
			var page = location.hash.replace(/#/,"");
			$.post('/admin/'+escape(page)+'/'+escape(action), function(text){
				$('#box').html(text).show(0);
				$('#panel').show();
			});
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
				location.hash==''
				load_home();
			});
		});
	});
}

function load_home(){
	if(location.hash==''){
		var lin = $("#links li a span");
		var page = $("#links li a").attr('href').replace(/#/,"");
		$.get('/page/'+escape(page), function(text){
			$('#links li').removeClass('active');
			$('#box').html(text);
			$('title').html("BlackJax - "+$('.'+page).children(0).html());
			$('#links li.'+page).addClass('active');
			load_panel();
		});
		load_panel();
	}
}
