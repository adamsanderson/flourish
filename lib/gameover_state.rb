class GameOverState
  attr_reader :cursor_x
  attr_reader :cursor_y
  
  def initialize(previous_state=nil)
    @cursor = Point.new
    @cursor_image = Game.load_image :cursor
    @font = Game.load_font Gosu::default_font_name, 64
    @small_font = Game.load_font Gosu::default_font_name, 32
    @previous_state = previous_state
    @menu = Menu.new ["Replay Level", "Quit Game"], 400, 200
    @width, @height = Game.window.width, Game.window.height
  end
  
  def update
    time = Gosu::milliseconds
    x = Game.window.mouse_x
    y = Game.window.mouse_y
    @cursor.x = (x < 0 ? 0 : x > @width ? @width : x).to_i
    @cursor.y = (y < 0 ? 0 : y > @height ? @height : y).to_i
    @menu.update 0
  end
  
  def draw
    # Draw the background
    @previous_state.draw 
    Game.window.draw_quad(0, 0, 0x88660000, 0, 600, 0x88660000, 800, 0, 0x88660000, 800, 600, 0x88660000, z=5)
    @font.draw_rel("Game Over", 400,100,6, 0.5,0.5, 1,1, 0xCCFFFFFF)
    offset = @font.height
    @menu.draw
  end
  
  def button_down(id)
    if id == Gosu::Button::KbEscape
      Game.window.close
    elsif id == Gosu::Button::KbUp
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
    end
  end
  
  def button_up(id)
    
  end
end