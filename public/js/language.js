$(function() {
	$("ul.droptrue").sortable({
		connectWith: 'ul'
	});
	$('li.ui-state-default a.lang')
	.click(function(){
		var lin = $(this);
		var page = $(this).attr('href').replace(/#/,"");
		$.post('/admin/lang/language', {delete: page}, function(text){
			lin.remove();
			$('#box').html("Deleted Language.");
		});
	});
});

function sort(){
	var data = {
		sort: $("#lang_order").sortable("toArray").join(",")
	};
	$.post('/admin/lang/language', data, function(text){
		$('#links li').removeClass('active');
		load_links();
		load_panel();
		$('#box').html("Sorted!");
	});
}

function add(){
	var data = {
		id: $('input[name=id]').val(),
		language: $('input[name=language]').val()
	};
	$.post('/admin/lang/language', data, function(text){
		$("#lang_order").append('<li class="ui-state-default" id="'+$('input[name=id]').val()+'">'+$('input[name=id]').val()+' <a href="#'+$('input[name=id]').val()+'" class="lang">[X]</a></li>');
		$('li.ui-state-default a.lang')
		.click(function(){
			var lin = $(this);
			var page = $(this).attr('href').replace(/#/,"");
			$.post('/admin/lang/language', {delete: page}, function(text){
				lin.remove();
				$('#box').html("Deleted Language.");
			});
		});
	});
}