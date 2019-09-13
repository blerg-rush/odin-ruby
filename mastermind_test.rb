require "minitest/autorun"
require "minitest/pride"
require_relative "mastermind.rb"

class MasterMindTest < Minitest::Test
  describe "randomize" do
    before do
      @game = Game.new
    end

    it "creates a code with the correct number of spaces" do
      @game = Game.new
      @game.spaces = 8
      @game.randomize
      assert_equal 8, @game.code.length
    end

    it "creates a code with the correct digit range" do
      @game = Game.new
      @game.digits = 9
      @game.spaces = 1000
      @game.randomize
      assert(@game.code.max <= 9)
      assert(@game.code.min >= 1)
    end
  end

  describe "pefect digits" do
    before do
      @game = Game.new
    end

    it "returns the correct number of perfect digits" do
      @game.code = %w[3 4 5 6]
      @guess = %w[2 4 5 1]
      assert_equal "PP", @game.perfect_digits(@guess, @game.code)
    end
  end

  describe "misplaced digits" do
    before do
      @game = Game.new
    end

    it "returns the correct number of misplaced digits" do
      @game.code = %w[1 2 5 4]
      @guess = %w[2 2 5 5]
      assert_equal "MM", @game.misplaced_digits(@guess, @game.code)
    end
  end

  describe "guess" do
    before do
      @game = Game.new
    end

    it "returns the correct number of perfect digits" do
      @game.code = %w[1 6 5 2]
      assert_equal "PP", @game.try(1122).to_s
      assert_equal "P", @game.try(2222).to_s
      assert_equal "PPP", @game.try(4652).to_s
      assert_equal "PPPP", @game.try(1652).to_s
      assert_equal "", @game.try(3333).to_s
    end

    it "returns the correct number of present but misplaced digits" do
      @game.code = %w[6 5 4 2]
      assert_equal "MMM", @game.try(2651)
      assert_equal "M", @game.try(1134)
      assert_equal "", @game.try(1111)
      assert_equal "MMMM", @game.try(2456)
    end

    it "returns the correct number of perfect and misplaced digits" do
      @game.code = %w[2 6 4 6]
      assert_equal "PPM", @game.try(2266)
      assert_equal "PMM", @game.try(2464)
      assert_equal "", @game.try(1111)
    end
  end
end