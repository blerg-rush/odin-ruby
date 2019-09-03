# frozen_string_literal: true

# Universal Player methods
class Player
  attr_accessor :name
  attr_reader :piece

  def initialize(name, piece)
    self.name = name
    @piece = piece
  end
end

# Contains methods for creating, setting squares, and checking state
class Board
  attr_reader :state

  def initialize
    @state = [["", "", ""],
              ["", "", ""],
              ["", "", ""]].freeze
  end

  def get_square(row, column)
    state[row - 1][column - 1]
  rescue StandardError
    puts "#{row},#{column} is not a valid space!"
  end

  def set_square(row, column, glyph) # glyph = X or O, depending on player 
    @state[row - 1][column - 1] = glyph
  rescue StandardError
    puts "#{row},#{column} is not a valid space!"
  end
end
