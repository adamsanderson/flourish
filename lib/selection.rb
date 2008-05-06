class Selection
  attr_reader :start
  attr_accessor :end
  
  def initialize()
    @marker = Game.load_image :marker
  end
  
  def visible?
    @visible
  end
  
  def start= point
    @start = point
    @visible = true
  end
  
  def finish
    @visible = false
    if !@start || !@end
      state = nil
      reset
      return
    end
    
    dist = Gosu.distance(@start.x, @start.y, @end.x, @end.y)
    state = nil
    
    if dist < 5
      state = :click
    else
      state = :drag
    end
    
    yield state
    
    reset
  end
  
  def reset
    @start = @end = @visible = nil
  end
  
  def update(cursor)
    @end = cursor if visible?
  end
  
  def draw
    if visible? and @start and @end
      @marker.draw_centered(@start.x, @start.y, ZOrder::UI_Marker)
      Game.window.draw_line(@start.x, @start.y, 0x66FF6666, @end.x, @end.y, 0x66FF6666)
      #@marker.draw(@end.x, @end.y, ZOrder::UI_Marker)
    end
  end
end