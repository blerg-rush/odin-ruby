# frozen_string_literal: true

require './lib/tic_tac_toe'

RSpec.describe Board do
  before(:each) do
    @board = Board.new

    def assign_state(value)
      @board.instance_variable_set(:@state, value)
    end
  end

  describe '#win?' do
    it 'checks if the given glyph has won diagonally' do
      assign_state([%w[O O X],
                    %w[X O X],
                    %w[O X O]])
      expect(@board.win?('O')).to be true
    end
  end
end
