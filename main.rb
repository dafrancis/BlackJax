require 'sinatra'
require 'haml'
require 'data_mapper'

# Models
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite:data")
Dir["./models/*"].each {|file| require file }
DataMapper.finalize.auto_upgrade!

def get_lang
  session[:lang] ||= Lang.first(:order =>[:pos.asc]).id
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
  Page.first(:label => params[:page]).content
end
