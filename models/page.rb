class Page
  include DataMapper::Resource

  property :id,      Serial
  property :label,   String, :length => 20
  property :title,   String, :length => 30
  property :content, Text
  property :lang,    String, :length => 10
  property :pos,   Integer
  
  has 1, :lang

  validates_uniqueness_of :label
end
