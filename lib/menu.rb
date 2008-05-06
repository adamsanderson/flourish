class Menu
  attr_reader :index
  attr_accessor :x, :y, :selected_color, :color
  def initialize(options, x=nil,y=nil, font=nil)
    @x = x || Game.window.width / 2
    @y = y || Game.window.height / 2
    @font = font || Game.load_font(Gosu::default_font_name, 32)
    @selected_color = 0xFFFFFFFF
    @color = 0x66FFFFFF
    @index = 0
    @options = options
  end
  
  def selected
    @options[@index]
  end
  
  def select_next
    @index = (@index + 1) % @options.length
  end
  
  def select_previous
    @index = (@index - 1) % @options.length
  end
  
  def update(delta)
  end
  
  def draw
    x, y = @x, @y
    @options.each_with_index do |opt, i|
      color = i == @index ? @selected_color : @color
      @font.draw_rel(opt, x,y, 6, 0.5,0.5, 1,1, color)
      y += @font.height
    end
  end
  
end