# frozen_string_literal: true

require 'pry'

class Game
  WORDS = File.open('5desk.txt', 'r', &:read).split("\r\n")
              .select { |word| word.length.between?(5, 12) }

  def initialize(guesses = 6)
    @guesses = guesses
    @word = WORDS.sample.upcase
    @letters_guessed = []
    @hint = @word.gsub(/./, '_').split('')
  end

  # Expects a single letter, returns the current hint
  def guess(letter)
    letter = letter.upcase
    return false if @letters_guessed.include? letter

    @letters_guessed << letter

    update_hint(letter) if @word.include? letter

    @hint
  end

  def update_hint(letter)
    @word.chars.each_with_index do |char, index|
      @hint[index] = letter if char == letter
    end
  end

  def misses
    @guesses.count { |guess| !@word.include? guess }
  end

  def over?
    misses >= @guesses
  end
end

class Display
  HEAD = 'O'
  TORSO = '|'
  LEFT_LIMB = '/'
  RIGHT_LIMB = '\\'

  def initialize
    @noose = File.open('noose.txt', 'r', &:read).split("\n")
    @failures = 0
  end
end

class Hangman
  @display = Display.new
  @game = Game.new
end

