class Sort
  def run(session,params)
    return save! params if params.length > 2
    html = ''
    langs = Lang.all(:id.not=>'nolang',:order=>[:pos.asc])
    breaker = 0
    langs.each do |lang|
      html += "<div class=\"sort_box\"><h3>#{lang.name}</h3><ul id=\"#{lang.id}\" class=\"droptrue\">"
      pages = lang.pages.all(:order=>[:pos.asc])
      pages.each do |page|
        html += "<li class=\"ui-state-default\" id=\"#{page.label}\">#{page.label} <a href=\"##{page.label}\" class=\"sort\">[GO]</a></li>"
      end
      html += '</ul></div>'
			html += '<br clear="both" />' if(breaker%2)
      breaker +=1
    end
    html += '<div class="sort_box"><h3>Pages which aren\'t displayed</h3><ul id="page_hide" class="droptrue">'
    pages = Lang.get('nolang').pages.all
    pages.each do |page|
      html += "<li class=\"ui-state-default\" id=\"#{page.label}\">#{page.label} <a href=\"##{page.label}\" class=\"sort\">[GO]</a></li>"
    end
    <<-eos
    #{html}
    </ul></div>
    <br clear="both" />
			<style type="text/css">
			.sort_box{float: left;}
			.droptrue{ list-style-type: none; margin: 0; padding: 0; margin-right: 10px; background: #eee; padding: 5px; width: 143px;}
			.droptrue li{ margin: 5px; padding: 5px; font-size: 1.2em; width: 120px; }
		</style>
		<script type="text/javascript" src="/js/sort.js"></script>
		<input type="button" onclick="sort()" value="Sort"/>
    eos
  end
  
  def save!
    #Order the Pages
  end
end

=begin
class sort extends module{
	public function run(){
		if(count($_POST)>2){
			$this->db->query("UPDATE pages SET p_order = NULL, p_lang = NULL");
			foreach($this->db->query('SELECT l_id FROM langs') AS $lang){
				foreach(explode(',',$_POST[$lang['l_id']]) as $k => $v){
					$this->db->query(sprintf("UPDATE pages SET p_order = %s, p_lang = \"%s\" WHERE p_label = \"%s\"",$k,$lang['l_id'],$v));
				}
			}
			die();
		}
	}
}
=end