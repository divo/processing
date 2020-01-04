module Blueprint
  module Drawing
    def space
      letterWidth = 15 # TODO: Pass this. Or maybe I don't need it?
      rect(0, -15, 15 + 1, 15)
      translate(15, 0)
    end

    def down_45
      shape(shapes[:comma], 0, 0)
      translate(31.5, 13.5)
      rotate(Math::PI / 4)
    end

    def up_90
      shape(shapes[:period], 0, 0)
      translate(56, -54)
      rotate(-Math::PI / 2)
    end

    def up_45
      shape(shapes[:exclamationmark], 0, 0)
      translate(42, -17.4)
      rotate(-Math::PI / 4)
    end

    def questionmark
      shape(shapes[:questionmark], 0, 0)
      translate(42, -18)
      rotate(-Math::PI / 4)
    end

    def draw_string(char, char_width, index)
      if @text_mode == :node
        node(char, char_width, index)
      elsif @text_mode == :message
        message(char, char_width, index)
      end
    end

    def open_message
      @text_mode = :message
      pad
    end

    def close_message
      pad
      @text_mode = :none
    end

    def open_node
      @text_mode = :node
      rect(0, -40, 4, 60)
      rect(0, -40, 15 + 1, 4) # TODO: const 15
      rect(0, 20, 15 + 1, 4)
      pad
    end

    def close_node
      pad
      rect(0, -40, 4, 60)
      rect(0, -40, -(15 + 1), 4)
      rect(4, 20, -(15 + 4), 4) # 4s make sense bc everythng is overlapping. Would be better to not do that
      @text_mode = :none
    end

    def push
      # Can't do this every draw loop. Need these commands to exist outside the loop
      # Or just do em once and set a flag to stop
      push_matrix
      @push_count = @push_count.next
    end

    def pop
      return if @push_count.zero?
      pop_matrix
      @push_count -= 1
    end

    def left
      return if @text_index == 0
      @text_index -= 1 #TODO: Less indexs please
    end

    def right
      return if @text_index == @text_input.length
      @text_index += 1
    end

    def cursor
      push_matrix
      translate(0, 25)
      draw_char('^', 0) # Char width donesn't matter at the end
      pop_matrix
    end

    def arrow_forward
      push_matrix
      translate(0, -7.5)
      triangle(0, 15, 15, 0, 0, -15)
      pop_matrix
      translate(15, 0)
    end

    def arrow_backward
      push_matrix
      translate(0, -7.5)
      triangle(15, 15, 0, 0, 15, -15)
      pop_matrix
      translate(15, 0)
    end

    def state
      fill(0)
      ellipse(-5, -7, 33, 33)
      fill(255)
      ellipse(-5, -7, 25, 25)

      fill(0)
    end

    private

    # Must be opened and closed
    def node(char, char_width, index)
      rect(0, -40, char_width + 1, 4)
      rect(0, 20, char_width + 1, 4)
      draw_char(char, char_width)
    end

    def message(char, char_width, index)
      # TODO: Need to get the complete string to draw a box around it
      draw_char(char, char_width)
    end

    def draw_char(char, char_width)
      text(char, 0, 0)
      translate(char_width, 0)
    end

    def pop_all
      @push_count.times { pop_matrix }
      @push_count = 0
    end

    def pad
      translate(15, 0)
    end
  end
end
