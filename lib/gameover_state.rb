class GameOverState < FlourishState
  
  def initialize(previous_state=nil)
    super
    @menu = Menu.new ["Replay Level", "Quit Game"], 400, 200
  end
  
  def update
    super
    @menu.update 0
  end
  
  def draw
    super
    # Draw the background
    @previous_state.draw 
    Game.window.draw_quad(0, 0, 0x88660000, 0, 600, 0x88660000, 800, 0, 0x88660000, 800, 600, 0x88660000, z=5)
    @font.draw_rel("Game Over", 400,100,6, 0.5,0.5, 1,1, 0xCCFFFFFF)
    offset = @font.height
    @menu.draw
  end
  
  def button_down(id)
    if id == Gosu::Button::KbUp
      @menu.select_previous
    elsif id == Gosu::Button::KbDown
      @menu.select_next
    elsif id == Gosu::Button::KbReturn
      if @menu.index == 0
        Game.pop_state
        Game.state.reset
      else
        Game.window.close
      end
    elsif id == Game.window.char_to_button_id('r')
      Game.pop_state
      Game.state.reset
    else
      super
    end
  end
  
end