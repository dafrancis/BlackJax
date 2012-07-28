class Admin < BlackJax
  def get_module(mod)
    require "./modules/#{mod}.rb";
    Kernel.const_get(mod.capitalize).new
  end

  def run_module(mod)
    mod.run session, params
  end

  def get_and_run(mod)
    run_module(get_module(mod))
  end

  get '/' do
    response.set_cookie("admin", 1)
    redirect '/'
  end

  post '/:page/:module' do
    return "Not Logged in" unless is_authenticated?
    get_and_run params[:module]
  end
end