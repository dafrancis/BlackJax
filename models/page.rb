class Page
  include DataMapper::Resource

  property :id,      Serial
  property :label,   String, :length => 20
  property :title,   String, :length => 30
  property :content, Text
  property :pos,   Integer
  
  belongs_to :lang, :key => true

  validates_uniqueness_of :label
end