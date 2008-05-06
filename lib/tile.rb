class Tile
  attr_reader :activated 
  attr_reader :satisfied
  
  def initialize
    @activated = false
    @color = Gosu::Color.new(48, 255,255,255 ) # Make it somewhat transparent
    @satisfied = true
  end
  
  def draw(x,y)
    @image.draw x,y, ZOrder::PowerUps, 1,1, @color
  end
  
  def collision(branch)
     @activated = true
  end
end

class GoodTile < Tile
  def initialize
    super
    @image = Game.load_image :good
    @satisfied = false
  end
  
  def collision(branch)
    Game.state.score += 1 unless @activated
    @color = Gosu::Color.new(128, 255,255,255 )
    @satisfied = true
    super
  end
end

class BlockingTile < Tile
  def initialize
    super
    @image = Game.load_image :blocking
    @color = Gosu::Color.new(200, 255,255,255 )
  end
  
  def collision(branch)
    unless @activated
      branch.die
      @color = Gosu::Color.new(32, 255,255,255 )
      super
    end
  end
  
end

class BadTile < Tile
  def initialize
    super
    @image = Game.load_image :bad
  end
  
  def collision(branch)
    Game.state.tree.die
    super
  end
end