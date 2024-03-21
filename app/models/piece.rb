class Piece < Tableless
  attr_accessor :color, :current_position, :board

  def initialize(color, current_position, board)
    @color = color
    @current_position = current_position
    @board = board
  end
end
