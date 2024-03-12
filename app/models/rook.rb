class Rook < Piece
  include Tableless

  def initialize(color)
    super(color)
    @moved = false
  end
end
