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

    it 'checks if the given glyph has won horizontally' do
      assign_state([%w[O O X],
                    %w[X X X],
                    %w[O X O]])
      expect(@board.win?('X')).to be true
    end

    it 'checks if the given glyph has won vertically' do
      assign_state([%w[O O X],
                    %w[O X X],
                    %w[O X O]])
      expect(@board.win?('O')).to be true
    end

    it 'returns false if no glyph has won' do
      assign_state([%w[X O X],
                    %w[O X X],
                    %w[O X O]])
      expect(@board.win?('O')).to be false
    end

    it 'returns false if a glyph other than the one given won' do
      assign_state([%w[X O X],
                    %w[O X X],
                    %w[O X X]])
      expect(@board.win?('O')).to be false
    end

    it 'successfully runs if the board is empty' do
      assign_state([[' ', ' ', ' '],
                    [' ', ' ', ' '],
                    [' ', ' ', ' ']])
      expect { @board.win?('O') }.to_not raise_error
    end
  end

  describe '#full?' do
    it 'returns true if the board is full' do
      assign_state([%w[X O X],
                    %w[O X X],
                    %w[O X X]])
      expect(@board.full?).to be true
    end

    it 'returns false if the board is not full' do
      assign_state([['X', 'O', 'O'],
                    ['O', 'O', 'O'],
                    ['X', 'X', ' ']])
      expect(@board.full?).to be false
    end

    it 'returns false if the board is empty' do
      assign_state([[' ', ' ', ' '],
                    [' ', ' ', ' '],
                    [' ', ' ', ' ']])
      expect(@board.full?).to be false
    end
  end
end
