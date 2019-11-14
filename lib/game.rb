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
      position = pick_piece
      move_from(position)
      switch_players
    end

    def pick_piece
      @message = "#{@current_player.capitalize}'s turn. Pick a piece."
      valid = false
      until valid
        render_display
        file_rank = gets.chomp
        position = convert_to_index(file_rank)
        if position.nil? || !mine?(position)
          @message = "'#{file_rank}' is not a valid piece. Try again."
        else
          valid = true
        end
      end
      position
    end

    def move_from(position)
      piece = @chessboard.piece_at(position)
      display_position = convert_to_file_rank(position)
      @message = "Move #{@current_player} #{piece} at "\
                 "#{display_position} to which space?"
      valid = false
      until valid
        render_display
        file_rank = gets.chomp
        target = convert_to_index(file_rank)
        if target.nil? || @chessboard.move_piece(position, target).nil?
          @message = "Can't move #{@current_player} #{piece} at "\
                     "#{display_position} to #{file_rank}. Try again."
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

    def convert_to_file_rank(position)
      rank = position[0] + 1
      file = %w[A B C D E F G H][position[1]]

      [file, rank]
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
