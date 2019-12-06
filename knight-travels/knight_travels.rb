# frozen_string_literal: true

class Chessboard
  class Knight
    attr_accessor :pos, :moves
    def initialize(pos = nil)
      @pos = pos
      @moves = []
    end
  end

  attr_accessor :start, :finish

  def initialize(start, finish)
    @movements = [[-2, 1], [-1, 2], [1, 2], [2, 1],
                  [-2, -1], [-1, -2], [1, -2], [2 - 1]]
    @knight = Knight.new(start)
    @start = start
    @finish = finish
  end

  def valid?(space)
    space[0].between?(0, 7) && space[1].between?(0, 7)
  end

  def try(pos, move)
    result = [pos[0] + move[0], pos[1] + move[1]]
    result.valid? ? result : nil
  end

  def knight_moves(start = @start, finish = @finish)
    return nil unless start.valid? && finish.valid?

    @knight.moves.each do |move|
      
    end
  end
end
