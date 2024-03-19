class Piece < Tableless
  attr_accessor :color, :current_position

  def initialize(color, current_position)
    @color = color
    @current_position = current_position
  end
end
