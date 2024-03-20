class Board
  attr_accessor :board_state

  def initialize
    # Initializes an 8x8 board with nil values
    @board_state = Array.new(8) { Array.new(8) {nil} }
    # Calls a method to place chess pieces in their starting positions
    setup_board
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
      piece.valid_moves(@board_state).include?(king_pos)
    end
  end

  private

  # Places all pieces in their initial positions on the board
  def setup_board
    @board_state[0][0] = Rook.new(:black, [0, 0])
    @board_state[0][1] = Knight.new(:black, [0, 1])
    @board_state[0][2] = Bishop.new(:black, [0, 2])
    @board_state[0][3] = Queen.new(:black, [0, 3])
    @board_state[0][4] = King.new(:black, [0, 4])
    @board_state[0][5] = Bishop.new(:black, [0, 5])
    @board_state[0][6] = Knight.new(:black, [0, 6])
    @board_state[0][7] = Rook.new(:black, [0, 7])

    @board_state[1].map!.with_index { |square, index| Pawn.new(:black, [1, index]) }

    @board_state[7][0] = Rook.new(:white, [7, 0])
    @board_state[7][1] = Knight.new(:white, [7, 1])
    @board_state[7][2] = Bishop.new(:white, [7, 2])
    @board_state[7][3] = Queen.new(:white, [7, 3])
    @board_state[7][4] = King.new(:white, [7, 4])
    @board_state[7][5] = Bishop.new(:white, [7, 5])
    @board_state[7][6] = Knight.new(:white, [7, 6])
    @board_state[7][7] = Rook.new(:white, [7, 7])

    @board_state[6].map!.with_index { |square, index| Pawn.new(:white, [6, index]) }
  end

  # Finds and returns the position of the king of the specified color
  def find_king(color)
    @board_state.each_with_index do |row, row_idx|
      row.each_with_index do |piece, col_idx|
        return [row_idx, col_idx] if piece.is_a?(King) && piece.color == color
      end
    end
  end

  # Returns an array of all pieces belonging to the opponent
  def opponent_pieces(color)
    @board_state.flatten.compact.select { |piece| piece.color != color }
  end
end
