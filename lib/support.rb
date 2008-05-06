module ZOrder
  Background, PowerUps, Tree, UI_Marker, UI = *0..4
end

class Gosu::Image
  def draw_centered(x,y,z,factor_x=1,factor_y=1, color=0xffffffff,mode=:default)
    x = x - width/2.0
    y = y - height/2.0
    draw x,y,z, factor_x, factor_y, color,mode
  end
end

module Math::Geometry
  def segment_intersects_circle?(x1,y1, x2,y2, xc,yc,r)
    #http://www.gamedev.net/community/forums/topic.asp?topic_id=398748
    x_dif = xc - x1
    y_dif = yc - y1
    x_dir = x2 - x1
    y_dir = y2 - y1
    x_close = nil
    y_close = nil
    dot1 = x_dif * x_dir + y_dif * y_dir
    dot2 = x_dir * x_dir + y_dir * y_dir
    if dot1 <= 0
      x_close, y_close = x1,y1
    elsif dot2 <= dot1
      x_close, y_close = x2,y2
    else
      t = dot1.to_f / dot2.to_f
      x_close, y_close = x1 + x_dir*t, y1 + y_dir*t
    end
    
    distance = Gosu::distance(xc, yc, x_close, y_close)
    distance < r
  end 
end

Point = Struct.new(:x,:y)