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

  def assign(code)
    @code = code.split("")
  end

  def try(guess)
    digits = guess.split("")
    unmatched = @code.dup
    result = []
    result << perfect_digits(digits, unmatched)
    result << misplaced_digits(digits, unmatched)
    result.join
  end

  def perfect_digits(guess, code)
    result = []
    guess.each_with_index do |digit, index|
      next if digit != code[index]

      result << "P"
      code[index] = nil
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
    guess.length == code.length && guess.split("").max.to_i.between?(1, @digits)
  end
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
    puts "Welcome to MasterMind!".center(@width, " ")
    puts
    puts "I'm going to choose a #{@game.spaces}-number sequence and you".center(@width, " ")
    puts "have #{@game.turns} turns to guess what that sequence is.".center(@width, " ")
    puts
    puts "Each number will be between 1 and #{@game.digits}".center(@width, " ")
    puts
    puts "I'll give you a hint if any of your numbers are correct:".center(@width," ")
    puts "1. For every number that's in the correct position, I'll give you a 'P'".center(@width, " ")
    puts "2. For every correct number in the wrong position, I'll give you an 'M'".center(@width, " ")
    puts
    puts "Just remember: P = perfect. M = misplaced.".center(@width, " ")
    puts
    puts "The same number may appear more than once, and each number in your".center(@width, " ")
    puts "guess is worth one hint. My hints will not tell you anything about".center(@width, " ")
    puts "the order of the numbers. For that, you'll have to use your head!".center(@width, " ")
    puts "".center(@width, " ")
  end

  def play_guesser
    @game.randomize
    guess = @guess
    puts "I've chosen my sequence of numbers!".center(@width, " ")
    until @game.win?(guess) || @game.over?(@turn)
      @turn += 1
      puts "This is your last shot!".center(@width, " ") if @turn == @game.turns
      puts
      puts "What is your #{ORDINAL[@turn - 1]} guess?".center(@width, " ")
      puts
      guess = gets.chomp
      if @game.valid?(guess)
        puts
        answer = @game.try(guess)
        puts "Not a single correct number. No hint for you!".center(@width, " ") if answer == ""
        puts "Here is your hint: #{answer}".center(@width, " ") if answer != ""
        puts
      else invalid
      end
      if @game.win?(guess)
        puts "Good lord, you've got it! It was indeed #{@game.code.join}!"
      elsif @game.over?(@turn)
        puts "I'm afraid you're out of guesses. The answer was #{@game.code.join}!"
          .center(@width, " ")
      end
    end
  end

  def play_picker
    until @game.valid?(@game.code)
      print_errors if @errors.any?
      puts
      puts "What sequence of numbers will you set?".center(@width, " ")
      @game.assign gets.chomp
    end
  end

  def start
    introduction
    play_guesser
    reset
  end

  def reset
    puts
    puts "Would you like to play again? (y/n)".center(@width, " ")
    puts
    response = gets.chomp.downcase
    return puts "Farewell! Do come again when you're feeling brainy!" if response != "y"

    @game = Game.new
    @guess = nil
    @turn = 0
    play_guesser
  end

  def invalid_input
    @turn -= 1
    "#{@game.spaces} numbers exactly from 1 to #{@game.digits}, please"
      .center(@width, " ")
  end

  def print_errors
    @errors.each do |error|
      puts error
    end
    @errors.clear
  end
end

game = MasterMind.new
game.start
