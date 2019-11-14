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

  def move_piece(position, target_space)
    piece = piece_at(position)
    return nil if piece.is_a?(King) && check?(target_space)

    target_piece = piece_at(target_space)
    move = move_between(position, target_space)

    if piece.captures.include?(move) && target_piece.color != piece.color
      capture_to(position, target_space)
    elsif piece.moves.inlude?(move) && target_piece.nil?
      move_to(position, target_space)
    end

    nil
  end

  def piece_at(position)
    @board[position[0]][position[1]]
  end

  private

    def king_position(color)
      @board.each_with_index do |row, row_index|
        row.each_with_index do |piece, col_index|
          if piece.is_a?(King) && piece.color == color
            return [row_index, col_index]
          end
        end
      end
    end

    def check?(position)
      @board.each_with_index do |row, row_index|
        row.each_with_index do |piece, col_index|
          next if piece.nil?

          return can_capture?(piece, [row_index, col_index], position)
        end
      end
      false
    end

    def can_capture?(piece, position, target_space)
      target_piece = piece_at(target_space)
      unless target_piece.nil? ||
             target_piece.color != piece.color ||
             piece.captures.include?(move_between(position, target_space))
        return piece.can_jump? || path_open?(piece, position, target_space)
      end

      false
    end

    def path_open?(piece, position, target_space)
      return true if piece.can_jump?

      next_position = position.dup
      step = one_step(position, target_space)
      step_count = move_between(position, target_space).max - 1

      step_count.times do
        next_position = move_by(next_position, step)
        return false unless piece_at(next_position).nil?
      end

      true
    end

    def one_step(position, target_space)
      move = [0, 0]
      2.times do |index|
        if (target_space[index] - position[index]).positive?
          move[index] = 1
        elsif (target_space[index] - position[index]).negative?
          move[index] = -1
        end
      end
      move
    end

    def move_between(position, target_space)
      [target_space[0] - position[0], target_space[1] - position[1]]
    end

    def move_by(position, move)
      [position[0] + move[0], position[1] + move[1]]
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
