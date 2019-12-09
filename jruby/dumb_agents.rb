# P.2.2.1

require 'propane'

class DumbAgents < Propane::App

  def settings
    size(2000, 1500)
  end

  def setup
    sketch_title 'DumbAgents'
    background(255)
    smooth()
    noStroke()

    @pos_x, @pos_y = rand(width), rand(height) # Set these to random values?
  end


  def draw
    step_size = 1
    diameter = 1
    for x in (0..mouseX)
      direction = rand(8)
      case direction
      when 0
        @pos_y -= step_size
      when 1
        @pos_x += step_size
        @pos_y -= step_size
      when 2
        @pos_x += step_size
      when 3
        @pos_x += step_size
        @pos_y += step_size
      when 4
        @pos_y += step_size
      when 5
        @pos_x -= step_size
        @pos_y += step_size
      when 6
        @pos_x -= step_size
      when 7
        @pos_x -= step_size
        @pos_y -= step_size
      end

      @pos_x = 0 if @pos_x > width
      @pos_x = width if @pos_x < 0
      @pos_y = height if @pos_y < 0
      @pos_y = 0 if @pos_y > height

      fill(0, 40)
      ellipse(@pos_x + step_size / 2, @pos_y + step_size / 2, diameter, diameter)
    end
  end
end

DumbAgents.new
