class Edit
  include Renderer

  def run(session,params)
    add = params[:add]
    Lang.get('nolang').pages.create(:label => add) if add
    page = Page.first(:label=>params[:page])
    return save(page,params[:text],params[:title]) if params[:text] and params[:title]
    haml_render("views/modules/edit.haml", :page=>page)
  end
  
  def save(page, text, title)
    page.content = text
    page.title = title
    page.save
    "Saved"
  end
end