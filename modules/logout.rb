class Logout
  def run(session,params)
    session.delete(:user)
    'You are now logged out<script>load_links();load_panel();location.href="#/";$.cookie("admin",null);$("#panel-div").hide();</script>'
  end
end