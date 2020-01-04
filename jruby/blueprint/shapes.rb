# Everything hangs off App, so just mix extra stuff in.
# As opposed to classes and having to give stuff contexts to work
module Blueprint
  module Shapes
    attr_accessor :data

    def load_shapes(names)
      @data = names.each_with_object({}) do |name, result|
        result[name] = load_shape(data_path("#{name}.svg"))
        #result[name].disable_style
      end
    end

    def [](name)
      data[name]
    end
  end
end

# NOTES: What are the main compnents of this thing so far?
# Text manipulation
# Input handling
# Commands
# X Drawing
