require "pry"

class Game
  WORDS = File.open("5desk.txt", "r", &:read).split("\r\n")
              .select { |word| word.length.between?(5, 12) }

  def initialize
    @word = WORDS.sample
  end
end

game = Game.new
binding.pry