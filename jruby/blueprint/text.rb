module Blueprint
  module Text
    def print_buffer
      system "clear"
      puts @text_input
      puts "#{' ' * @text_index}^"
      puts ""
      puts commands
    end

    # TODO: This is a bit shit, please tidy
    def handle(key)
      tail = @text_input[0..@text_index]
      head = @text_input[@text_index.succ..@text_input.length]

      # when [10] # Return

      if @text_mode == :none &&  movement_commands[key]
        send(movement_commands[key])
      elsif key.bytes == [8] # backspace
        tail.chop!
        left
        save_frame
      else
        tail += key
        right
        save_frame
      end

      @text_input = tail + (head || '')
    end
  end
end
