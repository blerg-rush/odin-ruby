# frozen_string_literal: true

require 'pry'

class Game
  WORDS = File.open('5desk.txt', 'r', &:read).split("\r\n")
              .select { |word| word.length.between?(5, 12) }

  def initialize(guesses = 6)
    @guesses = guesses
    @word = WORDS.sample.downcase
    @letters_guessed = []
    @hint = @word.gsub(/./, '_').split('')
  end

  def guess(letter)
    letter = letter.downcase
    return false if @letters_guessed.include? letter

    @letters_guessed << letter

    update_hint(letter) if @word.include? letter

    @hint
  end

  def update_hint(letter); end

  def misses; end

  def game_over; end
end

game = Game.new
binding.pry
