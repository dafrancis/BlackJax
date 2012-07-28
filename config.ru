$LOAD_PATH.unshift 'lib'

require 'blackjax'
require 'main'
require 'register'
require 'lang_switch'
require 'panel'
require 'renderer'
require 'admin'

map "/" do
  run MainBlackJax
end

map "/register" do
  run Register
end

map "/lang" do
  run LangSwitch
end

map "/panel" do
  run Panel
end

map "/admin" do
  run Admin
end