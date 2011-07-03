class Delete
  def run(session,params)
    Page.first(:label=>params[:page]).destroy
		'Page has been deleted<script>load_links();load_panel();load_home();</script>'
  end
end