class Edit
  def run(session,params)
    add = params[:add]
    Lang.get('nolang').pages.create(:label => add) if add
    page = Page.first(:label=>params[:page])
    return save(page,params[:text],params[:title]) if params[:text] and params[:title]
    <<-eos
    <form onsubmit="edit('#{params[:page]}'); return false;">
		<strong>Title:</strong> <input type="text" id="edittitle" value="#{(add ? '' : page.title)}" /><br />
		<strong>Content:</strong><br/>
		<textarea id="editbox" class="tinymce" cols="50" rows="15">#{(add ? '' : page.content)}</textarea>
		<input type="submit" value="Save"/>
		</form>
		<script type="text/javascript" src="js/tiny_mce/jquery.tinymce.js"></script>
		<script type="text/javascript" src="js/edit.js"></script>"
    eos
  end
  
  def save(page, text, title)
    page.content = text
    page.title = title
    page.save
    "Saved"
  end
end