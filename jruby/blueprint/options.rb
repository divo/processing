require 'optparse'

module Blueprint
  module Options
    $options = {}

    OptionParser.new do |opts|
      opts.banner = 'Usage: blueprint.rb [options]'

      $options[:image] = 'output.png'

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
    end.parse!
  end
end
