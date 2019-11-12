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

  def moves
    if @color == :white
      move_list = [[0, 1]]
      move_list << [0, 2] unless moved?
    else
      move_list = [[0, -1]]
      move_list << [0, -2] unless moved?
    end
    move_list
  end

  def captures
    if @color == :white
      [[-1, 1], [1, 1]]
    else
      [[-1, -1], [1, -1]]
    end
  end
end
