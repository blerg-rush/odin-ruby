# Stores player-level information
class Player
  attr_accessor :id
  attr_reader :name

  def initialize(name, id = nil)
    @name = name
    @id = id
  end
end
