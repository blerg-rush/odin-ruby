require './lib/my_enumerables'

RSpec.describe Enumerable do
  describe '.my_select' do
    it 'returns the enumerable if passed without an argument' do
      expect([1, 2, 3].my_select).to eql([1, 2, 3])
    end
  end
end
