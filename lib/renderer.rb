module Renderer
  def haml_render(file, opts={})
    template = File.read(file)
    haml_engine = Haml::Engine.new(template, :ugly => true)
    output = haml_engine.render(Object.new, opts)
  end
end