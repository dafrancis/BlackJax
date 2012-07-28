class Lang
  include DataMapper::Resource

  property :id,      String, :length => 10, :key => true 
  property :name,    String, :length => 50
  property :pos,   Integer
  
  has n, :pages

  validates_uniqueness_of :id

  def self.list
  	self.all(:id.not=>'nolang', :order=>[:pos.asc])
  end

  def self.set_lang(params)
  	self.list.each do |lang|
  	  lang.set_lang params
    end
  end

  def set_lang(params)
  	lang = self.id
  	params[lang].split(',').each_with_index do |label, pos|
      Page.set_lang label, lang, pos
    end
  end
end
