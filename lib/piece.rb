# Methods and attributes common to all pieces
class Piece
  attr_accessor :moved
  attr_reader :color

  def initialize(color)
    @color = color.to_sym
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
  def glyph(type)
    return "\u2659" if type == :transparent
    return "\u265F" if type == :solid
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
  def initialize(color)
    super
    @can_jump = true
  end

  def glyph(type)
    return "\u2658" if type == :transparent
    return "\u265E" if type == :solid
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
  def glyph(type)
    return "\u2657" if type == :transparent
    return "\u265D" if type == :solid
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
  def glyph(type)
    return "\u2656" if type == :transparent
    return "\u265C" if type == :solid
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

# Queen-specific methods and attributes
class Queen < Piece
  def glyph(type)
    return "\u2655" if type == :transparent
    return "\u265B" if type == :solid
  end

  def moves
    move_list = []
    7.times do |index|
      move_list.concat([[-(index + 1), 0], [-(index + 1), index + 1],
                        [0, index + 1], [index + 1, index + 1],
                        [index + 1, 0], [index + 1, -(index + 1)],
                        [0, -(index + 1)], [-(index + 1), -(index + 1)]])
    end
    move_list
  end

  def captures
    moves
  end
end

# King-specific methods and attributes
class King < Piece
  def glyph(type)
    return "\u2654" if type == :transparent
    return "\u265A" if type == :solid
  end

  def moves
    move_list = [[-1, 0], [-1, 1], [0, 1], [1, 1],
                 [1, 0], [1, -1], [0, -1], [-1, -1]]
    move_list.concat([[-2, 0], [2, 0]]) unless moved?
    move_list
  end

  def captures
    moves
  end
end
