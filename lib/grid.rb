class Grid
  attr_accessor :name
  attr_accessor :slug
  attr_accessor :code
  
  def initialize(width=16, height=12, tile_size=48)
    @width = width
    @height = height
    @tile_size = tile_size    
    
    @grid = Array.new(@width * @height)
  end
  
  def [](x,y)
    @grid[x * @width + y]
  end
  
  def []=(x,y,value)
    @grid[x * @width + y] = value
  end
  
  def update(time_delta)
    Game.state.tree.live_branches.each do |branch|
      tile = self[*pixel_to_grid( branch.end.x, branch.end.y )]
      if tile
        tile.collision(branch)
      end
    end
    
    # Winning condition
    if @grid.all?{|t| t.nil? || t.satisfied}
      Game.push_state StageCompleteState.new(Game.state)
    end
  end
  
  def draw
    @width.times do |x|
      @height.times do |y|
        tile = self[x,y]
        i,j = grid_to_pixel x,y
        if tile
          tile.draw(i,j)
        end
      end
    end
  end
  
  def pixel_to_grid(x,y)
    [(x.to_i / @tile_size), (y.to_i / @tile_size)]
  end
  
  def grid_to_pixel(x,y)
    [x * @tile_size, y * @tile_size]
  end
  
end