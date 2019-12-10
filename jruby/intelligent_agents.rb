require 'propane'

class IntelligentAgents< Propane::App

  def settings
    size(800, 600)
  end

  def setup
    sketch_title 'Intelligent Agents'
    @posX, @posY = rand(width), rand(height)
  end

  def draw
    for x in (0..mouseX)
      strokeWeight(1)
      stroke(180)
      point(@posX, @posY)
    end
  end
end

IntelligentAgents.new
