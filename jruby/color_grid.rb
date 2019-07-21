#!/usr/bin/env jruby
# frozen_string_literal: false
require 'propane'

class ColorGrid < Propane::App
  def settings
    size 1000, 1000
  end

  def setup
    sketch_title 'Color Grid'
    noStroke
    colorMode(HSB, width, height, 100) # width and height passed to colorMode act as range. 
                                       # Now args are the upper bound, not 360
  end

  def draw
    stepX, stepY = mouseX + 2, mouseY + 2

    # Iterate over screen with step\
    for y in (0..height).step(stepY)
      for x in (0..width).step(stepX)
        fill(x, height - y, 100)
        rect(x, y, stepX, stepY)
      end
    end
  end
end

ColorGrid.new
