class King < Piece
  attr_accessor :moved, :checked

  def initialize(color, current_position, board)
    # Calls the superclass constructor
    super(color, current_position, board)
    @checked = false
    @moved = false
  end

  # Returns the unicode symbol for the piece
  def to_s
    color == :white ? "♚" : "♔"
  end

  # Returns an array of valid moves for the piece
  def valid_moves
    valid_moves = []

    king_moves = [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [1, -1], [-1, 1], [-1, -1]]
    king_moves.each do |move|
      x, y = current_position[0] + move[0], current_position[1] + move[1]
      if x.between?(0, 7) && y.between?(0, 7) && (!board.board_state[x][y] || board.board_state[x][y].color != color)
        valid_moves << [x, y]
      end
    end
    valid_moves
  end
end
