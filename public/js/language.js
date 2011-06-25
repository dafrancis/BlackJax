	$().ready(function() {
		$("ul.droptrue").sortable({
			connectWith: 'ul'
		});
		$('li.ui-state-default a.lang')
		.click(function(){
			var lin = $(this);
			var page = $(this).attr('href').replace(/#/,"");
			$.ajax({
				type: 'POST',
				url: 'admin.php',
				data: 'action=language&delete='+escape(page),
				success: function(text){
					lin.remove();
					$('#box').html("Deleted Language.");
				}
			});
		});
	});

function sort(){
	$.ajax({
		type: 'POST',
		url: 'admin.php',
		data: 'action=language&sort='+escape($("#lang_order").sortable("toArray")+""),
		success: function(text){
			$('#links li').removeClass('active');
			load_links();
			load_panel();
			$('#box').html("Sorted!");
		}
	},$('#box'));
}

function add(){
	$.ajax({
		type: 'POST',
		url: 'admin.php',
		data: 'action=language&id='+escape($('input[name=id]').val())+'&language='+escape($('input[name=language]').val()),
		success: function(text){
			$("#lang_order").append('<li class="ui-state-default" id="'+$('input[name=id]').val()+'">'+$('input[name=id]').val()+' <a href="#'+$('input[name=id]').val()+'" class="lang">[X]</a></li>');
			$('li.ui-state-default a.lang')
		.click(function(){
			var lin = $(this);
			var page = $(this).attr('href').replace(/#/,"");
			$.ajax({
				type: 'POST',
				url: 'admin.php',
				data: 'action=language&delete='+escape(page),
				success: function(text){
					lin.remove();
					$('#box').html("Deleted Language.");
				}
			});
		});
		}
	},$('#box'));
}