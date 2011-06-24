require 'sinatra'
require 'haml'
require 'data_mapper'

# Models
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite:data")
Dir["./models/*"].each {|file| require file }
DataMapper.finalize.auto_upgrade!

get '/' do
  "BlackJax"
end
