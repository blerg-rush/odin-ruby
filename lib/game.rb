require_relative 'chessboard'
require_relative 'display'

# Contains user interface for chess game
class Game
  def initialize
    @chessboard = Chessboard.new
    @display = Display.new(@chessboard.board)
    @current_player = :white
    @message = ''
  end

  def render_display
    @display.render
  end

  private


    def render_display
      @display.render(@message)
    end

    def mine?(position)
      @chessboard.piece_at(position).color == @current_player
    end
end

game = Game.new
game.render_display
