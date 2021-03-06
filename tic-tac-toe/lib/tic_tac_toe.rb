# frozen_string_literal: true

# Universal Player methods
class Player
  attr_accessor :name
  attr_reader :glyph

  def initialize(name, glyph)
    self.name = name
    @glyph = glyph
  end
end

# Contains methods for creating, setting spaces, and checking state
class Board
  def initialize
    @state = [[" ", " ", " "],
              [" ", " ", " "],
              [" ", " ", " "]].freeze
  end

  def state
    state_string = ""
    @state.each do |row|
      state_string += "#{row.join}\n"
    end
    state_string.tr(" ", "⛶")
  end

  def get_space(row, column)
    state[row - 1][column - 1]
  rescue StandardError
    puts "#{row},#{column} is not a valid space!"
  end

  # returns false if it fails
  def set_space(space, glyph)
    row = space[0].to_i
    column = space[1].to_i
    success = false
    if @state[row - 1][column - 1] == " "
      @state[row - 1][column - 1] = glyph
      success = true
    end
    success
  end

  def full?
    full = true
    @state.each do |board_row|
      full = false if board_row.any? { |board_space| board_space == " " }
    end
    full
  end

  def win?(glyph)
    horizontal_line?(glyph) ||
      vertical_line?(glyph) ||
      diagonal_line?(glyph)
  end

  private

  def horizontal_line?(glyph)
    line = false
    @state.each do |board_row|
      line = true if board_row.all? { |board_space| board_space == glyph }
    end
    line
  end

  def vertical_line?(glyph)
    line = false
    @state.transpose.each do |board_row|
      line = true if board_row.all? { |board_space| board_space == glyph }
    end
    line
  end

  def diagonal_line?(glyph)
    return true if @state[0][0] == glyph &&
                   @state[1][1] == glyph &&
                   @state[2][2] == glyph

    return true if @state[0][2] == glyph &&
                   @state[1][1] == glyph &&
                   @state[2][0] == glyph

    false
  end
end

# Contains methods and variables related to the game flow
class Game
  def initialize(player_x = "", player_o = "", last_winner = nil)
    @player_x = Player.new(player_x, "X")
    @player_o = Player.new(player_o, "O")
    @last_winner = last_winner
    @board = Board.new
  end

  def play
    setup if @last_winner.nil?
    @current_player = first
    puts "#{@current_player.name} goes first!"
    turn(@current_player) until @board.full?     ||
                                @board.win?("X") ||
                                @board.win?("O")
    end_game
  end

  private

  attr_writer :player_x, :player_o

  def coin_toss
    rand(2) == 1 ? "X" : "O"
  end

  def first
    if @last_winner.nil?
      coin_toss == "X" ? @player_x : @player_o
    else
      @last_winner == "X" ? @player_o : @player_x
    end
  end

  def display_board
    puts @board.state
  end

  def create_player(glyph)
    puts "Who will play as #{glyph}?"
    @player_x = Player.new(gets.chomp, "X") if glyph == "X"
    @player_o = Player.new(gets.chomp, "O") if glyph == "O"
  end

  def setup
    create_player("X")
    create_player("O")
  end

  def turn(player)
    display_board
    success = false
    until success
      begin
        puts "Where would #{player.name} like to place their #{player.glyph}? (row,column)"
        space = gets.chomp.split(",")
        raise "Goof!" unless space.size == 2              &&
                             %w[1 2 3].include?(space[0]) &&
                             %w[1 2 3].include?(space[1]) # Fix hardcoded excepton later
      rescue StandardError
        puts "Invalid input."
        retry
      end
      success = @board.set_space(space, player.glyph)
      puts "That space is taken!" unless success
    end
    @current_player = @player_x if player == @player_o
    @current_player = @player_o if player == @player_x
  end

  def end_game
    display_board
    if @board.win?("X")
      @last_winner = "X"
      puts "#{@player_x.name} wins!"
    elsif @board.win?("O")
      @last_winner = "O"
      puts "#{@player_o.name} wins!"
    else
      puts "It's a draw..."
    end
    puts "Play again? (y/n)"
    if gets.chomp == "y"
      game = Game.new(@player_x.name, @player_o.name, @last_winner)
      game.play
    else
      puts "Goodbye!"
    end
  end
end
