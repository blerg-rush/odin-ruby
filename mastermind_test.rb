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

  describe "guess" do
    before do
      @game = Game.new
    end

    it "returns the correct number of perfect numbers" do
      @game.code = %w[1 6 5 2]
      assert_equal "PP", @game.guess(1122).to_s
      assert_equal "P", @game.guess(2222).to_s
      assert_equal "PPP", @game.guess(4652).to_s
      assert_equal "PPPP", @game.guess(1652).to_s
      assert_equal "", @game.guess(3333).to_s
    end

    it "returns the correct number of present but misplaced numbers" do
      @game.code = %w[6 5 4 2]
      assert_equal "MMM", @game.guess(2651)
      assert_equal "M", @game.guess(1134)
      assert_equal "", @game.guess(1111)
      assert_equal "MMMM", @game.guess(2456)
    end

    it "returns the proper mix of perfect and misplaced numbers" do
      @game.code = %w[2 6 4 6]
      assert_equal "PPM", @game.guess(2266)
      assert_equal "PMM", @game.guess(2464)
    end
  end
end