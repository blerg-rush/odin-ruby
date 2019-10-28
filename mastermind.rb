# Internal game logic
class Game
  attr_accessor :spaces, :digits, :turns, :code

  def initialize(digits = 6, spaces = 4, turns = 12)
    @digits = digits
    @spaces = spaces
    @turns = turns
    @code = []
  end

  def randomize
    @spaces.times do
      @code << rand(1..@digits).to_s
    end
  end

  def assign(sequence)
    @code = sequence.split("")
  end

  def try(guess)
    digits = guess.split("")
    unmatched = @code.dup
    result = []
    result << perfect_digits(digits, unmatched)
    result << misplaced_digits(digits.compact, unmatched.compact)
    result.join
  end

  def perfect_digits(guess, code)
    result = []
    guess.each_with_index do |digit, index|
      next if digit != code[index]

      result << "P"
      code[index] = nil
      guess[index] = nil
    end
    result.join
  end

  def misplaced_digits(guess, code)
    result = []
    guess.each do |digit|
      code.each_index do |index|
        next if digit != code[index]

        result << "M"
        code[index] = nil
        break
      end
    end
    result.join
  end

  def win?(guess)
    guess == @code.join
  end

  def over?(turn)
    turn >= @turns
  end

  def valid?(guess)
    guess.length == @spaces && guess.split("").max.to_i.between?(1, @digits)
  end
end

# Computer player logic
class AI
  def initialize(game, style = :basic)
    @game = game
    @guesses = {}
    @style = style
  end

  def guess
    case @style
    when :basic
      basic_guess
    when :educated
      educated_guess
    when :intelligent
      intelligent_guess
    when :perfect
      perfect_guess
    end
  end

  # Records the player's response to a guess (string)
  def record(response)
    @guesses[@guesses.keys.last] = response
  end

  private

    # Only makes sure to not repeat guesses
    def basic_guess
      guess = ""
      loop do
        guess = ""
        @game.spaces.times do
          guess += rand(1..@game.digits).to_s
        end
        break unless @guesses.key? guess
      end
      @guesses[guess] = nil
      guess
    end

    # Tries numbers that could be perfect digits
    def educated_guess; end

    # Incorporates imperfect digits
    def intelligent_guess; end

    # Uses perfect strategy
    def perfect_guess; end
end

# Game interface
class MasterMind
  ORDINAL = %w[first second third fourth fifth sixth seventh eighth ninth
               tenth eleventh twelfth thirteenth fourteenth fifteenth
               sixteenth seventeenth eighteenth nineteenth twentieth].freeze

  def initialize
    @width = 80
    @game = Game.new
    @guess = nil
    @turn = 0
    @quit = false
    @errors = []
  end

  def introduction
    puts
    say "Welcome to MasterMind!"
    puts
    say "I'm going to choose a #{@game.spaces}-number sequence and you"
    say "have #{@game.turns} turns to guess what that sequence is."
    puts
    say "Each number will be between 1 and #{@game.digits}"
    puts
    say "I'll give you a hint if any of your numbers are correct:"
    say "1. For every number that's in the correct position, I'll give you a 'P'"
    say "2. For every correct number in the wrong position, I'll give you an 'M'"
    puts
    say "Just remember: P = perfect. M = misplaced."
    puts
    say "The same number may appear more than once, and each number in your"
    say "guess is worth one hint. My hints will not tell you anything about"
    say "the order of the numbers. For that, you'll have to use your head!"
    puts
  end

  def play_guesser
    @game.randomize
    say "I've chosen my sequence of numbers!"
    until @game.win?(@guess) || @game.over?(@turn)
      @turn += 1
      say "This is your last shot!" if @turn == @game.turns
      puts
      say "What is your #{ORDINAL[@turn - 1]} guess?"
      puts
      @guess = ""
      player_guess
      answer = @game.try(@guess)
      puts
      say "Not a single correct number. No hint for you!" if answer == ""
      say "Here is your hint: #{answer}" if answer != ""
      puts
      if @game.win?(@guess)
        say "Good lord, you've got it! It was indeed #{@game.code.join}!"
      elsif @game.over?(@turn)
        say "I'm afraid you're out of guesses. The answer was #{@game.code.join}!"
      end
    end
  end

  def player_guess
    until @game.valid?(@guess)
      print_errors if @errors.any?
      @guess = gets.chomp
      @errors << invalid_input unless @game.valid?(@guess)
    end
  end

  def play_picker
    @game.assign pick_sequence
    say "Wish me luck!"
    puts
    until @game.win?(@guess) || @game.over?(@turn)
      @turn += 1
      # Guess
      say "My #{ORDINAL[@turn - 1]} guess is #{@ai.guess}."
      puts

      # Respond (and check for cheating)
      puts "(hint?)"
      @ai.record(gets.chomp)

      # End message
      if @game.win?(@guess)
        say "Ahhah! The all-powerful computer wins again!"
      elsif @game.over?(@turn)
        say "Well, dang. You win!"
      end
    end
  end

  def pick_sequence
    until @game.valid?(@game.code)
      print_errors if @errors.any?
      puts
      say "What sequence of numbers will you set? (I won't peek!)"
      @game.code = gets.chomp
      @errors << invalid_input unless @game.valid?(@game.code)
    end
    @game.code
  end

  def start
    introduction
    play_guesser
    reset
  end

  def start_ai
    @ai = AI.new(@game)
    play_picker
  end

  def reset
    puts
    say "Would you like to play again? (y/n)"
    puts
    response = gets.chomp.downcase
    return say "Farewell! Do come again when you're feeling brainy!" if response != "y"

    @game = Game.new
    @guess = nil
    @turn = 0
    play_guesser
  end

  def invalid_input
    "#{@game.spaces} numbers exactly from 1 to #{@game.digits}, please"
  end

  def print_errors
    puts
    @errors.each do |error|
      say error
    end
    puts
    @errors.clear
  end

  private

    def say(message)
      puts message.center(@width, " ")
    end
end

game = MasterMind.new
game.start_ai
