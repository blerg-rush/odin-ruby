require_relative 'piece'

# Methods and attributes regarding the state of the chessboard
class Board
  EMPTY_BOARD = Array.new(8) { Array.new(8, nil) }

  def initialize
    @board = EMPTY_BOARD.dup
    @last_move = {}
    @captured_pieces = {}
    add_pieces
  end

  private

    def check?(position)
      @board.each_with_index do |row, row_index|
        row.each_with_index do |piece, col_index|
          next if piece.nil?

          return true if can_attack?(piece, [row_index, col_index], position)
        end
      end
      false
    end

    def add_pieces
      add_kings
      add_queens
      add_rooks
      add_bishops
      add_knights
      add_pawns
    end

    def add_kings
      @board[0][4] = King.new(:white)
      @board[7][4] = King.new(:black)
    end

    def add_queens
      @board[0][3] = Queen.new(:white)
      @board[7][3] = Queen.new(:black)
    end

    def add_rooks
      @board[0][0] = Rook.new(:white)
      @board[0][7] = Rook.new(:white)
      @board[7][0] = Rook.new(:black)
      @board[7][7] = Rook.new(:black)
    end

    def add_bishops
      @board[0][2] = Bishop.new(:white)
      @board[0][5] = Bishop.new(:white)
      @board[7][2] = Bishop.new(:black)
      @board[7][5] = Bishop.new(:black)
    end

    def add_knights
      @board[0][1] = Knight.new(:white)
      @board[0][6] = Knight.new(:white)
      @board[7][1] = Knight.new(:black)
      @board[7][6] = Knight.new(:black)
    end

    def add_pawns
      @board[1] = Array.new(8, Pawn.new(:white))
      @board[6] = Array.new(8, Pawn.new(:black))
    end
end
