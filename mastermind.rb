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
    guess_digits = number.to_s.split("")
    result = []
    code_left = @code.dup
    # Perfect match
    guess_digits.each_with_index do |digit, index|
      next if digit != code_left[index]

      result << "P"
      guess_digits[index] = nil
      code_left[index] = nil
    end
    guess_digits = guess_digits.compact
    code_left = code_left.compact
    # Midplaced match
    guess_digits.each do |digit|
      code_left.each_index do |index|
        next if digit != code_left[index]

        result << "M"
        code_left[index] = nil
        break
      end
    end
    result.join
  end
end
