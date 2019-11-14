require_relative 'chessboard'
require_relative 'display'

# Contains user interface for chess game
class Game
  def initialize
    @chessboard = Chessboard.new
    @display = Display.new(@chessboard.board)
  end

  def render_display
    @display.update(@chessboard.board)
    @display.render
  end
end

game = Game.new
