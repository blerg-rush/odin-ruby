require './lib/my_enumerables'

RSpec.describe Enumerable do
  describe '.my_select' do
    it 'returns the enumerable if passed without an argument' do
      expect([1, 2, 3].my_select).to eql([1, 2, 3])
    end

    it 'returns an array of values that evaluate to true' do
      expect([1, 2, 3].my_select { |num| num.odd? }).to eql([1, 3])
    end

    it 'allows a symbol to be passed instead of a block' do
      expect([1, 2, 3].my_select(&:odd?)).to eql([1, 3])
    end

    it 'returns an empty array if no values evaluate to true' do
      expect([1, 3, 5, 7].my_select(&:even?)).to eql([])
    end
  end
end
