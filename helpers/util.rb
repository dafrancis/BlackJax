module Util
  def get_lang
    session[:lang] ||= Lang.first(:order =>[:pos.asc]).id
  end
  
  def create_blank!
    if User.all.length == 1
      lang = Lang.create(:id=>'en_GB',:name=>'English')
      lang.pages.create(:label=>'home',:title=>'Hello!',:content=>'Congratulations on installing BlackJax!',:pos=>0)
    end
  end
end