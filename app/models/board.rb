require_relative "pieces/piece"
require_relative "pieces/rook"
require_relative "pieces/knight"
require_relative "pieces/bishop"
require_relative "pieces/queen"
require_relative "pieces/king"
require_relative "pieces/pawn"



class Board
  attr_accessor :board_state

  def initialize
    @board_state = Array.new(8) { Array.new(8) {nil} }
    setup_board
  end

  def display
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

  private

  def setup_board
    @board_state[0][0] = Rook.new(:white)
    @board_state[0][1] = Knight.new(:white)
    @board_state[0][2] = Bishop.new(:white)
    @board_state[0][3] = Queen.new(:white)
    @board_state[0][4] = King.new(:white)
    @board_state[0][5] = Bishop.new(:white)
    @board_state[0][6] = Knight.new(:white)
    @board_state[0][7] = Rook.new(:white)

    @board_state[1].map!.with_index { |square, index| Pawn.new(:white) }

    @board_state[7][0] = Rook.new(:black)
    @board_state[7][1] = Knight.new(:black)
    @board_state[7][2] = Bishop.new(:black)
    @board_state[7][3] = Queen.new(:black)
    @board_state[7][4] = King.new(:black)
    @board_state[7][5] = Bishop.new(:black)
    @board_state[7][6] = Knight.new(:black)
    @board_state[7][7] = Rook.new(:black)

    @board_state[6].map!.with_index { |square, index| Pawn.new(:black) }
  end
end
