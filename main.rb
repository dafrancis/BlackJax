require 'sinatra'
require 'haml'
require 'data_mapper'

enable :sessions

helpers do
  Dir["./helpers/*.rb"].each do |file|
    require file
    include Kernel.const_get(file.gsub(/(\.\/helpers\/|\.rb)/,'').capitalize)
  end
end

# Models
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite:data")
Dir["./models/*"].each {|file| require file }
DataMapper.finalize.auto_upgrade!

def get_lang
  session[:lang] ||= Lang.first(:order =>[:pos.asc]).id
end

post '/auth' do
  user = User.login(params[:u],params[:p])
  unless user.nil?
    session[:user] = {}
    session[:user][:username] = user.username
    session[:user][:pass_hash] = user.pass_hash
  end
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
  @modules = Dir['./modules/*.rb'].map{|n| n.gsub(/(\.\/modules\/|\.rb)/,'')}
  haml :modules
end

get '/' do
  redirect '/register' if User.all == []
  "BlackJax"
  erb :index
end

get '/register' do
  redirect '/' unless User.all == []
  haml :"blackjax/register", :layout => :"blackjax/layout"
end

post '/register' do
  @user = User.register params[:username], params[:password]
  redirect '/register' unless @user
  if User.all.length == 1
    lang = Lang.create(:id=>'en_GB',:name=>'English')
    lang.pages.create(:label=>'home',:title=>'Hello!',:content=>'Congratulations on installing BlackJax!',:pos=>0)
  end
  haml :"blackjax/registered", :layout => :"blackjax/layout"
end

get '/page/:page' do
  page = Page.first(:label => params[:page])
  page.nil? ? "Error 404" : page.content
end