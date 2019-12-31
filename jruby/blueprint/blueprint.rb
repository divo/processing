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
        draw_string(char, char_width, index) # TODO: Will probably need some type of node as more text_input types are added
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

  # TODO: Come up with sensible drawing commands
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

  def draw_string(char, char_width, index)
    #node(char, char_width, index)
    message(char, char_width, index)
  end

  private

  def node(char, char_width, index)
    # Draw leading / closing brace seperate to middle brace
    if leading_char?(index) # Draw opening
      rect(0, -40, 4, 60)
      rect(0, -40, 15 + 1, 4) # TODO: const 15
      rect(0, 20, 15 + 1, 4)
      pad
    end

    rect(0, -40, char_width + 1, 4)
    rect(0, 20, char_width + 1, 4)
    draw_char(char, char_width)

    if trailing_char?(index) # Draw closing
      pad
      rect(0, -40, 4, 60)
      rect(0, -40, -(15 + 1), 4)
      rect(4, 20, -(15 + 4), 4) # 4s make sense bc everythng is overlapping. Would be better to not do that
    end
  end

  def message(char, char_width, index)
    # TODO: Need to get the complete string to draw a box around it
    pad if leading_char?(index)
    draw_char(char, char_width)
    pad if trailing_char?(index)
  end

  def draw_char(char, char_width)
    text(char, 0, 0)
    translate(char_width, 0)
  end

  # True if char at previous index is non ASCII
  def leading_char?(index)
    return true if index == 0 # Need to avoid wrapping the array

    prev_char = @text_input.chars[index - 1] # TODO: Better way to do this please
    !prev_char.match(/[[:alpha:]]/)
  end

  # True if char is ASCII and next char is not
  # TODO: This is still bugged, I think I need proper delimiters
  def trailing_char?(index)
    next_char = @text_input.chars[index.succ]
    return true unless next_char

    !next_char.match(/[[:alpha:]]/)
  end

  def pad
    translate(15, 0)
  end
end

Blueprint.new

