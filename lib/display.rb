require 'colorize'

# Standard tiles
BORDER = '  '.colorize.on_light_blue
FILE_A = ' A'.colorize.black.on_light_blue
FILE_B = ' B'.colorize.black.on_light_blue
FILE_C = ' C'.colorize.black.on_light_blue
FILE_D = ' D'.colorize.black.on_light_blue
FILE_E = ' E'.colorize.black.on_light_blue
FILE_F = ' F'.colorize.black.on_light_blue
FILE_G = ' G'.colorize.black.on_light_blue
FILE_H = ' H'.colorize.black.on_light_blue
RANK_1 = '1 '.colorize.black.on_light_blue
RANK_2 = '2 '.colorize.black.on_light_blue
RANK_3 = '3 '.colorize.black.on_light_blue
RANK_4 = '4 '.colorize.black.on_light_blue
RANK_5 = '5 '.colorize.black.on_light_blue
RANK_6 = '6 '.colorize.black.on_light_blue
RANK_7 = '7 '.colorize.black.on_light_blue
RANK_8 = '8 '.colorize.black.on_light_blue
WHT_TL = '  '.colorize.on_white
BLK_TL = '  '.colorize.on_black

# Outlined pieces (Pawn, kNight, Bishop, Rook, Queen, King)
OBLK_P = "\u2659 ".colorize.white.on_black
OBLK_N = "\u2658 ".colorize.white.on_black
OBLK_B = "\u2657 ".colorize.white.on_black
OBLK_R = "\u2656 ".colorize.white.on_black
OBLK_Q = "\u2655 ".colorize.white.on_black
OBLK_K = "\u2654 ".colorize.white.on_black
OWHT_P = "\u2659 ".colorize.black.on_white
OWHT_N = "\u2658 ".colorize.black.on_white
OWHT_B = "\u2657 ".colorize.black.on_white
OWHT_R = "\u2656 ".colorize.black.on_white
OWHT_Q = "\u2655 ".colorize.black.on_white
OWHT_K = "\u2654 ".colorize.black.on_white

# Solid pieces (Pawn, kNight, Bishop, Rook, Queen, King)
SBLK_P = "u\265F ".colorize.black.on_white
SBLK_N = "u\265E ".colorize.black.on_white
SBLK_B = "u\265D ".colorize.black.on_white
SBLK_R = "u\265C ".colorize.black.on_white
SBLK_Q = "u\265B ".colorize.black.on_white
SBLK_K = "u\265A ".colorize.black.on_white
SWHT_P = "u\265F ".colorize.white.on_black
SWHT_N = "u\265E ".colorize.white.on_black
SWHT_B = "u\265D ".colorize.white.on_black
SWHT_R = "u\265C ".colorize.white.on_black
SWHT_Q = "u\265B ".colorize.white.on_black
SWHT_K = "u\265A ".colorize.white.on_black

# Handles visual elements
class Display
  def initialize(board)
    @board = board
  end
end
