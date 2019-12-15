require 'propane'

# Any live cell with two or three neighbors survives.
# Any dead cell with three live neighbors becomes a live cell.
# All other live cells die in the next generation. Similarly, all other dead cells stay dead.
class GameOfLife < Propane::App

  def settings
    size(800, 600)
  end

  def setup
    sketch_title 'Conway'
  end

  def draw
    # Compute the grid
    # Can do this cell by cell or treat the grid as an object


    # Draw the grid
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

class Grid
  def to_a
    @grid ||= TODO
  end
end

GameOfLife.new
