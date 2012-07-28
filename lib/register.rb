class Register < BlackJax
  def register!
    @user = User.register params[:username], params[:password]
    redirect '/register' unless @user
  end
  
  def create_blank!
    if User.all.length == 1
      lang = Lang.create(:id=>'nolang',:name=>'Pages which aren\'t displayed',:pos=>9999999)
      lang = Lang.create(:id=>'en_GB',:name=>'English',:pos=>0)
      lang.pages.create(:label=>'home',:title=>'Hello!',:content=>'Congratulations on installing BlackJax!',:pos=>0)
    end
  end

  get '/' do
    redirect '/' unless User.empty?
    haml :"blackjax/register", :layout => :"blackjax/layout"
  end

  post '/' do
    register!
    create_blank!
    haml :"blackjax/registered", :layout => :"blackjax/layout"
  end
end