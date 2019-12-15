# P.3.1.2
require 'propane'

class Blueprint < Propane::App

  # TOOD: WTF exaclty do these accessors do
  attr_accessor :centerX, :centerY
  attr_accessor :zoom
  attr_accessor :text # TODO: Option to save this
  attr_accessor :font

  # TODO: Put this in a hash or something, sake
  attr_accessor :shape_space, :shape_space2, :shape_period, :shape_comma
  attr_accessor :shape_questionmark, :shape_exclamationmark, :shape_return;

  def settings
    size(800, 600)
    @centerX, @centerY = width / 2, height / 2 # TODO: Mouse clicked
    zoom = 1 # TODO: Scaling
    @text = ''
  end

  def setup
    sketch_title 'Blueprint'
    # font = load_font(data_path("miso-bold.ttf"))
    @font = create_font('Helvetica', 25)

    @shape_space = load_shape(data_path('space.svg'))
    @shape_space2 = load_shape(data_path('space2.svg'))
    @shape_period = load_shape(data_path('period.svg'))
    @shape_comma = load_shape(data_path('comma.svg'))
    @shape_questionmark = load_shape(data_path('questionmark.svg'))
    @shape_exclamationmark = load_shape(data_path('exclamationmark.svg'))
    @shape_return = load_shape(data_path('return.svg'))
  end

  def draw
    # TODO: scaling and translation are kinda key to this
    translate(centerX, centerY) # Move to mouse position
    #scale(zoom)

    text_font(@font)
    text.chars.each do |char|
      char_width = text_width(char)
      case char
      when ' '
        shape(shape_space, 0, 0)
        translate(10.9, 0)
      end
    end
  end

  # TODO: Maybe a command mode?
  def keyPressed
		case key
		when BACKSPACE
			@text = text.delete_suffix!(text.chars.last)
		else
			@text += key
		end
  end
end

Blueprint.new
