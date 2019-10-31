# Handles internal game logic and state
class Game
  attr_reader :hint, :word

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
    response = 'miss'
    return false if @letters_guessed.include? letter

    @letters_guessed << letter

    if @word.include? letter
      update_hint(letter)
      response = 'hit'
    end

    response
  end

  def update_hint(letter)
    @word.chars.each_with_index do |char, index|
      @hint[index] = letter if char == letter
    end
  end

  def misses
    @letters_guessed.count { |guess| !@word.include? guess }
  end

  def bad_letters
    @letters_guessed.reject { |guess| @word.include? guess }
  end

  def over?
    misses >= @guesses
  end

  def win?
    !@hint.include? '_'
  end

  def data=(savedata)
    @guesses = savedata['guesses']
    @word = savedata['word']
    @letters_guessed = savedata['letters_guessed']
    @hint = savedata['hint']
  end

  def data
    { 'guesses' => @guesses,
      'word' => @word,
      'letters_guessed' => @letters_guessed,
      'hint' => @hint }
  end
end