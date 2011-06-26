	$().ready(function() {
		$('textarea.tinymce').tinymce({
			script_url : 'js/tiny_mce/tiny_mce.js',
			// General options
			theme : "advanced",
			plugins : "pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,advlist",

			// Theme options
			theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,formatselect",
			theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,undo,redo,|,link,unlink,anchor,image,cleanup,code",
			theme_advanced_toolbar_location : "top",
			theme_advanced_toolbar_align : "left",
			theme_advanced_statusbar_location : "bottom",
			theme_advanced_resizing : true,


			width: "580px",
			height: "350px"
		});
	});

function edit(page){
	location.hash = '#'+page;
	$.ajax({
		type: 'POST',
		url: '/admin/'+escape(page)+'/edit',
		data: 'text='+escape(tinyMCE.get('editbox').getContent())+'&title='+escape($('#edittitle').attr('value')),
		success: function(){
			$('#box').hide("slow", function(){
				$.ajax({
					type: 'GET',
					url: '/page/'+escape(page),
					data: '',
					success: function(text){
						$('#links li').removeClass('active');
						$('#box').html(text).show("slow");
						/*$('title').html("Something Afal - "+lin.html());*/
						load_links();
					}
				},$('#box'));
			});
		}
	},$('#box'));
}