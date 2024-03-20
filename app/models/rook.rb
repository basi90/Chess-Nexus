class Rook < Piece
  attr_accessor :current_position, :moved

  def initialize(color, current_position)
    # Calls the superclass constructor
    super(color, current_position)
    @moved = false
  end

  # Returns the unicode symbol for the piece
  def to_s
    color == :white ?  "♜" : "♖"
  end

  # Moves the piece to a new position, updating the board state
  def move_to(new_position, board_state)
    return false unless valid_moves(board_state).include?(new_position)

    board_state[new_position[0]][new_position[1]] = self
    board_state[current_position[0]][current_position[1]] = nil

    @current_position = new_position
    @moved = true
  end

  # Returns an array of valid moves for the piece
  def valid_moves(board_state)
    valid_moves = []

    cardinals = [[-1, 0], [1, 0], [0, -1], [0, 1]]
    cardinals.each do |cardinal|
      x, y = current_position
      while true
        x += cardinal[0]
        y += cardinal[1]
        break unless x.between?(0, 7) && y.between?(0, 7)

        if board_state[x][y].nil?
          valid_moves << [x, y]
        elsif board_state[x][y].color != color
          valid_moves << [x, y]
          break
        else
          break
        end
      end
    end
    valid_moves
  end
end
