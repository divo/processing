require 'propane'

class GameOfLife < Propane::App

  def settings
    size(800, 600)
  end

  def setup
    sketch_title 'Conway'
  end

  def draw
    # First draw a grid

    tile_count = width / 5
    rect_size = width / tile_count

    for x in (0..tile_count)
      for y in (0..tile_count)
        stroke(122)
        fill(0)
        rect(x * rect_size, y * rect_size, rect_size, rect_size)
      end
    end
  end
end

GameOfLife.new
