require './lib/board'

RSpec.describe Board do
  before(:each) do
    @board = Board.new
  end

  describe '#add(column, player)' do
    it 'adds a piece to row 0 of an empty column' do
      @board.add(3, 1)
      expect(@board.grid[0][3]).to eql(1)
    end

    it 'adds a piece to the next empty row of a column' do
      @board.add(0, 2)
      @board.add(0, 2)
      expect(@board.grid[1][0]).to eql(2)
    end

    it 'returns the coordinates of the piece placed' do
      expect(@board.add(6, 1)).to eql([0, 6])
    end

    it 'returns nil if the column index is greater than 6' do
      expect(@board.add(7, 2)).to eql(nil)
    end

    it 'returns nil if the column index is less than 0' do
      expect(@board.add(-1, 1)).to eql(nil)
    end

    it 'returns nil if the column is full' do
      6.times { @board.add(0, 1) }
      expect(@board.add(0, 1)).to eql(nil)
    end
  end

  describe '#full?' do
    it 'returns true if the top row is full' do
      @board.instance_variable_set(@grid[5], Array.new(7, 1))
      expect(@board.full?).to be true
    end

    it 'returns false if the top row is not full' do
      @board.instance_variable_set(@grid[5], [1, 1, nil, 0, 2, 2, 1])
      expect(@board.full?).to be false
    end
  end
end
