module Blueprint
  # There is no way to inspect the current transformation matrix so I need to track it manually.
  # This is needed to create a buffer big enough to capture the entire canvas
  module Translate
    def translate(x, y)
      @current_x += x
      @current_y += y
      super
    end

    def reset_transform_tracking
      @current_x, @current_y = 0, 0
    end

    def output_width
      @current_x.abs + 100
    end

    def output_height
      @current_y.abs + 100
    end
  end
end
