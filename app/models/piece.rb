class Piece < Tableless
  attr_accessor :color, :current_position

  def initialize(color)
    @color = color
  end
end
