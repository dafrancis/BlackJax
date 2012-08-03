function edit(page){
	var data = {
		text: editor.exportFile(),
		title: $('#edittitle').attr('value')
	};
	$.post('/admin/'+escape(page)+'/edit', data, function(){
		load_links();
		location.hash = "#/" + page
	});
}

var editor = new EpicEditor({
	clientSideStorage: false,
	file: {
		defaultContent: $("#epiceditor").html()
	}
}).load();