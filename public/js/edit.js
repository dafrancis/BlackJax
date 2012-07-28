function edit(page){
	location.hash = '#'+page;
	var data = {
		text: editor.exportFile(),
		title: $('#edittitle').attr('value')
	};
	$.post('/admin/'+escape(page)+'/edit', data, function(){
		$.get('/page/'+escape(page), function(text){
			$('#links li').removeClass('active');
			$('#box').html(text);
			load_links();
		});
	});
}

var editor = new EpicEditor({
	clientSideStorage: false,
	file: {
		defaultContent: $("#epiceditor").html()
	}
}).load();
