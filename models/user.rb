class User
  include DataMapper::Resource

  property :id,       Serial
  property :username, String, :length => 15
  property :pass_hash,     Text
end
