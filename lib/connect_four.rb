require_relative 'game'

# Presents game to users
class ConnectFour
  HORIZ = "\u2550\u2550".encode('utf-8')
  VERTI = "\u2551".encode('utf-8')
  TOPLT = "\u2554".encode('utf-8')
  TOPMD = "\u2566".encode('utf-8')
  TOPRT = "\u2557".encode('utf-8')
  MIDLT = "\u2560".encode('utf-8')
  MIDMD = "\u256C".encode('utf-8')
  MIDRT = "\u2563".encode('utf-8')
  BOTLT = "\u255A".encode('utf-8')
  BOTMD = "\u2569".encode('utf-8')
  BOTRT = "\u255D".encode('utf-8')

  def initialize
    @game = Game.new('Foo', 'Bar')
    @display = draw_display
  end
  end
end
end
