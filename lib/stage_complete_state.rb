class StageCompleteState < FlourishState
  def initialize(previous_state=nil)
    super
  end
  
  def draw
    super
    
    # Draw the background
    @previous_state.draw 
    @font.draw_rel("Stage Complete", 400,100,6, 0.5,0.5, 1,1, 0xCC000000)
    offset = @font.height
    @small_font.draw_rel("Click to Continue", 400,100+offset,6, 0.5,0.5, 1,1, 0xCC000000)
    
  end
  
  def button_down(id)
    if id == Gosu::Button::MsLeft ||  id == Gosu::Button::KbReturn
      Game.pop_state
      Game.state.next_level
    else
      super
    end
  end
end