Dir["./helpers/*.rb"].each do |file|
  require file
  register Kernel.const_get(file.gsub(%r{(./helpers/|.rb)},'').capitalize)
end
