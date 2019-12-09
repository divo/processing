# P.2.2.1

require 'propane'

class DumbAgents < Propane::App

  BACKGROUND = 255

  attr_accessor :step_size
  attr_accessor :diameter
  attr_accessor :mode
  attr_accessor :paused

  def settings
    size(2000, 1500)
  end

  def setup
    sketch_title 'DumbAgents'
    background(BACKGROUND)
    smooth()
    noStroke()
    @step_size = 1
    @diameter = 1
    @mode = 1
    @paused = false
    @counter = 0

    @pos_x, @pos_y = rand(width), rand(height) # Set these to random values?
  end

  def draw
    return if @paused
    @counter += 1

    for x in (0..mouseX)
      if mode == 2
        direction = rand(0..2)
      else
        direction = rand(0..7)
      end

      step(direction)
      wrap

      if mode == 3
        if @counter >= 10
          @counter = 0
          fill(192, 100, 64, 80)
          ellipse(@pos_x + step_size / 2, @pos_y + step_size / 2, diameter + 7, diameter + 7)
        end
      end

      fill(0, 40)
      ellipse(@pos_x + step_size / 2, @pos_y + step_size / 2, diameter, diameter)
    end
  end

  def step(direction)
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
  end

  def wrap
    @pos_x = 0 if @pos_x > width
    @pos_x = width if @pos_x < 0
    @pos_y = height if @pos_y < 0
    @pos_y = 0 if @pos_y > height
  end

  def keyReleased
    case key
    when 'd'
      background(BACKGROUND)
    when '1'
      @mode = 1
      @step_size = 1
      @diameter = 1
    when '2'
      @mode = 2
      @step_size = 1
      @diameter = 1
    when '3'
      @mode = 3
      @step_size = 10
      @diameter = 5
    when 'p'
      @paused = !@paused
    end
  end
end

DumbAgents.new
