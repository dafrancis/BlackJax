module Util
  def get_lang
    session[:lang] ||= Lang.first(:order =>[:pos.asc]).id
  end
  
  def create_blank!
    if User.all.length == 1
      lang = Lang.create(:id=>'nolang',:name=>'Pages which aren\'t displayed',:pos=>9999999)
      lang = Lang.create(:id=>'en_GB',:name=>'English',:pos=>0)
      lang.pages.create(:label=>'home',:title=>'Hello!',:content=>'Congratulations on installing BlackJax!',:pos=>0)
    end
  end

  def register!
    @user = User.register params[:username], params[:password]
    redirect '/register' unless @user
  end

  def get_module(mod)
    require "./modules/#{mod}.rb";
    Kernel.const_get(mod.capitalize).new
  end

  def run_module(mod)
    mod.run session, params
  end

  def get_and_run(mod)
    run_module(get_module(mod))
  end

  def self.load_models
    DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite:data")
    Dir["./models/*"].each {|file| require file }
    DataMapper.finalize
    DataMapper.auto_upgrade!
  end
end
