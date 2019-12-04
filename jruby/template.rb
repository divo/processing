require 'propane'

class TemplateSketch < Propane::App

  def settings
    size(800, 600)
  end

  def setup
    sketch_title 'Template'
  end

  def draw
  end
end

TemplateSketch.new
