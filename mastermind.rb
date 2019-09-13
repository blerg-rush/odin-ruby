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
      @code << rand(1..@digits)
    end
  end

  def try(guess)
    digits = guess.split("")
    unmatched = @code.dup
    p "debug code: " + unmatched.inspect
    result = []
    result << perfect_digits(digits, unmatched)
    result << misplaced_digits(digits, unmatched)
    result.join
  end

  def perfect_digits(guess, code)
    puts "Perfect: " + guess.inspect
    result = []
    guess.each_with_index do |digit, index|
      next if digit != code[index]

      result << "P"
      code[index] = nil
    end
    result.join
  end

  def misplaced_digits(guess, code)
    puts "Mistplaced: " + guess.inspect
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
    guess == @code.join.to_s
  end

  def over?(turn)
    turn >= @turns
  end
end

class MasterMind
  ORDINAL = %w[first second third fourth fifth sixth seventh eighth ninth
    tenth eleventh twelfth thirteenth fourteenth fifteenth
    sixteenth seventeenth eighteenth nineteenth twentieth]

  def initialize
    @width = 80
    @game = Game.new
    @guess = nil
    @turn = 0
    @quit = false
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

  def play
    @game.randomize
    guess = @guess
    turn = @turn
    puts "I've chosen my sequence of numbers!".center(@width, " ")
    until @game.win?(guess) || @game.over?(@turn)
      turn += 1
      puts "This is your last shot!" if @turn == @game.turns
      puts
      puts "What is your #{ORDINAL[turn - 1]} guess?".center(@width, " ")
      puts
      guess = gets.chomp
      puts
      answer = @game.try(guess)
      p "debug answer:" + answer
      puts "Not a single correct number. No hint for you!".center(@width, " ") if answer == ""
      puts "Here is your hint: #{answer}".center(@width, " ") if answer != ""
      puts
      if @game.win?(@guess)
        puts "Good lord, you've got it! It was indeed #{@game.code}!"
      elsif @game.over?(turn)
        puts "I'm afraid you're out of guesses. The answer was #{@game.code}!"
          .center(@width, " ")
      end
    end
  end

  def start
    introduction
    play
  end

  def reset
    @game = Game.new
    @guess = nil
    @turn = 0
  end

  # puts
  # puts "Would you like to try again? (y/n)".center(@width, " ")
  # replay = gets.chomp.downcase
  # @quit = replay != "y"

  # puts
  # puts "Farewell! Do come again when you're feeling brainy!".center(@width, " ")
  # puts
end

game = MasterMind.new
game.start
