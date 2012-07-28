class Sort
  include Renderer
  
  def run(session,params)
    return save! params if params[:nolang]
    html = ''
    langs = Lang.all(:order=>[:pos.asc])
    haml_render("views/modules/sort.haml", :langs=>langs)
  end
  
  def save!(params)
    Page.reset_lang
    Lang.set_lang params
    "DONE!"
  end
end