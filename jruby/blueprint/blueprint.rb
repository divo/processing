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

require 'propane'
require 'ruby-debug'
require_relative 'shapes'
require_relative 'drawing'
require_relative 'commands'

module Blueprint
  class Diagram < Propane::App
    include Blueprint::Shapes
    include Blueprint::Drawing
    include Blueprint::Commands

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
  end
end

Blueprint::Diagram.new


