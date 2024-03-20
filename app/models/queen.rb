class Queen < Piece
  attr_accessor :current_position

  def initialize(color, current_position)
    # Calls the superclass constructor
    super(color, current_position)
  end

  # Returns the unicode symbol for the piece
  def to_s
    color == :white ? "♛"  : "♕"
  end

  # Moves the piece to a new position, updating the board state
  def move_to(new_position, board_state)
    return false unless valid_moves(board_state).include?(new_position)

    board_state[new_position[0]][new_position[1]] = self
    board_state[current_position[0]][current_position[1]] = nil

    @current_position = new_position
  end

  # Returns an array of valid moves for the piece
  def valid_moves(board_state)
    valid_moves = []

    bishop = Bishop.new(color)
    rook = Rook.new(color)

    valid_moves += bishop.valid_moves(current_position, board_state)
    valid_moves += rook.valid_moves(current_position, board_state)

    return valid_moves
  end
end
