# Methods and attributes common to all pieces
class Piece
  attr_accessor :moved, :space
  attr_reader :color

  def initialize(color, space)
    @color = color.to_sym
    @space = space
    @moved = false
  end

  def moved?
    @moved
  end
end

# Pawn-specific methods and attributes
class Pawn < Piece
  def glyph
    return "\u2659" if @color == :white
    return "\u265F" if @color == :black
  end
end
