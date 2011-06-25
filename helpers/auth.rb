require 'digest/sha1'

module Auth
  def is_authenticated?
    !session[:user].nil?
  end
  
  def hash_password(username, password)
    Digest::SHA1.hexdigest("#{username}_#{password}")
  end
end