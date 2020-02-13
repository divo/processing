# P.3.1.2
# TODO:
# Clean all this into classes (although this comes last I think)
# Add a command mode
# Decide on commands
# TODO:
# Current position in graph
# DONE. Save image. TODO: As a command instead of every frame?
# Need to save entire canvas. Might be a fundamental issue here....
# DONE. Save string, stream it out to a file
# DONE. Read stirng
# DONE. Stations
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
  # Maybe I don't want this? It could make shit really unclear really quick. Have a look at other subway maps to see if they allow this.
  # Pretty sure they do not. Maybe do out some complicated-ish decision graphs and see how it looks.
# Decision node
# Vanity / Component node
# Draw ? and other chars
# Into gem
# Save entire canvas

require 'propane'
require 'ruby-debug'
require_relative 'shapes'
require_relative 'drawing'
require_relative 'commands'
require_relative 'text'
require_relative 'options'
require_relative 'io'
require_relative 'translate'

module Blueprint
  class Diagram < Propane::App
    load_library 'svg'
    include_package 'processing.svg'
    include Blueprint::Shapes
    include Blueprint::Drawing
    include Blueprint::Commands
    include Blueprint::Text
    include Blueprint::IO
    include Blueprint::Translate

    # TODO: WTF exaclty do these accessors do
    # TODO: Move accessors from modules to modules, and build easy initalizer
    attr_accessor :center_x, :center_y
    attr_accessor :offset_x, :offset_y
    attr_accessor :zoom
    attr_accessor :text_input # TODO: Option to save this
    attr_accessor :font
    attr_accessor :shapes
    attr_accessor :text_mode
    attr_accessor :push_count
    attr_accessor :current_x, :current_y

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
      if $options[:svg]
        size($options[:svg_width], $options[:svg_height], SVG, "#{$options[:svg]}.svg")
      else
        size(1200, 800)
      end
      @center_x, @center_y = width / 2, height / 2 # TODO: Mouse clicked
      @offset_x, @offset_y = 0, 0
      zoom = 1 # TODO: Scaling
      @text_input = ''
      @text_mode = :none
      @push_count = 0
    end

    def setup
      sketch_title 'Blueprint'
      @font = create_font('Helvetica', 25)
      @shapes = load_shapes(SHAPES)
      read_file
      @text_index = @text_input.length - 1
    end

    def draw
      render
    end

    def render
      reset_transform_tracking
      reset_matrix
      # TODO: scaling and translation are kinda key to this
      background(255)
      fill(0)
      # smooth
      no_stroke
      text_align(LEFT)

      if $options[:stream]
        # TODO: This should probably ignore all key input
        read_file
      end

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
        elsif # char.match(/[[:alpha:]]/)
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

      handle(key)
      print_buffer
    end

    def mouse_pressed
      @offset_x = mouseX - @center_x
      @offset_y = mouseY - @center_y
    end

    def save_frame
      write_file
      #save_image #TODO: Dont save the cursor. Also may want to make this a command...
    end
  end
end

Blueprint::Diagram.new

