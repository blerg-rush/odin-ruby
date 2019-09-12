class Game
  attr_accessor :spaces, :digits, :rounds, :code

  def initialize(digits = 6, spaces = 4, rounds = 12)
    self.digits = digits
    self.spaces = spaces
    self.rounds = rounds
  end

  def randomize
    self.code = []
    spaces.times do
      code << rand(1..@digits)
    end
  end
end
