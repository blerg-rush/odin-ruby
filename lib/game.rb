require_relative 'player'
require_relative 'board'

# Stores game state and flow
class Game
  attr_reader :board, :player1, :player2, :current_player

  def initialize(player1, player2, first_player = nil)
    @player1 = Player.new(player1)
    @player2 = Player.new(player2)
    @current_player = pick_first_player(first_player)
    @board = Board.new
  end

  def pick_first_player(first_player)
    return [@player1, @player2].sample if first_player.nil?

    [@player1, @player2].select { |player| player.name == first_player }
  end

end
