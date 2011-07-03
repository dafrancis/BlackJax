require 'sinatra/base'
require 'haml'

class BlackJax < Sinatra::Base
  require './lib/helpers.rb'
  require './lib/models.rb'
  
  enable :sessions
  set :public, './public'

  post '/auth' do
    authenticate! params[:u], params[:p]
  end

  get '/admin' do
    response.set_cookie("admin", 1)
    redirect '/'
  end

  post '/admin/:page/:module' do
    "Not Logged in" unless is_authenticated?
    #include_once "lib/module.php";
    require "./modules/#{params[:module]}.rb";
    mod = Kernel.const_get(params[:module].capitalize).new
    mod.run session, params
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
    @user = User.register params[:username], params[:password]
    redirect '/register' unless @user
    create_blank!
    haml :"blackjax/registered", :layout => :"blackjax/layout"
  end

  get '/page/:page' do
    page = Page.first(:label => params[:page])
    page.nil? ? "Error 404" : page.content
  end
end
