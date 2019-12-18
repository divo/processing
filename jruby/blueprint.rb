# P.3.1.2
require 'propane'

class Blueprint < Propane::App

  # TODO: WTF exaclty do these accessors do
  attr_accessor :center_x, :center_y
  attr_accessor :offset_x, :offset_y
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

  # TODO: palette

  def settings
    size(800, 600)
    @center_x, @center_y = width / 2, height / 2 # TODO: Mouse clicked
    @offset_x, @offset_y = 0, 0
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
    background(255)
    # smooth
    no_stroke
    text_align(LEFT)

    if mouse_pressed?
      @center_x = mouseX - offset_x
      @center_y = mouseY - offset_y
    end

    translate(center_x, center_y) # Move to mouse position
    #scale(zoom)

    text_font(@font)
    text.chars.each do |char|
      char_width = text_width(char)
      method = char_method[char]
      send(method) if method
    end
  end

  # TODO: Maybe a command mode?
  def key_pressed
    case key.bytes
    when [8] # backspace
      @text.chop!
    else
      @text += key
    end
    # TODO: More repl like
    puts @text
  end

  def mouse_pressed
    @offset_x = mouseX - @center_x
    @offset_y = mouseY - @center_y
  end

  def char_method
    {
      ' ' => :space,
      ',' => :comma,
      '.' => :period,
      '1' => :exclamationmark,
      '2' => :questionmark
    }
  end

  def space
    shape(shapes[:space], 0, 0)
    translate(1, 0)
    rotate(PI / 4)
  end

  def comma
    shape(shapes[:comma], 0, 0)
    translate(31.5, 13.5)
    rotate(PI / 4)
  end

  def period
    shape(shapes[:period], 0, 0)
    translate(56, -54)
    rotate(-PI / 2)
  end

  def exclamationmark
    shape(shapes[:exclamationmark], 0, 0)
    translate(42, -17.4)
    rotate(-PI/4)
  end

  def questionmark
    shape(shapes[:questionmark], 0, 0)
    translate(42, -18)
    rotate(-PI/4)
  end
end

class Shapes
  attr_accessor :data
  def initialize(names, load_proc)
    @data = names.each_with_object({}) do |name, result|
      result[name] = load_proc.call("#{name}.svg")
      #result[name].disable_style
    end
  end

  def [](name)
    data[name]
  end
end

Blueprint.new

