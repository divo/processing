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
    generate_decisions
    @strokeCap = ROUND
  end

  def draw
    background(255, 255, 255)

    strokeCap(@strokeCap)
    for y in (0...TILE_COUNT)
      for x in (0...TILE_COUNT)
        posX = width / TILE_COUNT * x
        posY = height / TILE_COUNT * y

        if @decisions[x][y]
          strokeWeight(mouseX / 20)
          line(posX, posY, posX + width / TILE_COUNT, posY + height / TILE_COUNT)
        else
          strokeWeight(mouseY / 20)
          line(posX, posY + width / TILE_COUNT, posX + height / TILE_COUNT, posY)
        end
      end
    end
  end

  def generate_decisions
    @decisions = Array.new(TILE_COUNT).map do |y|
      Array.new(TILE_COUNT).map do |x|
        [true, false].sample
      end
    end
  end

  def mousePressed
    generate_decisions
  end

  def keyReleased
    @strokeCap = ROUND if key == '1'
    @strokeCap = SQUARE if key == '2'
    @strokeCap = PROJECT if key == '3'
  end
end

GridAlign.new
