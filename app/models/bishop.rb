class Bishop < Piece
  attr_accessor :current_position

  def initialize(color, current_position)
    super(color, current_position)
  end

  def to_s
    color == :white ?  "♝" : "♗"
  end

  def move_to(new_position, board_state)
    board_state[new_position[0]][new_position[1]] = self
    board_state[current_position[0]][current_position[1]] = nil

    @current_position = new_position
  end

  def valid_moves(board_state)
    valid_moves = []

    diagonals = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
    diagonals.each do |diagonal|
      x, y = current_position
      while true
        x += diagonal[0]
        y += diagonal[1]
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
