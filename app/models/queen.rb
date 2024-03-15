class Queen < Piece

  def initialize(color)
    super(color)
  end

  def to_s
    color == :white ? "♛"  : "♕"
  end

  def move_to(new_position)
    self.current_position = new_position
  end

  def valid_moves(current_position, board_state)
    valid_moves = []

    bishop = Bishop.new(color)
    rook = Rook.new(color)

    valid_moves += bishop.valid_moves(current_position, board_state)
    valid_moves += rook.valid_moves(current_position, board_state)

    return valid_moves
  end
end
