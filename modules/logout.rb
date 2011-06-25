class Logout
  def run(session,params)
    session.delete(:user)
    'You are now logged out<script>load_links();load_panel();load_home();$.cookie("admin",null);$("#panel-div").hide();</script>'
  end
end