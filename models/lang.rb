class Lang
  include DataMapper::Resource

  property :id,      String, :length => 10, :key => true 
  property :name,    String, :length => 50
  property :pos,   Integer
  
  has n, :pages

  validates_uniqueness_of :id
end
