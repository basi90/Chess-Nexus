class King < Piece

  def initialize(color)
    super(color)
    @checked = false
    @moved = false
  end

  def to_s
    color == :white ? "♔" : "♚"
  end
end
