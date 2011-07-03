	$().ready(function() {
		$("ul.droptrue").sortable({
			connectWith: 'ul'
		});
		$('li.ui-state-default a.sort')
		.click(function(){
			var lin = $(this);
			var page = $(this).attr('href').replace(/#/,"");
			$('#box').hide("slow", function(){
				$.ajax({
					type: 'POST',
					url: '/page/'+escape(page),
					data: '',
					success: function(text){
						$('#links li').removeClass('active');
						$('#box').html(text).show("slow");
						$('title').html("Something Afal - "+lin.children(0).html());
						$('#links li.'+page).addClass('active');
						load_panel();
					}
				},$('#box'));
			});
		});
	});

function sort(){
	var datastring = '';
	$('.droptrue').each(function(){
		datastring += '&'+$(this).attr('id')+'='+escape($(this).sortable("toArray")+"");
	});
	$.ajax({
		type: 'POST',
		url: '/admin/sort/sort',
		data: datastring,
		success: function(text){
			$('#links li').removeClass('active');
			load_links();
			load_panel();
			$('#box').html("Sorted!");
		}
	},$('#box'));
}

