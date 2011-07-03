class Language
  include Renderer
  
  def run(session,params)
    delete! params[:delete] if params[:delete]
    add! params[:id], params[:language] unless add_blank? params
    sort! params[:sort] if params[:sort]
		haml_render("views/modules/language.haml", :langs => Lang.all(:id.not=>'nolang',:order=>[:pos.asc]))
  end
  
  def add_blank?(params)
    !(params[:id].nil? or params[:langauge].nil?)
  end
  
  def delete!(lang)
    Lang.get(lang).destroy
  end
  
  def add!(id, language)
    Lang.create(:id=>id,:name=>language)
  end
  
  def sort!(params)
    params.split(',').each_with_index do |label,pos|
      lang = Lang.get(label)
      lang.pos = pos
      lang.save!
    end    
  end
end