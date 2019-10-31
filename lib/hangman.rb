require 'msgpack'
require 'date'
require_relative 'game'
require_relative 'display'
require_relative 'save_load'

# Handles user interaction with game flow
class Hangman
  include SaveLoad

  def initialize
    @display = Display.new
    @game = Game.new
    @message = 'Guess a letter!'
    create_savefile
  end

  def start
    puts 'Would you like to load an existing game?'
    response = gets
    load_game if response =~ /^y/i
    play
  end

  private

    def play
      turn until @game.over? || @game.win?
      system 'clear'
      @message = if @game.win?
                   "Thank you! You've saved me!"
                 else
                   "The word was #{@game.word}...\nYou jerk! Now I'm dead!"
                 end
      render_board
    end

    def turn
      system 'clear'
      render_board
      letter = gets.chomp
      save_game if letter =~ /^save/i
      unless letter =~ /^[a-zA-Z]$/
        @message = "That doesn't look right. Try again."
        return
      end
      try(letter)
    end

    def try(letter)
      case @game.guess(letter)
      when false
        @message = 'You guessed that already! Try again.'
      when 'hit'
        @message = 'Whew! Keep going!'
      when 'miss'
        @display.add_part
        @message = "Ohhhh, I don't like this."
      end
      @message += "\n(type 'save' to save the game)"
    end

    def render_board
      @display.draw(hints: @game.hint,
                    misses: @game.bad_letters,
                    message: @message)
      puts
    end

    def save_game
      saves = read_savefile
      slot = select_slot(saves, 'save')
      save = pack_save(@game)
      saves[slot] = save
      write_savefile(saves)
      # Continue?
      puts 'Saved successfully. Exiting game...'
      exit
    end

    def load_game
      saves = read_savefile
      slot = select_slot(saves, 'load')
      return if saves[slot]['data'].nil?

      @game.data = unpack_save(saves[slot])
      @display = Display.new
      @display.load_parts(@game.misses)
    end
end
