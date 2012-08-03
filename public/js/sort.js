$(function() {
	$("ul.droptrue").sortable({connectWith: 'ul' });
	$('li.ui-state-default a.sort')
	.click(function(){
		var page = $(this).attr('href').replace(/#/,"");
		load_page(page)
	});
});

function sort(){
	var datastring = {};
	$('.droptrue').each(function(){
		datastring[this.id] = $(this).sortable("toArray").join(",");
	});
	$.post('/admin/sort/sort', datastring, function(text){
		$('#links li').removeClass('active');
		load_links();
		load_panel();
		$('#box').html("Sorted!");
	});
}
