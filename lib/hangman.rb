require 'pry'
require 'facets/string/word_wrap'
require 'msgpack'

# Handles internal game logic and state
class Game
  attr_reader :hint, :word

  WORDS = File.open('5desk.txt', 'r', &:read).split("\r\n")
              .select { |word| word.length.between?(5, 12) }

  def initialize(guesses = 6)
    @guesses = guesses
    @word = WORDS.sample.upcase
    @letters_guessed = []
    @hint = @word.gsub(/./, '_').split('')
  end

  # Expects a single letter, returns the current hint
  def guess(letter)
    letter = letter.upcase
    response = 'miss'
    return false if @letters_guessed.include? letter

    @letters_guessed << letter

    if @word.include? letter
      update_hint(letter)
      response = 'hit'
    end

    response
  end

  def update_hint(letter)
    @word.chars.each_with_index do |char, index|
      @hint[index] = letter if char == letter
    end
  end

  def misses
    @letters_guessed.count { |guess| !@word.include? guess }
  end

  def bad_letters
    @letters_guessed.reject { |guess| @word.include? guess }
  end

  def over?
    misses >= @guesses
  end

  def win?
    !@hint.include? '_'
  end
end

# Renders visualization of game state
class Display
  HEAD_PART = 'O'
  TORSO_PART = '|'
  LEFT_LIMB_PART = '/'
  RIGHT_LIMB_PART = '\\'

  # zero-indexed
  HEAD = { row: 2, col: 2 }.freeze
  TORSO = { row: 3, col: 2 }.freeze
  LEFT_ARM = { row: 3, col: 1 }.freeze
  RIGHT_ARM = { row: 3, col: 3 }.freeze
  LEFT_LEG = { row: 4, col: 1 }.freeze
  RIGHT_LEG = { row: 4, col: 3 }.freeze

  # Minimum width for 12-letter word: 33
  def initialize(failures = 0)
    @noose = File.open('noose.txt', 'r', &:read).split("\n")
    @width = 60
    @failures = failures
  end

  def add_part
    @failures += 1
    case @failures
    when 1
      @noose[HEAD[:row]][HEAD[:col]] = HEAD_PART
    when 2
      @noose[TORSO[:row]][TORSO[:col]] = TORSO_PART
    when 3
      @noose[LEFT_ARM[:row]][LEFT_ARM[:col]] = LEFT_LIMB_PART
    when 4
      @noose[RIGHT_ARM[:row]][RIGHT_ARM[:col]] = RIGHT_LIMB_PART
    when 5
      @noose[LEFT_LEG[:row]][LEFT_LEG[:col]] = LEFT_LIMB_PART
    when 6
      @noose[RIGHT_LEG[:row]][RIGHT_LEG[:col]] = RIGHT_LIMB_PART
    end
  end

  def align_left(string)
    string.ljust(12)
  end

  def align_center(string)
    string.center(@width - 12)
  end

  def hint(hint_array)
    hint_array.join(' ')
  end

  def misses(bad_letters)
    "Misses: #{bad_letters.join(' ')}"
  end

  def wrap_message(message)
    lines = message.word_wrap(@width - 12).split("\n")
    lines.unshift(' ') until lines.size >= 3
    lines[0..2]
  end

  # Options: :hints, :misses, :message
  # :message max length: (@width - 12) * 2
  def draw(opts = {})
    lines = []
    message = wrap_message(opts[:message] || '')
    lines[0] = align_left(@noose[0]) + align_center(hint(opts[:hints]))
    lines[1] = align_left(@noose[1]) + align_center(misses(opts[:misses]))
    lines[2] = @noose[2]
    lines[3] = align_left(@noose[3]) + align_center(message[0])
    lines[4] = align_left(@noose[4]) + align_center(message[1])
    lines[5] = align_left(@noose[5]) + align_center(message[2])
    puts lines
  end
end

# Handles user interaction with game flow
class Hangman
  def initialize
    @display = Display.new
    @game = Game.new
    @message = 'Guess a letter!'
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
  end

  def turn
    system 'clear'
    @display.draw(hints: @game.hint,
                  misses: @game.bad_letters,
                  message: @message)
    puts
    letter = gets.chomp
    unless letter.match(/^[a-zA-Z]$/)
      @message = "That doesn't look right. Try again."
      return
    end
    try(letter)
  end

  def select_slot
    # Ask which save slot to save/load

    # Return index of desired slot
  end

  def retrieve_saves
    # Deserialize save file

    # Return hash of save files {:slot, :DateTime, :hint, :misses, :data}
  end

  def display_saves
    # Iterate over and puts :slot, :DateTime, :hint, :misses of each save file
  end

  def pack_save(slot)
    # Create save hash {:slot, :DateTime, :hint, :misses}

    # Serialize game data

    # Add game data to save hash (:data)

    # Return save hash
  end

  def unpack_save(saves, slot)
    # Assign selected save file from saves hash

    # Deserialize game data from save[:data]

    # Return game data
  end

  def save
    # Deserialize save file if one exists

    # Display save slots

    # Select save slot

    # Serialize @game object

    # Add @game object to deserialized save file

    # Serialize and store save file

    # Continue?
  end

  def load
    # Deserialize save file if one exists

    # Display save slots

    # Select save slot

    # Load saved @game object
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
  end
end

hangman = Hangman.new
hangman.play
