class Panel < BlackJax
  def get_lang
    session[:lang] ||= Lang.first(:order =>[:pos.asc])
  end
  
  get '/links' do
    @pages = get_lang.pages(:order =>[:pos.asc])
    haml :links
  end

  get '/admin' do
    @modules = Dir['./modules/*.rb'].map{|n| n.gsub(%r{(./modules/|.rb)},'')}
    haml :modules
  end
end