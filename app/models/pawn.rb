class Pawn < Piece
  include Tableless

  def initialize(color)
    super(color)
  end
end
