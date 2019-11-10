require_relative 'game'
require 'colorize'

# Presents game to users
class ConnectFour
  attr_reader :game

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

  def initialize(player1, player2)
    @game = Game.new(player1, player2)
    @display = draw_display
  end

  def render_display
    @display = draw_display
    @display.each do |line|
      puts line.join
    end
  end

  def piece(player)
    return '  ' if player.nil?

    blank = '⬤ '
    player == 1 ? blank.colorize(:red) : blank.colorize(:yellow)
  end

  private

    def draw_display
      grid = [['  1  2  3  4  5  6  7 ']]
      13.times do |index|
        grid << draw_line(index)
      end
      grid
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
                  space = @game.check_space(5 - (row / 2), (index / 2))
                  piece(space)
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

puts "What is player 1's name?"
player1 = gets.chomp
puts "what is player 2's name?"
player2 = gets.chomp
cf = ConnectFour.new(player1, player2)

until cf.game.over?
  system 'clear'
  cf.render_display
  puts
  puts "#{cf.game.current_player.name}'s turn."
  puts
  puts "Place your #{cf.piece(cf.game.current_player.id)} in which column?"
  column = gets.to_i - 1
  if cf.game.play_piece(column)
    system 'clear'
    cf.render_display
    return puts "#{cf.game.current_player.name} wins!"
  end
  puts 'The board is full. Nobody wins. =(' if cf.game.over?
end
