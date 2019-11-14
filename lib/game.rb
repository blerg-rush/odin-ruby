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

  def play
    render_display
  end

  private

    def turn
      pick_piece
      pick_move
      take_move
      switch_players
    end

    def pick_piece
      @message = "#{@current_player.capitalize}'s turn. Pick a piece."
      valid = false
      while valid.nil?
        render_display
        file_rank = gets.chomp
        position = convert_to_index(file_rank)
        if position.nil? || !mine?(position)
          @message = "'#{file_rank}' is not a valid space. Try again."
        else
          valid = true
        end
      end
    end

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
game.play
