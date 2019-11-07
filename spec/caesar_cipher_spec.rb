require './lib/caesar_cipher.rb'

RSpec.describe '#cipher' do
  it 'shifts a single character' do
    expect(cipher('a', 1)).to eql('b')
  end

end
