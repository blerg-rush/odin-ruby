require 'facets/string/word_wrap'

# Renders visualization of game state
class Display
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

  # Minimum width for 12-letter word: 33
  def initialize(failures = 0)
    @noose = File.open('noose.txt', 'r', &:read).split("\n")
    @width = 60
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

  def load_parts(number)
    number.times { add_part }
  end

  def align_left(string)
    string.ljust(12)
  end

  def align_center(string)
    string.center(@width - 12)
  end

  def hint(hint_array)
    hint_array.join(' ')
  end

  def misses(bad_letters)
    "Misses: #{bad_letters.join(' ')}"
  end

  def wrap_message(message)
    lines = message.word_wrap(@width - 12).split("\n")
    lines.unshift(' ') until lines.size >= 3
    lines[0..2]
  end

  # Options: :hints, :misses, :message
  # :message max length: (@width - 12) * 2
  def draw(opts = {})
    lines = []
    message = wrap_message(opts[:message] || '')
    lines[0] = align_left(@noose[0]) + align_center(hint(opts[:hints]))
    lines[1] = align_left(@noose[1]) + align_center(misses(opts[:misses]))
    lines[2] = @noose[2]
    lines[3] = align_left(@noose[3]) + align_center(message[0])
    lines[4] = align_left(@noose[4]) + align_center(message[1])
    lines[5] = align_left(@noose[5]) + align_center(message[2])
    puts lines
  end
end
