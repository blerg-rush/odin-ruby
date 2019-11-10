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
    end

    it 'returns a Player object' do
      @game = Game.new('Foo', 'Bar', 'Foo')
      expect(@game.pick_first_player).to be_instance_of Player
    end
  end
end
