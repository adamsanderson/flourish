class Powerup
  include Math::Geometry
  def initialize(point)
    @point = point
    @empty_image = Game.load_image(:target_empty)
    @full_image = Game.load_image(:target_full)
    @radius = @empty_image.width / 2.0
    @activated = false
  end
  
  def update(time_delta)
    unless @activated
      Game.window.tree.live_branches.each do |branch|

        collision = segment_intersects_circle?(
          branch.start.x, branch.start.y,
          branch.end.x, branch.end.y,
          @point.x,@point.y,@radius
        )
        if collision
          collided branch
        end
      end
    end
  end
  
  def collided branch
    @activated = true
  end
  
  def draw
    image = @activated ? @full_image : @empty_image
    image.draw_centered @point.x, @point.y, ZOrder::PowerUps
  end
end

class Burst < Powerup
  def collided branch
    
  end
end