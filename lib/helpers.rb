helpers do
  Dir["./helpers/*.rb"].each do |file|
    require file
    include Kernel.const_get(file.gsub(%r{(./helpers/|.rb)},'').capitalize)
  end
end
