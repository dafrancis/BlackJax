require 'sinatra'
require 'haml'
require 'data_mapper'

# Models
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite:data")
Dir["./models/*"].each {|file| require file }
DataMapper.finalize.auto_upgrade!

def get_lang
  session[:lang] ||= "ENGLISH"#Lang.first(:order =>[:pos.asc]) 
end

# Panels
def panel_links
  Page.all(:pos.not => nil, :lang => get_lang)
end

def panel_admin
  Dir['./modules/*.rb'].map{|n| n.gsub(/(\.\/modules\/|\.rb)/,'').capitalize}
end

get '/' do
  "BlackJax"
  panel_links
  panel_admin
end

get '/page/:page' do
  Page.first(:label => params[:page]).content
end
