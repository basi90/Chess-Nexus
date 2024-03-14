class Pawn < Piece

  def initialize(color)
    super(color)
  end

  def to_s
    color == :white ? "♙" : "♟"
  end
end
