class King < Piece
  include Tableless

  def initialize(color)
    super(color)
    @checked = false
    @moved = false
  end
end
