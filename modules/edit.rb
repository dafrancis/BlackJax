class Edit
  include Renderer

  def run(session,params)
    create_if_new! params[:add]
    page = Page.first(:label=>page)
    return if save(page, params[:text], params[:title])
    haml_render("views/modules/edit.haml", :page=>page)
  end

  def create_if_new!(add)
    Lang.get('nolang').pages.create(:label => add) if add
  end
  
  def save(page, text, title)
    if text and title
      page.edit!(text, title)
      "Saved"
    end
  end
end