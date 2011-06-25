class Edit
  def run(session,params)
    if params[:add]
      puts "THIS CLASS IS NIBBLING ON MY NUTS"
      Page.create(:label => params['add'].chomp)
    end
    page = Page.first(:label=>params[:page].chomp)
    return save(page,params[:text],params[:title]) if(params[:text] and params[:title])
    '<form onsubmit="edit(\''+params[:page]+'\'); return false;">
		<strong>Title:</strong> <input type="text" id="edittitle" value="'+(params[:add] ? '' : page.title)+'" /><br />
		<strong>Content:</strong><br/>
		<textarea id="editbox" class="tinymce" cols="50" rows="15">'+(params[:add] ? '' : page.content)+'</textarea>
		<input type="submit" value="Save"/>
		</form>
		<script type="text/javascript" src="js/tiny_mce/jquery.tinymce.js"></script>
		<script type="text/javascript" src="js/edit.js"></script>'
  end
  
  def save(page, text, title)
    page.content = text
    page.title = title
    page.save
    "Saved"
  end
end