# P.3.1.2
require 'propane'
require 'ruby-debug'

class Blueprint < Propane::App

  # TODO: WTF exaclty do these accessors do
  attr_accessor :center_x, :center_y
  attr_accessor :offset_x, :offset_y
  attr_accessor :zoom
  attr_accessor :text_input # TODO: Option to save this
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
    @text_input = ''
  end

  def setup
    sketch_title 'Blueprint'
    @font = create_font('Helvetica', 25)
    load_proc = ->(file) { load_shape(data_path(file)) }
    @shapes = Shapes.new(SHAPES, load_proc)
    # For debugging
  end

  def draw
    # TODO: scaling and translation are kinda key to this
    background(255)
    fill(0)
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
    text_input.chars.each_with_index do |char, index|
      char_width = text_width(char)
      method = char_method[char]
      if method
        send(method)
      elsif char.match(/[[:alpha:]]/)
        node(char, char_width, index) # TODO: Will probably need some type of node as more text_input types are added
      end
    end
  end

  # TODO: Maybe a command mode?
  def key_pressed
    case key.bytes
    when [8] # backspace
      @text_input.chop!
    else
      @text_input += key
    end

    # TODO: Legend / instructions
    system "clear"
    puts @text_input
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
    letterWidth = 15 # TODO: Pass this. Or maybe I don't need it?
    rect(0, -15, 15 + 1, 15)
    translate(15, 0)
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
    rotate(-PI / 4)
  end

  def questionmark
    shape(shapes[:questionmark], 0, 0)
    translate(42, -18)
    rotate(-PI / 4)
  end

  # I need to pad this out. Either:
  def node(char, char_width, index)
    # TODO: Need to get the complete string to draw a box around it
    # When I do that I'll also want padding around it
    # Pretty sure it's drawing from the center
    pad_leading if is_leading_char?(index)
    text(char, 0, 0)
    translate(char_width, 0)
  end

  private

  def is_leading_char?(index)
    return if index == 0 # Need to avoid wrapping the array
    prev_char = @text_input.chars[index - 1] # TODO: Better way to do this please
    !prev_char.match(/[[:alpha:]]/)
  end

  def pad_leading
    pushStyle
    fill(255)
    space
    popStyle
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

