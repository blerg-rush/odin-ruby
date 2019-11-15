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
    turn until over?
  end

  private

    def turn
      position = pick_piece
      move_from(position)
      switch_players
    end

    def over?
      false
    end

    def pick_piece
      @message = "#{@current_player.capitalize}'s turn. Pick a piece."
      valid = false
      until valid
        render_display
        file_rank = gets.chomp.upcase
        position = convert_to_index(file_rank)
        if position.nil? || !mine?(position)
          @message = "'#{file_rank}' is not a valid #{@current_player} piece. "\
                     'Try again.'
        elsif !@chessboard.can_move?(position)
          @message = "#{@current_player.capitalize} "\
                     "#{@chessboard.piece_at(position).type} "\
                     "at #{file_rank} can't move. Choose another."
        else
          valid = true
        end
      end
      position
    end

    def move_from(position)
      piece = @chessboard.piece_at(position)
      display_position = convert_to_file_rank(position)
      @message = "Move #{@current_player} #{piece.type} at "\
                 "#{display_position} to which space?"
      valid = false
      until valid
        render_display
        file_rank = gets.chomp.upcase
        target = convert_to_index(file_rank)
        if target.nil? || @chessboard.move_piece(position, target).nil?
          @message = "Can't move #{@current_player} #{piece.type} at "\
                     "#{display_position} to #{file_rank}. Try again."
        else
          valid = true
        end
      end
    end

    def switch_players
      @current_player = @current_player == :white ? :black : :white
    end

    def convert_to_index(file_rank)
      file = file_rank[0].upcase
      rank = file_rank[1].to_i
      return nil unless ('A'..'H').include?(file) && (1..8).include?(rank)

      col = %w[A B C D E F G H].index(file.upcase)
      row = rank - 1

      # binding.pry
      [row, col]
    end

    def convert_to_file_rank(position)
      rank = position[0] + 1
      file = %w[A B C D E F G H][position[1]]

      [file, rank].join
    end

    def game_status
      check = in_check?
      mate = checkmate?
      { check: check,
        checkmate: mate,
        captured_pieces: @chessboard.captured_pieces }
    end

    def render_display
      game_status
      @display.render(@message, game_status)
    end

    def mine?(position)
      piece = @chessboard.piece_at(position)
      return false if piece.nil?

      piece.color == @current_player
    end
end

game = Game.new
game.play
