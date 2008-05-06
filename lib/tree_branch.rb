class TreeBranch
  attr_reader :start
  attr_reader :end
  attr_reader :children
  attr_accessor :selected
    
  def initialize(start, angle=0, rate=0.079)
    @start = start
    @end = start.dup
    @angle = angle
    @length = 0
    @rate = rate
    @base_rate = rate
    @children = []
    @selected = false
  end
    
  def draw
    Game.window.draw_line(@start.x, @start.y, 0x66FF6666, @end.x, @end.y, 0x66FF6666)
    
    if children.empty?
      length = @rate * 1000
      length = 20 if length < 20 
      x_left = @end.x + Gosu::offset_x(@angle + 40,   length)
      y_left = @end.y + Gosu::offset_y(@angle + 40,   length)
      x_right = @end.x + Gosu::offset_x(@angle - 40,  length)
      y_right = @end.y + Gosu::offset_y(@angle - 40,  length)
      if dead?
        start_color =   @selected ? 0xCC669966 : 0x66669966
        end_color =     @selected ? 0x00669966 : 0x00669966
      else
        start_color =   @selected ? 0xCCFF6666 : 0x66FF6666
        end_color =     @selected ? 0x00FF6666 : 0x00FF6666
      end
      Game.window.draw_triangle(
        @end.x, @end.y, start_color, 
        x_left, y_left, end_color, 
        x_right, y_right, end_color
      )
    end
    @children.each{|c| c.draw}
  end
  
  def update(time_delta)
    if !dead?
      @rate *= 0.99
      @length += (time_delta * @rate)
      @end.x = @start.x + Gosu::offset_x(@angle, @length)
      @end.y = @start.y + Gosu::offset_y(@angle, @length)
      
      if @rate < 0.0005
        die
      end
      
    end
    
    @children.each{|c| c.update time_delta}
  end
  
  def die
    @rate = 0
  end
  
  def dead?
    @rate <= 0 
  end
  
  def branch(left, right)
    center = Point.new( (left.x + right.x) / 2, (left.y + right.y) / 2 )
    if should_branch?(center)
      left_angle = Gosu::angle(@end.x, @end.y, left.x, left.y)
      right_angle = Gosu::angle(@end.x, @end.y, right.x, right.y)
      #scale = Gosu::distance(center.x, center.y, @end.x, @end.y) ** 0.15
      scale = 1
      branch_angles scale, left_angle, right_angle
      @children
    end
  end
  
  def branch_angles(scale, *angles)
    angles.each do |angle|
      @children << TreeBranch.new(@end, angle,  (@base_rate * scale))
    end
    @rate = 0
    @children
  end
  
  def should_branch?(center)
    return false if dead?
    delta_angle = Gosu::angle( @end.x, @end.y, center.x, center.y) - @angle
    valid = delta_angle.abs < 85
    valid
  end
end