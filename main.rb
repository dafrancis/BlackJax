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
def panel_links
  Lang.get(get_lang).pages(:order =>[:pos.asc]).map{|n| n.title}
end

def panel_admin
  Dir['./modules/*.rb'].map{|n| n.gsub(/(\.\/modules\/|\.rb)/,'').capitalize}
end

get '/' do
  redirect '/register' if User.all == []
  "BlackJax"
  a = panel_links
  puts panel_links
  panel_admin
  a
end

get '/register' do
  redirect '/' unless User.all == []
  haml :"blackjax/register", :layout => :"blackjax/layout"
end

post '/register' do
  @user = User.register params[:username], params[:password]
  redirect '/register' unless @user
  if User.all.length == 1
    # Add default language
    lang = Lang.create(:id=>'en_GB',:name=>'English')
    # Add default page
    lang.pages.new(:label=>'home',:title=>'Hello!',:content=>'Congratulations on installing BlackJax!',:pos=>0)
    lang.save
  end
  haml :"blackjax/registered", :layout => :"blackjax/layout"
end

get '/page/:page' do
  Page.first(:label => params[:page]).content
end
