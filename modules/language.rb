class Language
  include Renderer
  
  def run(session,params)
    delete! params[:delete]
    add! params[:id], params[:language]
    sort! params[:sort]
		haml_render("views/modules/language.haml", :langs => Lang.list)
  end
  
  def add_blank?(id, language)
    !(id.nil? or language.nil?)
  end
  
  def delete!(lang)
    Lang.get(lang).destroy if lang
  end
  
  def add!(id, language)
    Lang.create(:id=>id,:name=>language) unless add_blank?(id, language)
  end
  
  def sort!(params)
    params.split(',').each_with_index do |label,pos|
      lang = Lang.get(label)
      lang.pos = pos
      lang.save!
    end if params
  end
end