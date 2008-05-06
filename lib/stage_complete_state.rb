class StageCompleteState
  attr_reader :cursor_x
  attr_reader :cursor_y
  
  def initialize(previous_state=nil)
    @cursor = Point.new
    @cursor_image = Game.load_image :cursor
    @selection = Selection.new 
    @font = Game.load_font Gosu::default_font_name, 64
    @small_font = Game.load_font Gosu::default_font_name, 32
    @previous_state = previous_state
    @width, @height = Game.window.width, Game.window.height
  end
  
  def update
    time = Gosu::milliseconds
    x = Game.window.mouse_x
    y = Game.window.mouse_y
    @cursor.x = (x < 0 ? 0 : x > @width ? @width : x).to_i
    @cursor.y = (y < 0 ? 0 : y > @height ? @height : y).to_i
  end
  
  def draw
    # Draw the background
    @previous_state.draw 
    @font.draw_rel("Stage Complete", 400,100,6, 0.5,0.5, 1,1, 0xCC000000)
    offset = @font.height
    @small_font.draw_rel("Click to Continue", 400,100+offset,6, 0.5,0.5, 1,1, 0xCC000000)
  end
  
  def button_down(id)
    if id == Gosu::Button::KbEscape
      Game.window.close
    elsif  id == Gosu::Button::MsLeft ||  id == Gosu::Button::KbReturn
      Game.pop_state
      Game.state.next_level
    end
  end
  
  def button_up(id)
  
  end
end