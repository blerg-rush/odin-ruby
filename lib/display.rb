require 'colorize'

# Standard tiles
BORDER = '  '.on_light_blue
FILE = [' A'.black.on_light_blue,
        ' B'.black.on_light_blue,
        ' C'.black.on_light_blue,
        ' D'.black.on_light_blue,
        ' E'.black.on_light_blue,
        ' F'.black.on_light_blue,
        ' G'.black.on_light_blue,
        ' H'.black.on_light_blue].freeze
RANK = ['8 '.black.on_light_blue,
        '7 '.black.on_light_blue,
        '6 '.black.on_light_blue,
        '5 '.black.on_light_blue,
        '4 '.black.on_light_blue,
        '3 '.black.on_light_blue,
        '2 '.black.on_light_blue,
        '1 '.black.on_light_blue].freeze
WHT_TL = '  '.on_white
BLK_TL = '  '.on_black

# Outlined pieces
O_BLK = { pawn: "\u2659 ".white.on_black,
          knight: "\u2658 ".white.on_black,
          bishop: "\u2657 ".white.on_black,
          rook: "\u2656 ".white.on_black,
          queen: "\u2655 ".white.on_black,
          king: "\u2654 ".white.on_black }.freeze
O_WHT = { pawn: "\u2659 ".black.on_white,
          knight: "\u2658 ".black.on_white,
          bishop: "\u2657 ".black.on_white,
          rook: "\u2656 ".black.on_white,
          queen: "\u2655 ".black.on_white,
          king: "\u2654 ".black.on_white }.freeze

# Solid pieces
S_BLK = { pawn: "\u265F ".black.on_white,
          knight: "\u265E ".black.on_white,
          bishop: "\u265D ".black.on_white,
          rook: "\u265C ".black.on_white,
          queen: "\u265B ".black.on_white,
          king: "\u265A ".black.on_white }.freeze
S_WHT = { pawn: "\u265F ".white.on_black,
          knight: "\u265E ".white.on_black,
          bishop: "\u265D ".white.on_black,
          rook: "\u265C ".white.on_black,
          queen: "\u265B ".white.on_black,
          king: "\u265A ".white.on_black }.freeze

# Handles visual elements
class Display
  def initialize(board)
    @board = board
  end

  def render
    Gem.win_platform? ? (system 'cls') : (system 'clear')
    puts BORDER + FILE.join + BORDER
    @board.reverse.each_with_index do |row, row_index|
      line = [RANK[row_index]]
      row.each_with_index do |piece, col_index|
        line << if row_index.odd? == col_index.odd?
                  (piece.nil? ? BLK_TL : paint(piece, :black))
                else
                  (piece.nil? ? WHT_TL : paint(piece, :white))
                end
      end
      puts line.join + BORDER
    end
    puts BORDER * 10
  end

  private

    def paint(piece, background)
      if background == :black
        piece.color == :black ? O_BLK[piece.type] : S_WHT[piece.type]
      else
        piece.color == :black ? S_BLK[piece.type] : O_WHT[piece.type]
      end
    end
end
