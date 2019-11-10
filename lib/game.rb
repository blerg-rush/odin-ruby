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

  def play_piece(column)
    player = @current_player == @player1 ? 1 : 2
    space = @board.add(column, player)
    return nil if space.nil?

    return true if @board.line?(*space)

    @current_player = @current_player == @player1 ? @player2 : @player1
    false
  end
end
