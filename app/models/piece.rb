class Piece
  include Tableless

  attr_accessor :square, :pinned, :color

  validates :color, presence: true

  def initialize(color)
    @color = color
    @pinned = false
    @square = nil
  end
end
