require './lib/caesar_cipher.rb'

RSpec.describe '#cipher' do
  it 'shifts a single character' do
    expect(cipher('a', 1)).to eql('b')
  end

  it 'shifts left on negative offset' do
    expect(cipher('b', -1)).to eql('a')
  end

  it 'wraps from z to a' do
    expect(cipher('z', 1)).to eql('a')
  end

  it 'wraps from a to z' do
    expect(cipher('a', -1)).to eql('z')
  end

  it 'shifts an entire word' do
    expect(cipher('foo', 5)).to eql('ktt')
  end

  it 'ignores spaces' do
    expect(cipher('foo bar', -19)).to eql('mvv ihy')
  end

  it 'ignores non-alphabet characters' do
    expect(cipher('a!#&*1', 5)).to eql('f!#&*1')
  end
end
