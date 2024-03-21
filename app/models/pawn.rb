class Pawn < Piece
  attr_accessor :en_passant, :moved

  def initialize(color, current_position, board)
    # Calls the superclass constructor
    super(color, current_position, board)
    @moved = false
    @en_passant = false
  end

  # Returns the unicode symbol for the piece
  def to_s
    color == :white ? "♟" : "♙"
  end

  # Returns an array of valid moves for the piece
  def valid_moves
    raise "Not a Board instance" unless board.is_a?(Board)
    valid_moves = []
    direction = color == :white ? -1 : 1
    one_step = [current_position[0] + direction, current_position[1]]
    two_steps = [current_position[0] + 2 * direction, current_position[1]]
    captures = [[current_position[0] + direction, current_position[1] - 1], [current_position[0] + direction, current_position[1] + 1]]

    # Add one step move
    valid_moves << one_step if board.valid_square?(one_step)

    # Add two steps move if not moved yet
    valid_moves << two_steps if !@moved && board.valid_square?(two_steps)

    # Add captures, including en passant
    captures.each do |capture_pos|
      if board.valid_capture?(capture_pos, color) || board.en_passant_capture?(current_position, capture_pos)
        valid_moves << capture_pos
      end
    end

    valid_moves
  end
end
