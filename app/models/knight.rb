class Knight < Piece

  def initialize(color, current_position, board)
    # Calls the superclass constructor
    super(color, current_position, board)
  end

  # Returns the unicode symbol for the piece
  def to_s
    color == "white" ?  "♞" : "♘"
  end

  # Returns an array of valid moves for the piece
  def valid_moves
    valid_moves = []

    knight_moves = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]]

    knight_moves.each do |move|
      new_x = current_position[0] + move[0]
      new_y = current_position[1] + move[1]
      new_position = [new_x, new_y]

      # Check if the move is within board bounds
      if new_x.between?(0, 7) && new_y.between?(0, 7)
        # Check if the new position is either empty or contains an opponent's piece
        if board.valid_square?(new_position) || board.valid_capture?(new_position, self.color, @board.check_board)
          valid_moves << new_position
        end
      end
    end
    valid_moves
  end
end
