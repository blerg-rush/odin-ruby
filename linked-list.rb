require 'pry'

class LinkedList
  attr_accessor :head

  def initialize
    @head = nil
  end

  def append(node)
    return @head = node if @head.nil?

    current_node = @head
    current_node = current_node.next_node until current_node.next_node.nil?

    current_node.next_node = node
  end

  def prepend(node)
    node.next_node = @head
    @head = node
  end

  def size
    return 0 if @head.nil?

    current_node = @head
    number_of_nodes = 1
    until current_node.next_node.nil?
      number_of_nodes += 1
      current_node = current_node.next_node
    end
    number_of_nodes
  end
end

class Node
  attr_accessor :value, :next_node

  def initialize
    @value = nil
    @next_node = nil
  end
end

# list = LinkedList.new
# node1 = Node.new
# node1.value = 1
# list.prepend node1
# puts list.size
# node2 = Node.new
# node2.value = 2
# list.append node2
# puts list.size
# node3 = Node.new
# node3.value = 3
# list.append node3
# puts list.size
# p list.head
# p list.head.next_node
# node4 = Node.new
# node4.value = 4
# list.prepend node4
# puts list.size
# p list.head
# p list.head.next_node
