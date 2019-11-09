require './lib/game'

RSpec.describe Game do
  before(:each) do
    @game = Game.new('Foo', 'Bar')
  end

  describe '#pick_first_player' do
    it 'assigns player1 or player2 to current_player' do
    end

    it 'returns nil if randomization is skipped' do
    end

    it 'skips randomization if @game initialized with first_player' do
    end
  end
end
