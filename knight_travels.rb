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
    @knight = Knight.new
    @start = start
    @finish = finish
  end
end
