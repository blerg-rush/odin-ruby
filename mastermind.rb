class Game
  attr_accessor :spaces, :digits, :rounds, :code

  def initialize(digits = 6, spaces = 4, rounds = 12)
    @digits = digits
    @spaces = spaces
    @rounds = rounds
  end

  def randomize
    @code = []
    @spaces.times do
      @code << rand(1..@digits)
    end
  end

  def guess(number)
    digits = number.to_s.split("")
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
end
