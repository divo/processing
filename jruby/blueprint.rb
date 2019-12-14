# P.3.1.2
require 'propane'

class Blueprint < Propane::App

  attr_accessor :centerX, :centerY
  attr_accessor :zoom
  attr_accessor :text # TODO: Option to save this
  attr_accessor :font

  def settings
    size(800, 600)
    centerX, @centerY = width / 2, height / 2 # TODO: Mouse clicked
    zoom = 1 # TODO: Scaling
  end

  def setup
    sketch_title 'Blueprint'
    # font = load_font(data_path("miso-bold.ttf"))
    @font = create_font('Helvetica', 25)
  end

  def draw
    # TODO: scaling and translation are kinda key to this
    #translate(centerX, centerY) # Move to mouse position
    #scale(zoom)

    text_font(@font)
    text.chars.each do |char|
      char_width = text_width(char)


    end
  end

  # TODO: Maybe a command mode?
  def keyPressed
		case key
		when BACKSPACE
			text = text.delete_suffix!(text.chars.last)
		else
			text += key
		end
  end
end

Blueprint.new
