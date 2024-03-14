class Bishop < Piece

  def initialize(color)
    super(color)
  end

  def to_s
    color == :white ?  "♝" : "♗"
  end

  def move_to(new_position)
    self.current_position = new_position
  end

  def valid_moves(current_position, board_state)
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
