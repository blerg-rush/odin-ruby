require 'msgpack'
require 'date'
require_relative 'game'
require_relative 'display'

# Handles user interaction with game flow
class Hangman
  def initialize
    @display = Display.new
    @game = Game.new
    @message = 'Guess a letter!'
    create_savefile
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

  def turn
    system 'clear'
    @display.draw(hints: @game.hint,
                  misses: @game.bad_letters,
                  message: @message)
    puts
    letter = gets.chomp
    save_game if letter =~ /^save/i
    unless letter =~ /^[a-zA-Z]$/
      @message = "That doesn't look right. Try again."
      return
    end
    try(letter)
  end

  def select_slot(saves, reason)
    slot = nil
    until slot&.between?(0, 2)
      system 'clear'
      display_saves(saves)
      puts
      puts "Invalid entry\n" if slot
      puts "Which file would you like to #{reason}?"
      slot = gets.to_i - 1
    end

    slot
  end

  def create_savefile
    return if File.exist?('savefile')

    saves = []
    3.times do
      saves << { 'created' => '',
                 'hint' => '',
                 'misses' => '',
                 'data' => nil }
    end
    write_savefile(saves)
  end

  # Expects array of save hashes with serialized data: @game
  def write_savefile(saves)
    File.open('savefile', 'w') { |f| f.write saves.to_msgpack }
  end

  # Returns an array of save hashes with serialized data: @game
  def read_savefile
    file = MessagePack.unpack(File.open('savefile', 'r', &:read))
    file
  end

  # Expects array of save hashes with serialized data: @game
  def display_saves(saves)
    saves.each_with_index do |save, index|
      puts "#{index + 1}) Created: #{save['created']}"
      puts "   Hint: #{save['hint']}"
      puts "   Misses: #{save['misses']}"
      puts
    end
  end

  def pack_save
    save = { 'created' => DateTime.now.strftime('%F %H:%M'),
             'hint' => @game.hint,
             'misses' => @game.bad_letters }

    save['data'] = @game.data.to_msgpack

    save
  end

  # Expects a save hash with serialized data: @game
  def unpack_save(save)
    MessagePack.unpack(save['data']) unless save['data'].nil?
  end

  def save_game
    saves = read_savefile
    slot = select_slot(saves, 'save')
    save = pack_save
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

  def play
    turn until @game.over? || @game.win?
    system 'clear'
    @message = if @game.win?
                 "Thank you! You've saved me!"
               else
                 "The word was #{@game.word}...\nYou jerk! Now I'm dead!"
               end
    @display.draw(hints: @game.hint,
                  misses: @game.bad_letters,
                  message: @message)
    puts
  end

  def start
    puts 'Would you like to load an existing game?'
    response = gets
    load_game if response =~ /^y/i
    play
  end
end

hangman = Hangman.new
hangman.start
