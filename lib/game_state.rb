class GameState < FlourishState
  attr_accessor :score
  attr_reader :tree
  attr_reader :lives
  
  def initialize(previous_state=nil)
    super
    
    @score_label = Label.new 0,0, nil
    @score_label.outline_color = 0x66666666
    
    @title_label = Label.new 400,0, nil, Game.load_font(Gosu::default_font_name, 64)
    @title_label.outline_color = 0x66666666
    
    @desc_label = Label.new 400,68, nil, Game.load_font(Gosu::default_font_name, 32)
    @desc_label.outline_color = 0x66666666
    
    @maps = MapLoader.new('levels')
    @level = 0
    reset
  end
  
  def reset
    @lives = 3
    @score = 0
    @tree = Tree.new 400,600
    @dead_trees = []
    @map = @maps.load(@level)
    @last_time = nil
    
    @title_label.show(@map.name, 5000)
    @desc_label.show(@map.slug, 5000)
  end
  
  def next_level
    @level += 1
    @tree = Tree.new 400,600
    @dead_trees = []
    @map = @maps.load(@level)
    @last_time = nil
    
    @title_label.show(@map.name, 5000)
    @desc_label.show(@map.slug, 5000)
  end
  
  def update
    super
    @tree.select_point(@cursor) unless @selection.visible?
    
    if @last_time
      delta = @time - @last_time
      @tree.update(delta)
      @map.update(delta)
      @score_label.update delta
      @score_label.text = "Score: #{@score}" # hack
      @title_label.update delta
      @desc_label.update delta
    end
    
    if @tree.dead?
      if @lives > 1
        @dead_trees << @tree
        @lives -= 1
        @tree = Tree.new 400,600
      else
        puts "Game Over!"
        Game.push_state GameOverState.new(self)
      end
    end
    
    @last_time = @time
  end
  
  def draw
    super 
    # Draw the background
    Game.window.draw_quad(0, 0, 0xFFFFFFFF, 0, 600, 0xFFFFFFCC, 800, 0, 0xFFFFFFFF, 800, 600, 0xFFFFFFCC, z=0)
    
    @map.draw
    @dead_trees.each do |tree|
      tree.draw
    end
    @tree.draw
    @score_label.draw
    @title_label.draw
    @desc_label.draw
  end
  
  def button_down(id)
    if id == Gosu::Button::KbEscape
      Game.window.close
    elsif  id == Gosu::Button::MsLeft && ! @selection.visible?
      @selection.start = @cursor.clone
    elsif id == Gosu::Button::KbTab || id == Gosu::Button::MsWheelDown
      @tree.select_next(+1)
    elsif id == Gosu::Button::MsWheelUp
      @tree.select_next(-1)
    elsif id == Game.window.char_to_button_id('d')
      @tree.die
    elsif id == Game.window.char_to_button_id('n') # Cheat!
      next_level
    end
  end
  
  def button_up(id)
    if id == Gosu::Button::MsLeft
      @selection.finish do |action|
        if action == :drag
          @tree.branch(@selection.start, @selection.end)
        end
      end
    end
  end
end