# P.3.1.2
# TODO:
# Clean all this into classes (although this comes last I think)
# Add a command mode
# Decide on commands
# TODO:
# Current position in graph
# Save image
# Save string
# Stations
# Color pallete. Selectable. Red, black, green, blue
# Come up with commands. V1 DONE
# Legend
# Print string in sketch?
# Tidy up code and break apart
# Address remaining todos
# MAIN ONES:
# DONE. Arrows
# Text alignment always up. Unable to get current matrix. Will have to track this manually
# Branch from nodes in different directions
# Decision node
# Vanity / Component node


# Clean this thing up. What are the main components?

require 'propane'
require 'ruby-debug'
require_relative 'shapes'

class Blueprint < Propane::App
  include Shapes

  # TODO: WTF exaclty do these accessors do
  attr_accessor :center_x, :center_y
  attr_accessor :offset_x, :offset_y
  attr_accessor :zoom
  attr_accessor :text_input # TODO: Option to save this
  attr_accessor :font
  attr_accessor :shapes
  attr_accessor :text_mode
  attr_accessor :push_count

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
    size(400, 300)
    #size(600, 400)
    @center_x, @center_y = width / 2, height / 2 # TODO: Mouse clicked
    @offset_x, @offset_y = 0, 0
    zoom = 1 # TODO: Scaling
    @text_input = ''
    @text_mode = :none
    @push_count = 0
    @text_index = 0
  end

  def setup
    sketch_title 'Blueprint'
    @font = create_font('Helvetica', 25)
    @shapes = load_shapes(SHAPES)
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
      method = commands[char]
      if method
        send(method)
      elsif char.match(/[[:alpha:]]/)
        draw_string(char, char_width, index) # TODO: Will probably need some type of node as more text_input types are added
      end

      if index == @text_index
        cursor
      end
    end

    pop_all
  end

  def key_pressed
    return unless key.respond_to?(:bytes)

    tail = @text_input[0..@text_index]
    head = @text_input[@text_index.succ..@text_input.length]

    # when [10] # Return

    if @text_mode == :none &&  movement_commands[key]
      send(movement_commands[key])
    elsif key.bytes == [8] # backspace
      tail.chop!
      left
    else
      tail += key
      right
    end

    @text_input = tail + (head || '')

    system "clear"
    puts @text_input
    puts "#{' ' * @text_index}^"
    puts ""
    puts commands
  end

  def mouse_pressed
    @offset_x = mouseX - @center_x
    @offset_y = mouseY - @center_y
  end

  def movement_commands
    {
      'h' => :left,
      'l' => :right
    }
  end

  def commands
    #  Old commands
    #  ' ' => :space
    #  ',' => :down_45
    #  '.' => :up_90
    #  '1' => :up_45
    #  '2' => :questionmark
    {
      ' ' => :space,
      '.' => :down_45,
      ',' => :up_45,
      '(' => :open_message,
      ')' => :close_message,
      '[' => :open_node,
      ']' => :close_node,
      '<' => :push,
      '>' => :pop,
      '/' => :arrow_forward, # TODO: Maybe use the push / pop stuff for this?
      '\\' => :arrow_backward
    }
  end

  def space
    letterWidth = 15 # TODO: Pass this. Or maybe I don't need it?
    rect(0, -15, 15 + 1, 15)
    translate(15, 0)
  end

  def down_45
    shape(shapes[:comma], 0, 0)
    translate(31.5, 13.5)
    rotate(PI / 4)
  end

  def up_90
    shape(shapes[:period], 0, 0)
    translate(56, -54)
    rotate(-PI / 2)
  end

  def up_45
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
    if @text_mode == :node
      node(char, char_width, index)
    elsif @text_mode == :message
      message(char, char_width, index)
    end
  end

  def open_message
    @text_mode = :message
    pad
  end

  def close_message
    pad
    @text_mode = :none
  end

  def open_node
    @text_mode = :node
    rect(0, -40, 4, 60)
    rect(0, -40, 15 + 1, 4) # TODO: const 15
    rect(0, 20, 15 + 1, 4)
    pad
  end

  def close_node
    pad
    rect(0, -40, 4, 60)
    rect(0, -40, -(15 + 1), 4)
    rect(4, 20, -(15 + 4), 4) # 4s make sense bc everythng is overlapping. Would be better to not do that
    @text_mode = :none
  end

  def push
    # Can't do this every draw loop. Need these commands to exist outside the loop
    # Or just do em once and set a flag to stop
    push_matrix
    @push_count = @push_count.next
  end

  def pop
    return if @push_count.zero?
    pop_matrix
    @push_count -= 1
  end

  def left
    return if @text_index == 0
    @text_index -= 1 #TODO: Less indexs please
  end

  def right
    return if @text_index == @text_input.length
    @text_index += 1
  end

  def cursor
    push_matrix
    translate(0, 25)
    draw_char('^', 0) # Char width donesn't matter at the end
    pop_matrix
  end

  def arrow_forward
    push_matrix
    translate(0, -7.5)
    triangle(0, 15, 15, 0, 0, -15)
    pop_matrix
    translate(15, 0)
  end

  def arrow_backward
    push_matrix
    translate(0, -7.5)
    triangle(15, 15, 0, 0, 15, -15)
    pop_matrix
    translate(15, 0)
  end

  private

  # Must be opened and closed
  def node(char, char_width, index)
    rect(0, -40, char_width + 1, 4)
    rect(0, 20, char_width + 1, 4)
    draw_char(char, char_width)
  end

  def message(char, char_width, index)
    # TODO: Need to get the complete string to draw a box around it
    draw_char(char, char_width)
  end

  def draw_char(char, char_width)
    text(char, 0, 0)
    translate(char_width, 0)
  end

  def pop_all
    @push_count.times { pop_matrix }
    @push_count = 0
  end

  def pad
    translate(15, 0)
  end
end

Blueprint.new

