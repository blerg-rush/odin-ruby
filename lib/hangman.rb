# frozen_string_literal: true

require 'pry'

class Game
  WORDS = File.open('5desk.txt', 'r', &:read).split("\r\n")
              .select { |word| word.length.between?(5, 12) }

  def initialize(guesses = 6)
    @word = WORDS.sample.downcase
    @letters_guessed = []
    @guesses = guesses
    @hint = @word.gsub(/./, '_').split('')
  end

  def guess(letter)
    # downcase letter
    # Return false if letter already guessed

    # Add letter to letters guessed

    # Check letter against word
    #  If correct, update hint

    # Return hint
  end

  def update_hint(letter); end

  def misses; end

  def game_over; end
end

game = Game.new
binding.pry
