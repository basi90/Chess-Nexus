class Queen < Piece

  def initialize(color, current_position, board)
    # Calls the superclass constructor
    super(color, current_position, board)
  end

  # Returns the unicode symbol for the piece
  def to_s
    color == "white" ? "♛"  : "♕"
  end

  # Returns an array of valid moves for the piece
  def valid_moves
    valid_moves = []

    # Combine directions for bishop-like and rook-like moves
    directions = [[1, 1], [1, -1], [-1, 1], [-1, -1], [-1, 0], [1, 0], [0, -1], [0, 1]]

    directions.each do |direction|
      x, y = current_position
      while true
        x += direction[0]
        y += direction[1]
        new_position = [x, y]

        break unless x.between?(0, 7) && y.between?(0, 7)

        if board.valid_square?(new_position)
          valid_moves << new_position
        elsif board.valid_capture?(new_position, self.color, @board.check_board)
          valid_moves << new_position
          break
        else
          break
        end
      end
    end
    valid_moves
  end
end
