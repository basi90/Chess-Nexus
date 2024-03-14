class Pawn < Piece

  def initialize(color)
    super(color)
    @moved = false
  end

  def to_s
    color == :white ? "♟" : "♙"
  end

  def move_to(new_position)
    self.current_position = new_position
    @moved = true
  end

  def valid_moves(current_position, board_state)
    valid_moves = []

    direction = color == :white ? -1 : 1

    one_up = [current_position[0] + direction, current_position[1]]
    valid_moves << one_up if valid_square?(one_up, board_state)

    two_up = [current_position[0] + (2 * direction), current_position[1]]
    valid_moves << two_up if !@moved && valid_square?(two_up, board_state)

    valid_moves
  end

  private

  def valid_square?(square, board_state)
    square[0].between?(0, 7) && square[1].between?(0, 7) && board_state[square[0]][square[1]].nil?
  end
end
