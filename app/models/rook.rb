class Rook < Piece
  attr_accessor :moved

  def initialize(color, current_position, board)
    # Calls the superclass constructor
    super(color, current_position, board)
    @moved = false
  end

  # Returns the unicode symbol for the piece
  def to_s
    color == :white ?  "♜" : "♖"
  end

  # Returns an array of valid moves for the piece
  def to_s
    color == :white ? "♜" : "♖"
  end

  # Returns an array of valid moves for the piece
  def valid_moves
    valid_moves = []

    cardinals = [[-1, 0], [1, 0], [0, -1], [0, 1]]
    cardinals.each do |direction|
      x, y = current_position
      while true
        x += direction[0]
        y += direction[1]
        new_position = [x, y]

        break unless x.between?(0, 7) && y.between?(0, 7)

        if board.board_state[x][y].nil?
          valid_moves << new_position
        elsif board.board_state[x][y].color != color
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
