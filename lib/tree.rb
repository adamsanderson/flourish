class Tree  
  def initialize(x,y)
    @root = TreeBranch.new(Point.new(x,y))
    @joint_image = Game.load_image :marker
    self.selected = @root
    @branches = [@root]
  end
   
  def die
    live_branches.each{|b| b.die }
  end
  
  def dead?
    live_branches.empty?
  end
  
  def live_branches
    @branches.reject{|b|b.dead?}
  end
  
  def update(time_delta)
    @root.update(time_delta)
  end
  
  def draw
    @joint_image.draw(@root.start.x,@root.start.y-4, ZOrder::Tree)
    @joint_image.draw(selected.end.x - 4 ,selected.end.y - 4, ZOrder::Tree)
    @root.draw
  end
  
  def selected= node
    @selected_node.selected = false if @selected_node
    @selected_node = node
    node.selected = true
  end
  
  def selected
    @selected_node
  end
  
  # Branches the selected node between points +left+ and +right+.
  def branch(left, right)
    left,right = [left,right].sort_by{|n| n.x}
    if nodes = selected.branch(left, right)
      index = @branches.index( self.selected )
      @branches.delete_at index
      @branches.insert index, *nodes
      self.selected = @selected_node.children.first
    end
  end
  
  # Selects the next relative leaf.
  def select_next(dir = 1)
    i = (@branches.reject{|l| l.dead?}.index(selected) || 0) + dir
    self.selected = @branches[i % @branches.length ]
  end
  
  # Selects the closest viable leaf by proximity to a +point+.
  def select_point(point)
    closest = live_branches.sort_by do |leaf| 
      Gosu::distance(point.x, point.y, leaf.end.x, leaf.end.y) 
    end.find do |leaf| 
      leaf.should_branch?(point)
    end

    self.selected = closest if closest
  end
end