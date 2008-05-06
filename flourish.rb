require 'rubygems'
require 'gosu'
require 'singleton'

require 'lib/support'

Dir["lib/*.rb"].each do |file|
  require file
end

if __FILE__ == $0
  Game.window = GameWindow.new
  Game.push_state GameState.new(nil)
  Game.window.show
end