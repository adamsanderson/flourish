class GameWindow < Gosu::Window

  def initialize
    super(800, 600, false, 10)
    self.caption = "Flourish"
    Game.window = self
  end
  
  def update
    Game.state.update
  end

  def draw
    Game.state.draw
  end

  def button_down(id)
    if id == Gosu::Button::KbEscape
      Game.window.close
    end
    Game.state.button_down id
  end
  
  def button_up(id)
    Game.state.button_up id
  end
  
end