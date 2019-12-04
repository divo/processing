# P.1.2.2
require 'propane'

class TemplateSketch < Propane::App

  def settings
    size(800, 600)
  end

  def setup
    sketch_title 'Template'
    @img = load_image(data_path('image.jpg'))
  end

  def draw
  end
end

TemplateSketch.new
