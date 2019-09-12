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
    guess_digits = number.to_s.split
    result = []
    code_remaining = @code
    guess_digits.each_with_index do |digit, index|
      
    end
  end
end
