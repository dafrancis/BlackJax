require 'sinatra/base'
require 'haml'
require 'data_mapper'

class BlackJax < Sinatra::Base
  set :root, File.expand_path('../../', __FILE__)
  set :app_file, __FILE__

  enable :sessions

  helpers do
  	def self.load_models
      DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite:data")
      Dir["./models/*"].each {|file| require file }
      DataMapper.finalize
      DataMapper.auto_upgrade!
   end

    def is_authenticated?
      !session[:user].nil?
    end
  end
  
  self.load_models
end