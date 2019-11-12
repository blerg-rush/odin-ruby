# Methods and attributes common to all pieces
class Piece
  attr_accessor :space
  attr_reader :color
  attr_writer :moved

  def initialize(color, space)
    @color = color.to_sym
    @space = space
    @moved = false
  end

  def moved?
    @moved
  end
end
