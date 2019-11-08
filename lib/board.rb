# Stores and processes board level and logic
class Board
  attr_reader :grid

  def initialize
    # Columns nested inside rows
    @grid = Array.new(6) { Array.new(7) }
  end
end
