class Sort
  include Renderer
  
  def run(session,params)
    return save! params if params.length > 2
    html = ''
    langs = Lang.all(:order=>[:pos.asc])
    haml_render("views/modules/sort.haml", :langs=>langs)
  end
  
  def save!(params)
    #Order the Pages
    Page.all.each do |page|
      page.lang_id = 'nolang'
      page.save!
    end
    Lang.all(:id.not=>'nolang').each do |lang|
      puts "it gets here"
      params[lang.id].split(',').each_with_index do |label,pos|
        page = Page.first(:label=>label)
        page.lang_id = lang.id
        page.pos = pos
        page.save!
      end
    end
    "DONE!"
  end
end