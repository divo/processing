# P.3.1.2
require 'propane'

class Blueprint < Propane::App

  # TODO: WTF exaclty do these accessors do
  attr_accessor :centerX, :centerY
  attr_accessor :zoom
  attr_accessor :text # TODO: Option to save this
  attr_accessor :font
  attr_accessor :shapes

  SHAPES = %i[
    space
    space2
    period
    comma
    questionmark
    exclamationmark
    return
    icon1
    icon2
    icon3
    icon4
    icon5
  ]

  def settings
    size(800, 600)
    @centerX, @centerY = width / 2, height / 2 # TODO: Mouse clicked
    zoom = 1 # TODO: Scaling
    @text = ''
  end

  def setup
    sketch_title 'Blueprint'
    @font = create_font('Helvetica', 25)
    load_proc = ->(file) { load_shape(data_path(file)) }
    @shapes = Shapes.new(SHAPES, load_proc)
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
        shape(shapes[:space], 0, 0)
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

class Shapes
  attr_accessor :data
  def initialize(names, load_proc)
    @data = names.each_with_object({}) do |name, result|
      result[name] = load_proc.call("#{name}.svg")
    end
  end

  def [](name)
    data[name]
  end
end

Blueprint.new
