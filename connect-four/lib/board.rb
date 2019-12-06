# Stores and processes board level and logic
class Board
  attr_reader :grid

  def initialize
    @width = 7
    @height = 6
    @grid = Array.new(@height) { Array.new(@width) }
  end

  def add(column, player)
    return nil unless column.between?(0, @width - 1)

    @grid.each_index do |row|
      next unless @grid[row][column].nil?

      @grid[row][column] = player
      return [row, column]
    end
    nil
  end

  def full?
    @grid[@height - 1].each do |column|
      return false if column.nil?
    end
    true
  end

  def line?(row, column)
    horizontal_line?(row, column) || vertical_line?(row, column) ||
      diagonal_left_line?(row, column) || diagonal_right_line?(row, column)
  end

  private

    def horizontal_line?(row, column)
      left_matches(row, column) + right_matches(row, column) >= 3
    end

    def vertical_line?(row, column)
      false if row < 3

      line = @grid.transpose[column][0..row]
      matching_value = @grid[row][column]
      matches = 0
      line.reverse.each do |space|
        break unless space == matching_value

        matches += 1
      end
      matches >= 4
    end

    def left_matches(row, column, line = nil)
      line = line.nil? ? @grid[row][0..column] : line[0..column]
      matching_value = line.last
      matches = -1
      line.reverse.each do |space|
        break unless space == matching_value

        matches += 1
      end
      matches
    end

    def right_matches(row, column, line = nil)
      line = line.nil? ? @grid[row][column..-1] : line[column..-1]
      matching_value = line.first
      matches = -1
      line.each do |space|
        break unless space == matching_value

        matches += 1
      end
      matches
    end

    def diagonal_left_line?(row, column)
      shifted_column = column + @height - 1 - row
      shifted_grid = skew_left
      shifted_line = shifted_grid.transpose[shifted_column]
      left_matches(shifted_column, row, shifted_line) +
        right_matches(shifted_column, row, shifted_line) >= 3
    end

    def diagonal_right_line?(row, column)
      shifted_column = column + row
      shifted_grid = skew_right
      shifted_line = shifted_grid.transpose[shifted_column]
      left_matches(shifted_column, row, shifted_line) +
        right_matches(shifted_column, row, shifted_line) >= 3
    end

    def skew_left
      @grid.map.with_index do |row, index|
        shifted_row = row.dup
        (@height - 1 - index).times { shifted_row.unshift(nil) }
        shifted_row + Array.new(index, nil)
      end
    end

    def skew_right
      @grid.map.with_index do |row, index|
        shifted_row = row.dup
        index.times { shifted_row.unshift(nil) }
        shifted_row + Array.new(@height - 1 - index, nil)
      end
    end
end
