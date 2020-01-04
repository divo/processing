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

    end

    def save_image

    end
  end
end
