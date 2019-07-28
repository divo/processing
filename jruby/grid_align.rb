#!/usr/bin/env jruby
# frozen_string_literal: false
require 'propane'

class GridAlign < Propane::App
  TILE_COUNT = 20

  def settings
    size 1000, 1000
  end

  def setup
    sketch_title 'Grid Align'
  end

  def draw
    background(255, 255, 255)

    strokeCap(ROUND)
    for y in (0..TILE_COUNT)
      for x in (0..TILE_COUNT)
        posX = width / TILE_COUNT * x
        posY = height / TILE_COUNT * y

        if [true, false].sample
          strokeWeight(mouseX / 20)
          line(posX, posY, posX + width / TILE_COUNT, posY + height / TILE_COUNT)
        else
          strokeWeight(mouseY / 20)
          line(posX, posY + width / TILE_COUNT, posX + height / TILE_COUNT, posY)
        end
      end
    end
  end

  def generate_decision
    @decision = Array.new(TILE_COUNT)
    @decision.map do |y|
      Array.new(TILE_COUNT).map do |x|
        [true, false].sample
      end
    end
  end
end

# GridAlign.new
