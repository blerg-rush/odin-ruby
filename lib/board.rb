# Stores and processes board level and logic
class Board
  attr_reader :grid

  def initialize
    # Columns nested inside rows
    @grid = Array.new(7) { Array.new(6) }
  end
end
