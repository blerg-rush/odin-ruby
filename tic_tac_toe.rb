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


