class Rook < Piece
  include Tableless

  def initialize(color)
    super(color)
    @moved = false
  end

  def to_s
    color == :white ? "♖" : "♜"
  end
end
