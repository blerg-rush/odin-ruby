# frozen_string_literal: true

class Chessboard
  class Knight
    attr_accessor :pos
    attr_reader :moves
    def initialize(pos = nil)
      @moves = [[-2, 1], [-1, 2], [1, 2], [2, 1],
                [-2, -1], [-1, -2], [1, -2], [2 - 1]]
      @pos = pos
    end
  end

  attr_accessor :start, :finish

  def initialize(start, finish)
    @knight = Knight.new(start)
    @start = start
    @finish = finish
  end

  def valid?(pos, move)
    return false unless @knight.moves.include? move

    (pos[0] + move[0]).between?(0, 7) && (pos[1] + move[1]).between?(0, 7)
  end
end
