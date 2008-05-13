# Basic state in flourish
class FlourishState
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
    @time = Gosu::milliseconds
    @x = Game.window.mouse_x
    @y = Game.window.mouse_y
    @cursor.x = (@x < 0 ? 0 : @x > @width ? @width : @x).to_i
    @cursor.y = (@y < 0 ? 0 : @y > @height ? @height : @y).to_i
    @selection.update(@cursor)
  end
  
  def draw
    if @cursor.x and @cursor.y
      @cursor_image.draw(@cursor.x, @cursor.y,ZOrder::UI)
      @selection.draw
    end
  end
  
  def button_down(id)
  end
  
  def button_up(id)
  end
  
end