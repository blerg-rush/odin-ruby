require_relative 'game'
require 'pry'

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

  def render_display
    draw_display
    @display.each do |line|
      puts line.join
    end
  end

  private

    def draw_display
      grid = [['  1  2  3  4  5  6  7 ']]
      13.times do |index|
        grid << draw_line(index)
      end
      grid
    end

    def piece(player)
      return '  ' if player.nil?

      player == 1 ? "\u1F534".encode('utf-8') : "\u1F7E1".encode('utf-8')
    end

    def draw_line(row)
      if row.zero?
        top_line
      elsif row == 12
        bottom_line
      elsif (row % 2).zero?
        middle_line
      else
        grid_line(row)
      end
    end

    def grid_line(row)
      line = []
      15.times do |index|
        line << if (index % 2).zero?
                  VERTI
                else
                  piece(@game.board.grid[6 - row][index / 2])
                end
      end
      line
    end

    def top_line
      line = []
      15.times do |index|
        line << if index.zero?
                  TOPLT
                elsif index == 14
                  TOPRT
                elsif (index % 2).zero?
                  TOPMD
                else
                  HORIZ
                end
      end
      line
    end

    def bottom_line
      line = []
      15.times do |index|
        line << if index.zero?
                  BOTLT
                elsif index == 14
                  BOTRT
                elsif (index % 2).zero?
                  BOTMD
                else
                  HORIZ
                end
      end
      line
    end

    def middle_line
      line = []
      15.times do |index|
        line << if index.zero?
                  MIDLT
                elsif index == 14
                  MIDRT
                elsif (index % 2).zero?
                  MIDMD
                else
                  HORIZ
                end
      end
      line
    end
end
