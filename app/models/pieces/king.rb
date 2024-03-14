class King < Piece

  def initialize(color)
    super(color)
    @checked = false
    @moved = false
  end

  def to_s
    color == :white ? "♚" : "♔"
  end

  def move_to(new_position)
    self.current_position = new_position
    @moved = true
  end

  def valid_moves(current_position, board_state)
    valid_moves = []

    king_moves = [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [1, -1], [-1, 1], [-1, -1]]
    king_moves.each do |move|
      x = current_position[0] + move[0]
      y = current_position[1] + move[1]

      if x.between?(0, 7) && y.between?(0, 7) && (!board_state[x][y] || board_state[x][y].color != color)
        valid_moves << [x, y]
      end
    end
    valid_moves
  end
end
