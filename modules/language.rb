class Language
  include Renderer
  
  def run(session,params)
    puts params[:id]
    puts params[:language]
    Lang.get(params[:delete]).destroy if params[:delete]
    add! params[:id], params[:language] if params[:id] and params[:langauge]
    sort! params[:sort] if params[:sort]    
		langs = Lang.all(:id.not=>'nolang')
		haml_render("views/modules/language.haml", :langs=>langs)
  end
  
  def add! (id, language)
    lang Lang.new
    lang.id = id
    lang.name = language
    lang.save!
  end
  
  def sort!(params)
    params.split(',').each_with_index do |label,pos|
      lang = Lang.get(label)
      lang.pos = pos
      lang.save!
    end    
  end
end