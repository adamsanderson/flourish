class Game
  ROOT = File.join(File.dirname(__FILE__), '..', 'res')
  
  class << self
    attr_accessor :window
    
    def states
      @states ||= []
    end
    
    def state
      states.last
    end
        
    def push_state(state)
      states << state
    end
    
    def pop_state
      states.pop
    end
    
    def load_image(name, options=[])
      @images ||= {}
      @images[name] ||= Gosu::Image.new window, File.join(ROOT, "#{name}.png"), *options
    end
    
    def load_sound(name)
      @sounds ||= {}
      @sounds[name] ||= Gosu::Sample.new window, File.join(ROOT, "#{name}.wav")
    end
    
    def load_font(name, size)
      @fonts ||= {}
      #@fonts[name] ||= Gosu::Font.new window, File.join(ROOT, name), size
      #@fonts[name] ||= Gosu::Font.new window, Gosu::default_font_name, size
      @fonts[[name,size]] ||= Gosu::Font.new window, Gosu::default_font_name, size
    end
    
    def load_maps(name)
      @map_data ||= {}
      @map_data[name] ||= File.read(File.join(ROOT, "levels" ,"#{name}.txt"))
      @map_data[name].dup
    end
    
  end
  
end