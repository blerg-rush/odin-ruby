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
  attr_reader :noose
  HEAD_PART = 'O'
  TORSO_PART = '|'
  LEFT_LIMB_PART = '/'
  RIGHT_LIMB_PART = '\\'

  # zero-indexed
  HEAD = { row: 2, col: 2 }.freeze
  TORSO = { row: 3, col: 2 }.freeze
  LEFT_ARM = { row: 3, col: 1 }.freeze
  RIGHT_ARM = { row: 3, col: 3 }.freeze
  LEFT_LEG = { row: 4, col: 1 }.freeze
  RIGHT_LEG = { row: 4, col: 3 }.freeze

  def initialize(failures = 0)
    @noose = File.open('noose.txt', 'r', &:read).split("\n")
    @width = 24
    @failures = failures
  end

  def add_part
    @failures += 1
    case @failures
    when 1
      @noose[HEAD[:row]][HEAD[:col]] = HEAD_PART
    when 2
      @noose[TORSO[:row]][TORSO[:col]] = TORSO_PART
    when 3
      @noose[LEFT_ARM[:row]][LEFT_ARM[:col]] = LEFT_LIMB_PART
    when 4
      @noose[RIGHT_ARM[:row]][RIGHT_ARM[:col]] = RIGHT_LIMB_PART
    when 5
      @noose[LEFT_LEG[:row]][LEFT_LEG[:col]] = LEFT_LIMB_PART
    when 6
      @noose[RIGHT_LEG[:row]][RIGHT_LEG[:col]] = RIGHT_LIMB_PART
    end
  end

  def hint; end
end

class Hangman
  @display = Display.new
  @game = Game.new

  binding.pry
end

hangman = Hangman.new