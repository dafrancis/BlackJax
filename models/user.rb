class User
  extend Auth
  include DataMapper::Resource

  property :id,       Serial
  property :username, String, :length => 15
  property :pass_hash,     Text
  
  def self.register(username, password)
    user = self.new
    user.username = username
    user.pass_hash = hash_password(username,password)
    user.save! ? user : false
  end
  
  def self.login(username, password)
    self.first(:username=>username,:pass_hash=>hash_password(username,password))
  end
end
