# Stores and processes board level and logic
class Board
  attr_reader :grid

  def initialize
    # Columns nested inside rows
    @grid = Array.new(6) { Array.new(7) }
  end

  def add(column, player)
    return nil unless column.between?(0, 6)

    @grid.each_index do |row|
      next unless @grid[row][column].nil?

      @grid[row][column] = player
      return [row, column]
    end
    nil
  end

  def full?
    @grid[5].each do |column|
      return false if column.nil?
    end
    true
  end
end
