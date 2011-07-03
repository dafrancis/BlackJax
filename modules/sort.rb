class Sort
  include Renderer
  
  def run(session,params)
    return save! params if params.length > 2
    html = ''
    langs = Lang.all(:order=>[:pos.asc])
    haml_render("views/modules/sort.haml", :langs=>langs)
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