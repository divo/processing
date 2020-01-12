require 'propane'

module Blueprint
  module IO
    def read_file
      filename = $options[:input]
      if filename
        if File.exist?(filename)
          @text_input = File.read(filename)
          puts "read #{@text_input}"
          @text_input.gsub!("\n", '')
        else
          puts "Input file not found"
        end
      end
    end

    def write_file
      filename = $options[:output]
      if filename
        File.write(filename, @text_input)
      end
    end

    def save_image
      filename = $options[:image]
      # TODO: Make the size correct
      render # Need to render once to compute the size. There is probably a way to avoid this
      context = create_graphics(output_width, output_height)
      begin_record(context)
      render
      end_record
      context.save(filename)
    end
  end
end
