class Pawn < Piece
  attr_accessor :en_passant, :current_position

  def initialize(color, current_position)
    # Calls the superclass constructor
    super(color, current_position)
    @moved = false
    @en_passant = false
  end

  # Returns the unicode symbol for the piece
  def to_s
    color == :white ? "♟" : "♙"
  end

  # Moves the piece to a new position, updating the board state
  def move_to(new_position, board_state)
    return false unless valid_moves(board_state).include?(new_position)

    if (new_position[0] - current_position[0]).abs == 2
      @en_passant = true
    else
      @en_passant = false
    end

    if en_passant_capture?(new_position, board_state)
      captured_pawn_position = [current_position[0], new_position[1]]
      board_state[captured_pawn_position[0]][captured_pawn_position[1]] = nil
    end

    board_state[new_position[0]][new_position[1]] = self
    board_state[current_position[0]][current_position[1]] = nil

    @current_position = new_position
    @moved = true

    if color == :white && new_position[0] == 0
      promote(new_position, board_state)
    elsif color == :black && new_position[0] == 7
      promote(new_position, board_state)
    end
  end

  # Returns an array of valid moves for the piece
  def valid_moves(board_state)
    valid_moves = []

    direction = color == :white ? -1 : 1

    one_up = [current_position[0] + direction, current_position[1]]
    valid_moves << one_up if valid_square?(one_up, board_state)

    two_up = [current_position[0] + (2 * direction), current_position[1]]
    valid_moves << two_up if !@moved && valid_square?(two_up, board_state)

    capture_left = [current_position[0] + direction, current_position[1] - 1]
    valid_moves << capture_left if valid_capture?(capture_left, board_state) || en_passant_capture?(capture_left, board_state)

    capture_right = [current_position[0] + direction, current_position[1] + 1]
    valid_moves << capture_right if valid_capture?(capture_right, board_state) || en_passant_capture?(capture_right, board_state)

    valid_moves
  end

  private

  # Checks if a given square is within the bounds of the board and empty
  def valid_square?(square, board_state)
    square[0].between?(0, 7) && square[1].between?(0, 7) && board_state[square[0]][square[1]].nil?
  end

  # Checks if a capture move to a given square is legal for the pawn
  def valid_capture?(square, board_state)
    square[0].between?(0, 7) && square[1].between?(0, 7) && board_state[square[0]][square[1]] && board_state[square[0]][square[1]].color != color
  end

  # Determines if an en passant capture is possible on a given square
  def en_passant_capture?(square, board_state)
    return false unless square[0].between?(0, 7) && square[1].between?(0, 7)
    return false unless board_state[current_position[0]] && board_state[current_position[0]][square[1]]
    return false unless board_state[square[0]][square[1]].nil?
    return false unless board_state[current_position[0]][square[1]] && board_state[current_position[0]][square[1]].is_a?(Pawn)
    return false unless board_state[current_position[0]][square[1]].color != color
    return false unless board_state[current_position[0]][square[1]].en_passant

    true
  end

  # Handles the promotion of a pawn when it reaches the opposite end of the board
  def promote(new_position, board_state)
    puts "Pawn promotion!"
    puts "promote to: Q, R, B, or K"
    input = gets.chomp.upcase

    case input
    when "Q"
      board_state[new_position[0]][new_position[1]] = Queen.new(color)
    when "R"
      board_state[new_position[0]][new_position[1]] = Rook.new(color)
    when "B"
      board_state[new_position[0]][new_position[1]] = Bishop.new(color)
    when "K"
      board_state[new_position[0]][new_position[1]] = Knight.new(color)
    else
      puts "Invalid input. Please try again."
      promote(new_position, board_state)
    end
  end
end
