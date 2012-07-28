require 'sinatra/base'
require 'haml'
require 'data_mapper'

class BlackJax < Sinatra::Base
  # Load Helpers
  Dir["./helpers/*.rb"].each do |file|
    require file
    hel = file.gsub(%r{(./helpers/|.rb)},'').capitalize
    helpers Kernel.const_get(hel)
  end

  Util.load_models
  enable :sessions

  post '/auth' do
    authenticate! params[:u], params[:p]
  end

  get '/admin' do
    response.set_cookie("admin", 1)
    redirect '/'
  end

  post '/admin/:page/:module' do
    return "Not Logged in" unless is_authenticated?
    get_and_run params[:module]
  end

  # Panels
  get '/panel/links' do
    @pages = Lang.get(get_lang).pages(:order =>[:pos.asc])
    haml :links
  end

  get '/panel/admin' do
    @modules = Dir['./modules/*.rb'].map{|n| n.gsub(%r{(./modules/|.rb)},'')}
    haml :modules
  end

  get '/' do
    redirect '/register' if User.all == []
    erb :index
  end

  get '/register' do
    redirect '/' unless User.all == []
    haml :"blackjax/register", :layout => :"blackjax/layout"
  end

  post '/register' do
    register!
    create_blank!
    haml :"blackjax/registered", :layout => :"blackjax/layout"
  end

  get '/page/:page' do
    Page.get_content(params[:page])
  end
  
  get '/lang' do
    @langs = Lang.all(:id.not=>'nolang', :order=>[:pos.asc])
    haml :"blackjax/lang"
  end
  
  post '/lang' do
    session[:lang] = params[:lang]
  end
end
