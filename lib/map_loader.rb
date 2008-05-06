class MapLoader
  def initialize(name)
    # quick hack to get my window map file working in linux
    data = Game.load_maps(name).gsub("\r","") 
    @maps = data.split "--\n"
  end
  
  def levels
    @maps.length
  end
  
  def load(level_number)
    parse_map(@maps[level_number])
  end
  
  def skip_code(data)
    data.crypt('TP')[0..4].upcase
  end
  
  def parse_map(data)
    map_data = data.split("\n")
    map_name = map_data.shift
    map_slug = map_data.shift
    map = map_data.join('')
    
    puts map_name
    puts map_slug
    
    #... load the map_file
    grid = Grid.new(16,12)
    grid.name = map_name
    grid.slug = map_slug
    grid.code = skip_code(map)
        
    map.length.times do |i|
      y = i / 16
      x = i % 16
      c = map[i]
      if c == ?X
        grid[x,y] = BadTile.new
      elsif c == ?+
        grid[x,y] = GoodTile.new
      elsif c == ?=
        grid[x,y] = BlockingTile.new
      end
    end
    
    grid
  end
end