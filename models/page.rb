class Page
  include DataMapper::Resource

  property :id,      Serial
  property :label,   String, :length => 20
  property :title,   String, :length => 30
  property :content, Text
  property :pos,   Integer
  
  belongs_to :lang, :key => true

  validates_uniqueness_of :label

  def self.get_content(page)
  	page = self.first(:label => page)
    page.nil? ? "Error 404" : page.content
  end

  def self.reset_lang
    self.all.each do |page|
      page.lang_id = 'nolang'
      page.save!
    end
  end

  def self.set_lang(page, lang, pos)
    page = self.first(:label => page)
    page.lang_id = lang
    page.pos = pos
    page.save!
  end

  def edit!(text, title)
    self.content = text
    self.title = title
    self.save
  end
end