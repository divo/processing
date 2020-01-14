require 'optparse'

module Blueprint
  module Options
    $options = {}

    OptionParser.new do |opts|
      opts.banner = 'Usage: blueprint.rb [options]'

      $options[:image] = 'output.png'
      $options[:svg_width] = 2000
      $options[:svg_height] = 1000

      opts.on('-i', '--input FILE', 'Read input file') do |file|
        # TODO: None of this block shit is needed. RTFM
        $options[:input] = file
      end

      opts.on('-o', '--output FILE', 'Output buffer to file') do |file|
        $options[:output] = file
      end

      opts.on('-s', '--stream', 'Read input file every frame') do |n|
        $options[:stream] = true
      end

      opts.on('--image FILE', 'Output png to file') do |file|
        $options[:image] = file
      end

      opts.on('--svg FILE, WIDTH, HEIGHT', Array, 'Output to svg of width and height. Does not open render window') do |file, width, height|
        $options[:svg] = file
        $options[:svg_width] &&= width.to_i
        $options[:svg_height] &&= height.to_i
      end
    end.parse!
  end
end
