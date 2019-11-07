require_relative 'player'
require_relative 'board'

# Stores game state and flow
class Game
  attr_reader :board, :player1, :player2
  def initialize(player1, player2)
    @player1 = Player.new(player1)
    @player2 = Player.new(player2)
    @board = Board.new
  end
end
