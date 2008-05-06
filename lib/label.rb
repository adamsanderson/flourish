class Label
  attr_accessor :x, :y, :color, :text, :outline_color
  def initialize(x,y, text=nil, font=nil)
    @x = x || Game.window.width / 2
    @y = y || Game.window.height / 2
    @font = font || Game.load_font(Gosu::default_font_name, 32)

    @color = 0xDDFFFFFF
    @text = text
    
    @ttl = nil
  end
  
  def show(text, duration=1500)
    @text = text
    @ttl = duration
  end
  
  def update(delta)
    @ttl -= delta if @ttl
  end
  
  def draw
    if @ttl.nil? or (@ttl > 0 and @text)
      if @outline_color
        @font.draw(@text, @x+1,@y, 6, 1,1, @outline_color)
        @font.draw(@text, @x-1,@y, 6, 1,1, @outline_color)
        @font.draw(@text, @x,@y+1, 6, 1,1, @outline_color)
        @font.draw(@text, @x,@y-1, 6, 1,1, @outline_color)
      end
      @font.draw(@text, @x,@y, 6, 1,1, @color)
    end
  end
end