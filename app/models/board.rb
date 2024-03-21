class Board

  # SQUARES = {
  #   a8: [0, 0], b8: [0, 1], c8: [0, 2], d8: [0, 3],
  #   e8: [0, 4], f8: [0, 5], g8: [0, 6], h8: [0, 7],

  #   a7: [1, 0], b7: [1, 1], c7:  [1, 2], d7: [1, 3],
  #   e7: [1, 4], f7: [1, 5], g7:  [1, 6], h7: [1, 7],

  #   a6: [2, 0], b6: [2, 1], c6: [2, 2], d6: [2, 3],
  #   e6: [2, 4], f6: [2, 5], g6: [2, 6], h6: [2, 7],

  #   a5:  [3, 0], b5: [3, 1], c5: [3, 2], d5: [3, 3],
  #   e5:  [3, 4], f5: [3, 5], g5: [3, 6], h5: [3, 7],

  #   a4:  [4, 0], b4: [4, 1], c4: [4, 2], d4: [4, 3],
  #   e4:  [4, 4], f4: [4, 5], g4: [4, 6], h4: [4, 7],

  #   a3:  [5, 0], b3: [5, 1], c3: [5, 2], d3: [5, 3],
  #   e3:  [5, 4], f3: [5, 5], g3: [5, 6], h3: [5, 7],

  #   a2:  [6, 0], b2: [6, 1], c2: [6, 2], d2: [6, 3],
  #   e2:  [6, 4], f2: [6, 5], g2: [6, 6], h2: [6, 7],

  #   a1:  [7, 0], b1: [7, 1], c1: [7, 2], d1: [7, 3],
  #   e1:  [7, 4], f1: [7, 5], g1: [7, 6], h1: [7, 7]
  # }

  attr_accessor :board_state

  def initialize
    # Initializes an 8x8 board with nil values
    @board_state = Array.new(8) { Array.new(8) {nil} }
    # Calls a method to place chess pieces in their starting positions
    setup_board
  end

  def move_piece(from, to)
    piece = self.board_state[from[0]][from[1]]

    raise InvalidPieceError, "No piece at the given 'from' position." if piece.nil?
    unless piece.valid_moves.include?(to)
      raise InvalidDestinationError, "The move is not valid for the selected piece."
    end

    if piece.is_a?(King) && (to[1] - from[1]).abs == 2
      execute_castling(from, to)
    else
      simulate_move(piece, from, to) do
        raise InCheckError, "This move would leave the king in check." if king_in_check?(piece.color)
      end
      execute_move(piece, from, to)
    end
    update_king_checked_status
  end

  def display
    # Iterates over the board and prints it
    # Converts the internal representation into a chess board
    @board_state.each_with_index do |row, row_index|
      print "#{8 - row_index} "
      row.each do |square|
        if square.nil?
          print ". "
        else
          print "#{square.to_s} "
        end
      end
      puts
    end
    puts "  a b c d e f g h"
  end

  # Determines if the king of the specified color is in check by checking if any
  # of the opponent's pieces can move to the king's position
  def king_in_check?(king_color)
    king_pos = find_king(king_color)
    opponent_pieces(king_color).any? do |piece|
      piece.valid_moves.include?(king_pos)
    end
  end

  def valid_square?(square)
    row, col = square
    row.between?(0, 7) && col.between?(0, 7) && @board_state[row][col].nil?
  end

  def valid_capture?(square, color)
    row, col = square
    return false unless row.between?(0, 7) && col.between?(0, 7)
    target_piece = @board_state[row][col]
    target_piece && target_piece.color != color
  end

  def en_passant_capture?(from, to)
    moving_piece = board_state[from[0]][from[1]]
    target_square = board_state[to[0]][to[1]]

    return false unless moving_piece.is_a?(Pawn) && target_square.nil?

    adjacent_square = board_state[from[0]][to[1]]
    adjacent_square.is_a?(Pawn) && adjacent_square.en_passant
  end

  private

  # Places all pieces in their initial positions on the board
  def setup_board
    @board_state[0][0] = Rook.new(:black, [0, 0], self)
    @board_state[0][1] = Knight.new(:black, [0, 1], self)
    @board_state[0][2] = Bishop.new(:black, [0, 2], self)
    @board_state[0][3] = Queen.new(:black, [0, 3], self)
    @board_state[0][4] = King.new(:black, [0, 4], self)
    @board_state[0][5] = Bishop.new(:black, [0, 5], self)
    @board_state[0][6] = Knight.new(:black, [0, 6], self)
    @board_state[0][7] = Rook.new(:black, [0, 7], self)

    @board_state[1].map!.with_index { |square, index| Pawn.new(:black, [1, index], self) }

    @board_state[7][0] = Rook.new(:white, [7, 0], self)
    @board_state[7][1] = Knight.new(:white, [7, 1], self)
    @board_state[7][2] = Bishop.new(:white, [7, 2], self)
    @board_state[7][3] = Queen.new(:white, [7, 3], self)
    @board_state[7][4] = King.new(:white, [7, 4], self)
    @board_state[7][5] = Bishop.new(:white, [7, 5], self)
    @board_state[7][6] = Knight.new(:white, [7, 6], self)
    @board_state[7][7] = Rook.new(:white, [7, 7], self)

    @board_state[6].map!.with_index { |square, index| Pawn.new(:white, [6, index], self) }
  end

  # Finds and returns the position of the king of the specified color
  def find_king(color)
    @board_state.each_with_index do |row, row_idx|
      row.each_with_index do |piece, col_idx|
        return [row_idx, col_idx] if piece.is_a?(King) && piece.color == color
      end
    end
  end

  def update_king_checked_status
    [:white, :black].each do |color|
      king = find_king(color)
      board_state[king[0]][king[1]].checked = king_in_check?(color) if king
    end
  end

  # Returns an array of all pieces belonging to the opponent
  def opponent_pieces(color)
    @board_state.flatten.compact.select { |piece| piece.color != color }
  end

  # Check if the king and rook involved in the castling have not moved
  def can_castle?(king_position)
    king = @board_state[king_position[0]][king_position[1]]
    king.is_a?(King) && !king.moved && !king.checked
  end

  # Checks if the rook involved in the castling has not moved
  def rook_has_not_moved?(king_position, direction)
    row = king_position[0]
    col = direction > 0 ? 7 : 0 # Rook's column based on castling direction
    rook = @board_state[row][col]
    rook.is_a?(Rook) && !rook.moved
  end

  # Checks if the path between the king and the rook is clear
  def castling_path_clear?(king_position, direction)
    row, col = king_position
    steps = direction > 0 ? 2 : 3
    (1..steps).all? do |step|
      @board_state[row][col + step * direction].nil?
    end
  end

  def execute_castling(king, from, to)
    direction = to[1] - from[1] > 0 ? 1 : -1
    rook_from_col = direction > 0 ? 7 : 0
    rook_to_col = direction > 0 ? 5 : 3

    rook_from = [from[0], rook_from_col]
    rook_to = [from[0], rook_to_col]
    rook = @board_state[rook_from[0]][rook_from[1]]

    # Move king
    @board_state[to[0]][to[1]] = king
    @board_state[from[0]][from[1]] = nil
    king.current_position = to
    king.moved = true

    # Move rook
    @board_state[rook_to[0]][rook_to[1]] = rook
    @board_state[rook_from[0]][rook_from[1]] = nil
    rook.current_position = rook_to
    rook.moved = true
  end

  def simulate_move(piece, from, to)
    original_position = piece.current_position.dup
    board_state[to[0]][to[1]] = piece
    board_state[from[0]][from[1]] = nil
    piece.current_position = to

    yield

    # Revert the move
    piece.current_position = original_position
    board_state[from[0]][from[1]] = piece
    board_state[to[0]][to[1]] = nil
  end

  def execute_move(piece, from, to)
    board_state[to[0]][to[1]] = piece
    board_state[from[0]][from[1]] = nil
    piece.current_position = to

    reset_en_passant_status
    if piece.is_a?(Pawn)

      if (from[0] - to[0]).abs == 2
        piece.en_passant = true
      end

      if en_passant_capture?(from, to)
        captured_pawn_position = [from[0], to[1]]
        board_state[captured_pawn_position[0]][captured_pawn_position[1]] = nil
      end

      if promotion?(piece, to)
        promote_pawn(to)
      end
    end
  end

  def reset_en_passant_status
    board_state.each do |row|
      row.each do |square|
        if square.is_a?(Pawn)
          square.en_passant = false
        end
      end
    end
  end

  def promotion?(piece, to)
    piece.is_a?(Pawn) && (to[0] == 0 || to[0] == 7)
  end

  def promote_pawn(position)
    pawn = board_state[position[0]][position[1]]
    raise "No pawn to promote at #{position}" unless pawn.is_a?(Pawn)

    puts "Pawn promotion! Choose a piece to promote to: Q, R, B, N"
    input = gets.chomp.upcase
    new_piece =
      case input
      when "Q" then Queen.new(pawn.color, position, self)
      when "R" then Rook.new(pawn.color, position, self)
      when "B" then Bishop.new(pawn.color, position, self)
      when "N" then Knight.new(pawn.color, position, self)
      else raise "Invalid choice"
      end

    board_state[position[0]][position[1]] = new_piece
  end
end
