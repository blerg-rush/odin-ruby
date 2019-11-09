require './lib/game'

RSpec.describe Game do
  before(:each) do
    @game = Game.new('Foo', 'Bar')
  end

  describe '#pick_first_player' do
    it 'assigns one of player1 or player2 to current_player' do
      @game.pick_first_player
      expect([@game.player1, @game.player2]).to include(@game.first_player)
    end

    it 'returns a Player object' do
      @game = Game.new('Foo', 'Bar', 'Foo')
      expect(@game.pick_first_player).to be_instance_of Player
    end
  end
end
