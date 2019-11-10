require_relative 'player'
require_relative 'board'

# Stores game state and flow
class Game
  attr_reader :board, :player1, :player2, :current_player

  def initialize(player1, player2, first_player = nil)
    @player1 = Player.new(player1)
    @player2 = Player.new(player2)
    @current_player = find_player(first_player)
    @board = Board.new
  end

  def find_player(first_player)
    return [@player1, @player2].sample if first_player.nil?

    player = [@player1, @player2].select { |p| p.name == first_player }
    player[0]
  end

  # Add piece
  #   Repeat if piece can't be placed
  # Check win
  #   Current player wins if true
  # Switch current player

  # Check if there's a win at given space
  #  True if yes

  # Check if board is full
end
