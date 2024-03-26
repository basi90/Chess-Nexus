class Bishop < Piece

  def initialize(color, current_position, board)
    # Calls the superclass constructor
    super(color, current_position, board)
  end

  # Returns the unicode symbol for the piece
  def to_s
    color == "white" ?  "♝" : "♗"
  end

  # Returns an array of valid moves for the piece
  def valid_moves
    raise "Not a Board instance" unless board.is_a?(Board)
    valid_moves = []

    diagonals = [[-1, -1], [-1, 1], [1, -1], [1, 1]]
    diagonals.each do |direction|
      x, y = current_position
      while true
        x += direction[0]
        y += direction[1]
        new_position = [x, y]

        break unless x.between?(0, 7) && y.between?(0, 7)

        if @board.check_board[x][y].nil?
          valid_moves << new_position
        elsif @board.check_board[x][y].color != color
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
