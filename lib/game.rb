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


    def convert_to_index(file_rank)
      file = file_rank[0].upcase
      rank = file_rank[1]
      return nil unless ('A'..'H').include?(file) && (1..8).include?(rank)

      col = %w[A B C D E F G H].index(file_rank[0].upcase)
      row = file_rank[1] - 1

      [row, col]
    end

    def render_display
      @display.render(@message)
    end

    def mine?(position)
      piece = @chessboard.piece_at(position)
      return false if piece.nil?
      piece.color == @current_player
    end
end

game = Game.new
game.render_display
