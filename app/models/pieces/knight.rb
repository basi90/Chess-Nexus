class Knight < Piece

  def initialize(color)
    super(color)
  end

  def to_s
    color == :white ?  "♞" : "♘"
  end

  def move_to(new_position)
    self.current_position = new_position
  end

  def valid_moves(current_position, board_state)
    valid_moves = []

    knight_moves = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]]

    knight_moves.each do |move|
      x = current_position[0] + move[0]
      y = current_position[1] + move[1]

      if x.between?(0, 7) && y.between?(0, 7) && (!board_state[x][y] || board_state[x][y].color != color)
        valid_moves << [x, y]
      end
    end
    valid_moves
  end
end
