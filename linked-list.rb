class LinkedList
  attr_accessor :head

  def initialize
    @head = nil
  end
end

class Node
  attr_accessor :value, :next_node

  def initialize
    @value = nil
    @next_node = nil
  end
end