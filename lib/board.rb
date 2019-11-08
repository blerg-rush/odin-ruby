# Stores and processes board level and logic
class Board
  attr_reader :grid

  def initialize
    # Columns nested inside rows
    @grid = Array.new(6) { Array.new(7) }
  end

  def add(row, player)
    return nil unless row.between?(0, 7)

    @grid[row].each do |column|
      if column.nil?
        @grid[row][column] = player
        return [row, column]
      end
    end
    nil
  end
end
