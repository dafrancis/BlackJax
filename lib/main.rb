class MainBlackJax < BlackJax
  def set_user(user)
    unless user.nil?
      session[:user] = {
        :username => user.username,
        :pass_hash => user.pass_hash
      }
    end
  end

  post '/auth' do
    set_user User.login(params[:u], params[:p])
    "logged in!"
  end

  get '/' do
    redirect '/register' if User.empty?
    erb :newindex
  end

  get '/page/:page' do
    markdown Page.get_content(params[:page])
  end
end
