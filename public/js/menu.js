$(function(){
	$('#panel').hide();
	$('#links').hide();
	if(!$.cookie("admin")){
		$('#panel-div').hide();
	}
	load_links();
	if(location.hash!=='')
	$.ajax({
		type: 'GET',
		url: '/page/'+escape(location.hash.replace(/#/,"")),
		data: '',
		success: function(text){
			$('#box').html(text);
			$('#links li.'+location.hash.replace(/#/,"")).addClass('active');
			load_panel();
		}
	});
	$("#addpage_dialog").dialog({
		autoOpen: false,
		modal:true,
		width: 600,
		buttons: {
			"Ok": function() {
				page = $("#pagelabel").attr("value");
				$.ajax({
					type: 'POST',
					url: '/admin/'+escape(page)+'/edit',
					data: 'add='+escape(page),
					success: function(text){
						$('#box').html(text).show("slow");
						$('#panel').hide();
					}
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
		width: 600,
		buttons: {
			"Ok": function() {
				$.ajax({
					type: 'POST',
					url: '/auth',
					data: 'u='+escape($("#username").attr("value"))+'&p='+escape($("#password").attr("value")),
					success: function(){
						load_links();
						load_panel();
					}
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
	$('#links').fadeOut("slow").load('/panel/links',function(){
		$('#panel').fadeOut("slow");
		$('#links li a')
		.click(function(){
			var lin = $(this);
			var page = $(this).attr('href').replace(/#/,"");
			$('#box').hide("slow", function(){
				$.ajax({
					type: 'GET',
					url: '/page/'+escape(page),
					data: '',
					success: function(text){
						$('#links li').removeClass('active');
						$('#box').html(text).show("slow");
						$('title').html("Something Afal - "+$('.'+page).children(0).html());
						$('#links li.'+page).addClass('active');
						load_panel();
					}
				},$('#box'));
			});
		});
		load_home();
	}).fadeIn("slow");
	load_lang();
}

function load_panel(){
	$('#panel').fadeOut("slow").load('/panel/admin',function(){
		$('#panel li a')
		.click(function(){
			var action = $(this).attr('href').replace(/#/,"");
			var page = location.hash.replace(/#/,"");
			$('#box').hide("slow", function(){
				$.ajax({
					type: 'POST',
					url: '/admin/'+escape(page)+'/'+escape(action),
					data: '',
					success: function(text){
						$('#box').html(text).show("slow");
						$('#panel').hide();
					}
				},$('#box'));
			});
		});
	}).fadeIn('slow');
}

function load_lang(){
	$('#lang').load('lang.php',function(){
		$("#lang_drop")
		.msDropDown({style:"min-width:110px"})
		.change(function(){
			$.ajax({
				type: 'POST',
				url: 'lang.php',
				data: 'lang='+escape($(this).val()),
				success: function(text){
					load_links();
					location.hash==''
					load_home();
				}
			});
		});
	});
}

function load_home(){
	if(location.hash==''){
		var lin = $("#links li a span");
		var page = $("#links li a").attr('href').replace(/#/,"");
		$('#box').hide("slow", function(){
			$.ajax({
				type: 'GET',
				url: '/page/'+escape(page),
				data: '',
				success: function(text){
					$('#links li').removeClass('active');
					$('#box').html(text).show("slow");
					$('title').html("Something Afal - "+$('.'+page).children(0).html());
					$('#links li.'+page).addClass('active');
					load_panel();
				}
			},$('#box'));
		});
		load_panel();
	}
}
