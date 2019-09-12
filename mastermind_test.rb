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
end