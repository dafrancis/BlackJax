class Panel < BlackJax
  def get_lang
    session[:lang] ||= Lang.first(:order =>[:pos.asc])
  end
  
  get '/links' do
    @pages = get_lang.pages(:order =>[:pos.asc])
    haml :links, :layout => false
  end

  get '/admin' do
    @modules = Dir['./modules/*.rb'].map{|n| n.gsub(%r{(./modules/|.rb)},'')}
    haml :modules, :layout => false
  end
end