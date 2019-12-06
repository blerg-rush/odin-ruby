require './lib/game'

RSpec.describe Game do
  before(:each) do
    @game = Game.new('Foo', 'Bar')
  end

  describe '#find_player' do
    it 'return any one of player1 or player2 if passed nil' do
      @game.find_player(nil)
      expect([@game.player1, @game.player2]).to include(@game.current_player)
    end

    it 'returns a specific named player if a name is passed in' do
      @game.instance_variable_set(:@current_player, @game.player1)
      expect(@game.find_player('Bar').name).to eql('Bar')
    end
  end

  describe '#play_piece(column)' do
    before(:each) do
      grid = [[1, 2, 1, 1, 1, 2, 1],
              [2, 1, 2, 1, 2, 1, 2],
              [1, 2, 2, 1, 2, 2, 1],
              [1, 2, 1, 1, 1, 2, 1],
              [nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil]]
      @game.board.instance_variable_set(:@grid, grid)
    end

    it "returns false if piece doesn't create winning line" do
      expect(@game.play_piece(0)).to be false
    end

    it "switches current player if piece doesn't create winning line" do
      last_player = @game.current_player
      @game.play_piece(0)
      expect(@game.current_player).to_not eql(last_player)
    end

    it 'returns true if piece creates winning line' do
      @game.instance_variable_set(:@current_player, @game.player1)
      expect(@game.play_piece(3)).to be true
    end
  end
end
