# Methods and attributes common to all pieces
class Piece
  attr_accessor :moved, :space
  attr_reader :color

  def initialize(color, space)
    @color = color.to_sym
    @space = space
    @moved = false
    @can_jump = false
  end

  def can_jump?
    @can_jump
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

# Knight-specific methods and attributes
class Knight < Piece
  def initialize(color, space)
    super
    @can_jump = true
  end

  def glyph
    return "\u2658" if @color == :white
    return "\u265E" if @color == :black
  end

  def moves
    [[-2, 1], [-1, 2], [1, 2], [2, 1], [-2, -1], [-1, -2], [1, -2], [2, -1]]
  end

  def captures
    moves
  end
end

# Bishop-specific methods and attributes
class Bishop < Piece
  def glyph
    return "\u2657" if @color == :white
    return "\u265D" if @color == :black
  end

  def moves
    move_list = []
    7.times do |index|
      move_list.concat([[-(index + 1), index + 1], [index + 1, index + 1],
                        [index + 1, -(index + 1)], [-(index + 1), -(index + 1)]])
    end
    move_list
  end

  def captures
    moves
  end
end

# Rook-specific methods and attributes
class Rook < Piece
  def glyph
    return "\u2656" if @color == :white
    return "\u265C" if @color == :black
  end

  def moves
    move_list = []
    7.times do |index|
      move_list.concat([[-(index + 1), 0], [0, index + 1],
                        [index + 1, 0], [0, -(index + 1)]])
    end
    move_list
  end

  def captures
    moves
  end
end
