class Shapes
  attr_accessor :data
  def initialize(names, load_proc)
    @data = names.each_with_object({}) do |name, result|
      result[name] = load_proc.call("#{name}.svg")
      #result[name].disable_style
    end
  end

  def [](name)
    data[name]
  end
end

