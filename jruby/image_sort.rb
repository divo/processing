# P.1.2.2
require 'propane'

class TemplateSketch < Propane::App

  def settings
    @img = load_image(data_path('image.jpg'))
    size(@img.width, @img.height)
  end

  def setup
    sketch_title 'Image sort'
    @sort = -> (colors) { colors.flatten }
  end

  def draw
    tile_count = width / [mouseX * 2, 2].max
    rect_size = width / tile_count # Do I need to make this a float explicitly

    colors = []

    # scan
    for y in (0..tile_count)
      colors << []
      for x in (0..tile_count)
        px = x * rect_size
        py = y * rect_size
        # Sort entire image, then later do sort row by row
        colors.last << @img.get(px, py)
      end
    end

    colors = @sort.call(colors)

    # draw
    i = 0
    for y in (0..tile_count)
      for x in (0..tile_count)
        fill colors[i]
        rect(x * rect_size, y * rect_size, rect_size, rect_size)
        i += 1
      end
    end
  end

  def key_pressed
    case key
    when 'a' # No sort
      @sort = -> (colors) { colors.flatten }
    when 's' # Basic sort
      @sort = -> (colors) { colors.each(&:sort!).flatten! }
    end
  end
end

TemplateSketch.new
