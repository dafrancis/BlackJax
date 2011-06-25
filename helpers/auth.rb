require 'digest/sha1'

module Auth
  def is_authenticated?
    !session[:user].nil?
  end
  
  def hash_password(username, password)
    Digest::SHA1.hexdigest("#{username}_#{password}")
  end
  
  def authenticate!(username, password)
    user = User.login(username, password)
    unless user.nil?
      session[:user] = {}
      session[:user][:username] = user.username
      session[:user][:pass_hash] = user.pass_hash
    end
  end
end