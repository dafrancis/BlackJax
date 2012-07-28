class LangSwitch < BlackJax
  get '/' do
    @langs = Lang.all(:id.not=>'nolang', :order=>[:pos.asc])
    haml :"blackjax/lang"
  end
  
  post '/' do
    session[:lang] = params[:lang]
  end
end